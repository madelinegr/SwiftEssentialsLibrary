//
//  VideoPlayer.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/06/01.
//

import AVFoundation
import UIKit
import Combine

class PlayerView: UIView {

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}

protocol VideoPlayerDelegate {
    func downloadedProgress(progress:Double)
    func readyToPlay()
    func didChangeTime(progress:Double, seconds:Double)
    func didFinishPlayItem()
    func didFailPlayToEnd()
    func didStartPlaying()
    func didPausePlaying()
}

class VideoPlayer : NSObject {

    private var assetPlayer:AVPlayer?
    private var playerItem:AVPlayerItem?
    private var urlAsset:AVURLAsset?
    private var videoOutput:AVPlayerItemVideoOutput?

    private var assetDuration:Double = 0
    private var playerView:PlayerView?

    private var autoRepeatPlay:Bool = true
    private var autoPlay:Bool = true

    var delegate:VideoPlayerDelegate?
    
    let videoContext: UnsafeMutableRawPointer? = nil

    var playerRate:Float = 1 {
        didSet {
            if let player = assetPlayer {
                player.rate = playerRate > 0 ? playerRate : 0.0
            }
        }
    }

    var volume:Float = 1.0 {
        didSet {
            if let player = assetPlayer {
                player.volume = volume > 0 ? volume : 0.0
            }
        }
    }
    var currentTimeSeconds: Double? {
        return assetPlayer == nil ? nil : CMTimeGetSeconds(assetPlayer!.currentTime())
    }

    // MARK: - Init

    convenience init(urlAsset:NSURL, view:PlayerView, startAutoPlay:Bool = true, repeatAfterEnd:Bool = true) {
        self.init()

        playerView = view
        autoPlay = startAutoPlay
        autoRepeatPlay = repeatAfterEnd

        if let playView = playerView, let playerLayer = playView.layer as? AVPlayerLayer {
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        }
        //play audio even on silent
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
          print(error)
        }
        //immediately resume even after switching audio input sources
        NotificationCenter.default.addObserver(self, selector: #selector(audioRouteChanged), name: AVAudioSession.routeChangeNotification, object: nil)
        
        initialSetupWithURL(url: urlAsset)
        prepareToPlay()
    }

    override init() {
        super.init()
    }

    // MARK: - Public

    func isPlaying() -> Bool {
        if let player = assetPlayer {
            return player.rate > 0
        } else {
            return false
        }
    }

    func seekToPosition(seconds:Float64) {
        if let player = assetPlayer {
            pause()
            if let timeScale = player.currentItem?.asset.duration.timescale {
                player.seek(to: CMTimeMakeWithSeconds(seconds, preferredTimescale: timeScale), completionHandler: { (complete) in
                    self.play()
                })
            }
        }
    }

    func pause() {
        if let player = assetPlayer {
            player.pause()
        }
    }

    func play() {
        if let player = assetPlayer {
            if (player.currentItem?.status == .readyToPlay) {
                player.play()
                player.rate = playerRate
            }
        }
    }

    func cleanUp() {
        if let item = playerItem {
            item.removeObserver(self, forKeyPath: "status")
            item.removeObserver(self, forKeyPath: "loadedTimeRanges")
        }
        NotificationCenter.default.removeObserver(self)
        assetPlayer = nil
        playerItem = nil
        urlAsset = nil
    }

    // MARK: - Private
    
    @objc private func audioRouteChanged(note: Notification) {
        assetPlayer?.play()
    }

    private func prepareToPlay() {
        let keys = ["tracks"]
        if let asset = urlAsset {
            asset.loadValuesAsynchronously(forKeys: keys, completionHandler: {
                DispatchQueue.main.async {
                    self.startLoading()
                }
            })
        }
    }
    
