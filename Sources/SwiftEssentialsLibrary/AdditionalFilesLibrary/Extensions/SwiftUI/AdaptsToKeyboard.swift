//
//  AdaptsToKeyboard.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2/12/24.
//

import SwiftUI
import Combine

//using keyboard responder as observedobject was more reliable
@MainActor
final class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter
    @Published public private(set) var currentHeight: CGFloat = 0

    public init(center: NotificationCenter = .default) {
        notificationCenter = center
        //was getting "work performed off main thread" with these
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification, object: self, queue: .main) { [weak self] notif in
//            self?.keyBoardWillShow(notification: notif)
//        }
//        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: self, queue: .main) { [weak self] notif in
//            self?.keyBoardWillHide(notification: notif)
//        }
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        DispatchQueue.main.async {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.currentHeight = keyboardSize.height
            }
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        DispatchQueue.main.async {
            self.currentHeight = 0
        }
    }
}


struct AdaptsToKeyboard: ViewModifier {
    @State var currentHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.currentHeight)
                .onAppear(perform: {
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                        .compactMap { notification in
                            withAnimation(.easeOut(duration: 0.16)) {
                                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                            }
                    }
                    .map { rect in
                        rect.height - geometry.safeAreaInsets.bottom
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                    
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
                        .compactMap { notification in
                            CGFloat.zero
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                })
        }
        .onChange(of: currentHeight) { val in
            print(currentHeight, "UPDATED HEIGHT")
        }
    }
}

extension View {
    func adaptsToKeyboard() -> some View {
        return modifier(AdaptsToKeyboard())
    }
}
