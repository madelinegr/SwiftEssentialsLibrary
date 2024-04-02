//
//  UITableView+ReloadCompletion.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/11.
//

import UIKit

open class UITableViewWithReloadCompletion: UITableViewWithButtons {
    
    private var reloadDataCompletionBlock: (() -> Void)? = nil
    public var persistentCompletionBlock: (() -> Void)?
    
    public init(style: UITableView.Style = .plain, persistentCompletionBlock: (() -> Void)? = nil) {
        super.init(frame: .null, style: style)
        self.persistentCompletionBlock = persistentCompletionBlock
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        if let reloadDataCompletionBlock {
            reloadDataCompletionBlock()
        } else {
            persistentCompletionBlock?()
        }
        reloadDataCompletionBlock = nil
    }

    public func reloadDataWithSpecificCompletion(completion: @escaping () -> Void) {
        reloadDataCompletionBlock = completion
        self.reloadData()
    }
    
}
