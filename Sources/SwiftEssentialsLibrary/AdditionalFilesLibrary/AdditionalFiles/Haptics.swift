//
//  Haptics.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/07/26.
//

import Foundation
import UIKit
import CoreHaptics

public class Haptics: NSObject {
    
    static let introVid = Haptics()
    static let outcome = Haptics()
    static let twodrop = Haptics()
    static let camera = Haptics()

    //MARK: - Standard
    
    public enum StandardizedHaptic {
        case light, medium, heavy
    }
    
    public static func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat = 1) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred(intensity: intensity)
    }
    
    private static func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }

    public static func play(_ standardizedHaptic: StandardizedHaptic) {
        switch standardizedHaptic {
        case .light:
            play(.light, intensity: 0.55)
        case .medium:
            play(.medium, intensity: 0.8)
        case .heavy:
            play(.rigid, intensity: 1)
        }
    }
    
    public var engine: CHHapticEngine? = nil
    public var rumblePlayer: CHHapticAdvancedPatternPlayer? = nil
    public var player: CHHapticAdvancedPatternPlayer? = nil
    
    public func stop() {
        try? player?.cancel()
        try? rumblePlayer?.cancel()
    }
    
    public func pause(time: Double) {
        try? player?.pause(atTime: time)
        try? rumblePlayer?.pause(atTime: time)
    }
    
    public func resume(time: Double) {
        try? player?.resume(atTime: time)
        try? rumblePlayer?.resume(atTime: time)
    }
    
    //MARK: - Twodrop
    
    public func playTwodropHaptics(duration: Double) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
            rumblePlayer = try engine!.makeAdvancedPlayer(with: CHHapticPattern(events: twodropHapticEvents(duration: duration), parameterCurves: twodropParamCurve(duration: duration)))
            try rumblePlayer!.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    public func twodropParamCurve(duration: Double) -> [CHHapticParameterCurve] {
        return [
            CHHapticParameterCurve(
                parameterID: .hapticIntensityControl,
                controlPoints: [
                    .init(relativeTime: 0, value: 0),
                    .init(relativeTime: duration, value: 1),
                ],
                relativeTime: 0)
        ]
    }
    public func twodropHapticEvents(duration: Double) -> [CHHapticEvent] {
        let buildUpHaptic = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5),
                CHHapticEventParameter(parameterID: .attackTime, value: 0),],
            relativeTime: 0,
            duration: duration)
        return [buildUpHaptic]
    }
    
    //MARK: - Camera
    
    public func playCameraHaptics(duration: Double, maxDuration: Double? = nil) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
            rumblePlayer = try engine!.makeAdvancedPlayer(with: CHHapticPattern(events: cameraHapticEvents(duration: duration, maxDuration: maxDuration), parameterCurves: cameraParamCurve(duration: duration, maxDuration: maxDuration)))
            try rumblePlayer!.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    public func cameraParamCurve(duration: Double, maxDuration: Double? = nil) -> [CHHapticParameterCurve] {
        var controlPoints: [CHHapticParameterCurve.ControlPoint] = [
            .init(relativeTime: 0, value: 0.1),
            .init(relativeTime: duration, value: 0.4),
        ]
        var lastRelativeTime = duration
        if let maxDuration {
            controlPoints.append(.init(relativeTime: lastRelativeTime + maxDuration, value: 1))
        } else {
            for _ in 0..<30 {
                controlPoints.append(.init(relativeTime: lastRelativeTime + 1, value: 0.7))
                controlPoints.append(.init(relativeTime: lastRelativeTime + 2, value: 0.6))
                lastRelativeTime += 2
            }
        }
        return [
            CHHapticParameterCurve(
                parameterID: .hapticIntensityControl,
                controlPoints: controlPoints,
                relativeTime: 0)
        ]
    }
    public func cameraHapticEvents(duration: Double, maxDuration: Double? = nil) -> [CHHapticEvent] {
        var events: [CHHapticEvent] = []
        let buildUpHaptic = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2),
                CHHapticEventParameter(parameterID: .attackTime, value: 0),],
            relativeTime: 0,
            duration: 60)
        events.append(buildUpHaptic)
        if let maxDuration {
            for i in 1..<Int(maxDuration) {
                events.append(CHHapticEvent(eventType: .hapticTransient,
                                            parameters: [CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6),
                                                         CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9)],
                                            relativeTime: duration + Double(i)))
            }
        }
        return events
    }
    
    //MARK: - Outcome
    
    public func playOutcomeHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
            rumblePlayer = try engine!.makeAdvancedPlayer(with: CHHapticPattern(events: outcomeHapticRumbeEvents, parameterCurves: OutcomeParamCurve))
            try rumblePlayer!.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    let OutcomeDuration: Double = 10
    lazy var OutcomeParamCurve: [CHHapticParameterCurve] = {
        return [
            CHHapticParameterCurve(
                parameterID: .hapticIntensityControl,
                controlPoints: [
                    .init(relativeTime: 0, value: 0), //just needs to start at any time relatively soon enough
                    .init(relativeTime: 1, value: 1),
                    .init(relativeTime: OutcomeDuration, value: 0),
                ],
                relativeTime: 0)
        ]
    }()
    lazy var outcomeHapticEvents: [CHHapticEvent] = { [self] in
        let buildUpHaptic = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5),
                CHHapticEventParameter(parameterID: .attackTime, value: 1),],
            relativeTime: 0, //not sure why, but it seems to take around a second for the continuous haptic to setup and get ready
            duration: OutcomeDuration)
        return [buildUpHaptic]
    }()
    lazy var outcomeHapticRumbeEvents: [CHHapticEvent] = { [self] in
        let buildUpHaptic = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5),
                CHHapticEventParameter(parameterID: .attackTime, value: 1),],
            relativeTime: 0, //not sure why, but it seems to take around a second for the continuous haptic to setup and get ready
            duration: OutcomeDuration)
        return [buildUpHaptic]
    }()
    
    //MARK: - Intro Vid
    
    public func playIntoVidHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
            player = try engine!.makeAdvancedPlayer(with: CHHapticPattern(events: introVidHapticEvents, parameterCurves: []))
            try player!.start(atTime: 0)
            
            rumblePlayer = try engine!.makeAdvancedPlayer(with: CHHapticPattern(events: introVidHapticRumbeEvents, parameterCurves: IntroVidParamCurve))
            try rumblePlayer!.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    lazy var IntroVidParamCurve: [CHHapticParameterCurve] = {
        return [
            CHHapticParameterCurve(
                parameterID: .hapticIntensityControl,
                controlPoints: [
                    .init(relativeTime: ReelStartTime - 2, value: 1), //just needs to start at any time relatively soon enough
                    .init(relativeTime: ReelStartTime + 1, value: 1),
                    .init(relativeTime: ReelStartTime + 3, value: 0.3),
                    .init(relativeTime: ReelStartTime + 8, value: 0.3),
                    .init(relativeTime: ReelFinishTime, value: 1),
                ],
                relativeTime: 0)
        ]
    }()
    let ReelStartTime = 24.92
    let ReelFinishTime = 40.76
    let TypingHapticParams = [CHHapticEventParameter(parameterID: .hapticSharpness, value: 1),
                              CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)]
    let CameraClickHapticParams = [CHHapticEventParameter(parameterID: .hapticSharpness, value: 1),
                                   CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)]
    
    let IntroHapticDelay: Double = 0.1
    lazy var introVidHapticEvents: [CHHapticEvent] = { [self] in
        var events = [CHHapticEvent]()
        
        let cameraHapticTimes: [TimeInterval] = [10.78, 11.38, 12, 16.25, 16.87, 17.5, 31.4, 32.75, 33.95, 35.0, 35.88, 36.59, 37.22, 37.72, ReelFinishTime].map({ $0 - IntroHapticDelay }) //star them all a tad bit earlier
        for time in cameraHapticTimes {
            events.append(CHHapticEvent(eventType: .hapticTransient, parameters: CameraClickHapticParams, relativeTime: time))
        }
        
        let typingHapticTimes: [(TimeInterval,TimeInterval,TimeInterval)] = [
            (1.41,3.41,0.05),(8.82, 10.41,0.1),(14.54,15.81,0.1),(19.28, 21.50,0.15),(23.16, 23.98,0.1),(27.85, 29.38,0.2),(41.31, 43.27,0.15),(47.28, 49.46,0.15)].map({ ($0.0 - IntroHapticDelay,$0.1,$0.2)  })
        for (start, end, duration) in typingHapticTimes {
            for i in stride(from: start, to: end, by: duration) {
                let event = CHHapticEvent(eventType: .hapticTransient, parameters: TypingHapticParams, relativeTime: i)
                events.append(event)
            }
        }
        
        return events
    }()
    
    lazy var introVidHapticRumbeEvents: [CHHapticEvent] = { [self] in
        let buildUpHaptic = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5),
                CHHapticEventParameter(parameterID: .attackTime, value: 1),],
            relativeTime: ReelStartTime - 0.75, //not sure why, but it seems to take around a second for the continuous haptic to setup and get ready
            duration: ReelFinishTime - ReelStartTime + 0.75)
        
        return [buildUpHaptic]
    }()
    
}
