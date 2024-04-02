//
//  UITableView+ReloadCompletion.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/11.
//

import UIKit

class UITableViewWithReloadCompletion: UITableViewWithButtons {
    
    private var reloadDataCompletionBlock: (() -> Void)? = nil
    var persistentCompletionBlock: (() -> Void)?
    
    init(style: UITableView.Style = .plain, persistentCompletionBlock: (() -> Void)? = nil) {
        super.init(frame: .null, style: style)
        self.persistentCompletionBlock = persistentCompletionBlock
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if let reloadDataCompletionBlock {
            reloadDataCompletionBlock()
        } else {
            persistentCompletionBlock?()
        }
        reloadDataCompletionBlock = nil
    }

    func reloadDataWithSpecificCompletion(completion: @escaping () -> Void) {
        reloadDataCompletionBlock = completion
        self.reloadData()
    }
    
}
