//
//  EventQueue.swift
//  PICTOCHAT
//
//  Created by Adam Novak on 5/31/23
//

import UIKit

class EventQueue {
    
    private var eventQueue: [(()->Void)] = []
    private let timeInterval: TimeInterval = 1
    private let semaphore = DispatchSemaphore(value: 1)
    
    private let synchronizationQueue = DispatchQueue(label: "com.PICTOCHAT.EventQueue.synchronizationQueue")

    func queueUpEvent(_ event: @escaping ()->Void) {
        synchronizationQueue.async { [weak self] in
            self?.appendEvent(event)
        }
    }

    private func appendEvent(_ event: @escaping ()->Void) {
        eventQueue.append(event)

        if eventQueue.count == 1 {
            dispatchNextEvent(waitTime: 0)
        }
    }

//    func queueUpEvent(_ event: @escaping ()->Void) {
//        // Lock the critical section to ensure thread-safety
//        semaphore.setTarget(queue: .main)
//        semaphore.wait()
//        defer { semaphore.signal() }
//
//        eventQueue.append(event)
//
//        // Check if eventQueue was empty before appending the event
//        // If true, start dispatching events
//        if eventQueue.count == 1 {
//            dispatchNextEvent(waitTime: 0)
//        }
//    }
    
    private func dispatchNextEvent(waitTime: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + waitTime) { [weak self] in
            guard let self = self else { return }
            
            // Lock the critical section to ensure thread-safety
            self.semaphore.wait()
            defer { self.semaphore.signal() }
            
            if !self.eventQueue.isEmpty {
                let event = self.eventQueue.removeFirst()
                event()
            }
            
            // Continue dispatching events if the queue is not empty
            if !self.eventQueue.isEmpty {
                self.dispatchNextEvent(waitTime: self.timeInterval) //always wait timeInterval
            }
        }
    }
}