    var isPlayingCancellable: AnyCancellable?
    private func startLoading(){
        var error:NSError?
        guard let asset = urlAsset else {return}
        let status:AVKeyValueStatus = asset.statusOfValue(forKey: "tracks", error: &error)

        if status == AVKeyValueStatus.loaded {
            assetDuration = CMTimeGetSeconds(asset.duration)

            let videoOutputOptions = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)]
            videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: videoOutputOptions)
            playerItem = AVPlayerItem(asset: asset)
            if let item = playerItem {
                item.addObserver(self, forKeyPath: "status", options: .initial, context: videoContext)
                item.addObserver(self, forKeyPath: "loadedTimeRanges", options: [.new, .old], context: videoContext)
                
                NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(didFailedToPlayToEnd), name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: nil)

                if let output = videoOutput {
                    item.add(output)

                    item.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithm.varispeed
                    assetPlayer = AVPlayer(playerItem: item)

                    if let player = assetPlayer {
                        player.rate = playerRate
                    }

                    addAssetPlayerObservers()
                    if let playView = playerView, let layer = playView.layer as? AVPlayerLayer {
                        layer.player = assetPlayer
                    }
                }
            }
        }
    }

    private func addAssetPlayerObservers() {
//        let timeInterval = CMTimeMakeWithSeconds(0.1, preferredTimescale: 10) //every 0.1 seconds
        let timeInterval = CMTimeMakeWithSeconds(0.01, preferredTimescale: 600) //every 0.01 seconds. this serves as a "videoDidStart", since that keypath is not workign properly for me
//        let timeInterval = CMTimeMake(value: 1, timescale: 1) //every 1 second

        if let player = assetPlayer {
            player.addPeriodicTimeObserver(forInterval: timeInterval, queue: DispatchQueue.main, using: { (time) in
                self.playerDidChangeTime(time: time)
            })
            player.addObserver(self, forKeyPath: "timeControlStatus", options: [.initial, .new, .old], context: videoContext) //not working for me
            player.addObserver(self, forKeyPath: "rate", options: [.initial,.new, .old], context: videoContext)
        }
        
    }
    //last resort... this method: https://stackoverflow.com/questions/7893416/avplayer-is-not-readyfordisplay-does-not-show

    private func playerDidChangeTime(time:CMTime) {
        if let player = assetPlayer {
            let timeNow = CMTimeGetSeconds(player.currentTime())
            let progress = timeNow / assetDuration

            delegate?.didChangeTime(progress: progress, seconds: timeNow)
        }
    }

    @objc private func playerItemDidReachEnd() {
        delegate?.didFinishPlayItem()

        if let player = assetPlayer {
            player.seek(to: CMTime.zero)
            if autoRepeatPlay == true {
                play()
            }
        }
    }

    @objc private func didFailedToPlayToEnd() {
        delegate?.didFailPlayToEnd()
    }

    private func playerDidChangeStatus(status:AVPlayer.Status) {
        if status == .failed {
            print("Failed to load video")
        } else if status == .readyToPlay, let player = assetPlayer {
            volume = player.volume
            delegate?.readyToPlay()

            if autoPlay == true && player.rate == 0.0 {
                play()
            }
        }
    }
    
    private func playerDidChangeTimeControlStatus(status:AVPlayer.TimeControlStatus) {
        switch status {
        case .paused:
            delegate?.didPausePlaying()
        case .playing:
            delegate?.didStartPlaying()
        case .waitingToPlayAtSpecifiedRate:
            break
        @unknown default:
            break
        }
    }
    
    private func moviewPlayerLoadedTimeRangeDidUpdated(ranges:Array<NSValue>) {
        var maximum:TimeInterval = 0
        for value in ranges {
            let range:CMTimeRange = value.timeRangeValue
            let currentLoadedTimeRange = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration)
            if currentLoadedTimeRange > maximum {
                maximum = currentLoadedTimeRange
            }
        }
        let progress:Double = assetDuration == 0 ? 0.0 : Double(maximum) / assetDuration

        delegate?.downloadedProgress(progress: progress)
    }

    deinit {
        cleanUp()
    }

    private func initialSetupWithURL(url:NSURL) {
        let options = [AVURLAssetPreferPreciseDurationAndTimingKey : true]
        urlAsset = AVURLAsset(url: url as URL, options: options)
    }

    // MARK: - Observations
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let assetPlayer, let keyPath else { return }
        if keyPath == "status" {
            playerDidChangeStatus(status: assetPlayer.status)
        } else if keyPath == "loadedTimeRanges", let item = playerItem {
            moviewPlayerLoadedTimeRangeDidUpdated(ranges: item.loadedTimeRanges)
        } 
//        else if keyPath == "timeControlStatus" {
//            print("TCSTATUS UPDATE, RATE:", assetPlayer.rate)
//            playerDidChangeTimeControlStatus(status: assetPlayer.timeControlStatus)
//        }
        if keyPath == "rate" {
            playerDidChangeTimeControlStatus(status: assetPlayer.rate == 0 ? AVPlayer.TimeControlStatus.paused : AVPlayer.TimeControlStatus.playing)
//            if (object as? AVPlayer)!.rate > 0 {
//                print("video started")
//            }
        }
    }
    
}

