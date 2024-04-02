//
//  SwiftUIKit+UITableView.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/12/10.
//

import UIKit

public extension UITableView {

    @discardableResult
    func sRegister<T: UITableView>(_ cellClass: AnyClass) -> T {
        let identifier = String(describing: cellClass)
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        return self as! T
    }

    @discardableResult
    func sShowsScrollIndicators<T: UITableView>(vertical: Bool? = nil, horizontal: Bool? = nil) -> T {
        if let v = vertical {
            self.showsVerticalScrollIndicator = v
        }
        if let h = horizontal {
            self.showsHorizontalScrollIndicator = h
        }
        return self as! T
    }

    @discardableResult
    func sContentInset<T: UITableView>(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> T {
        if let t = top {
            self.contentInset.top = t
        }
        if let l = left {
            self.contentInset.left = l
        }
        if let b = bottom {
            self.contentInset.bottom = b
        }
        if let r = right {
            self.contentInset.right = r
        }
        return self as! T
    }

    @discardableResult
    func sSeparator<T: UITableView>(style: UITableViewCell.SeparatorStyle? = nil, color: UIColor? = nil) -> T {
        if let s = style {
            self.separatorStyle = s
        }
        if let c = color {
            self.separatorColor = c
        }
        return self as! T
    }

    @discardableResult
    func sDelegate<T: UITableView>(_ delegate: UITableViewDelegate) -> T {
        self.delegate = delegate
        self.allowsSelection
        return self as! T
    }
    
    @discardableResult
    func sAllowsSelection<T: UITableView>(_ allowsSections: Bool) -> T {
        self.allowsSelection = allowsSections
        return self as! T
    }

    @discardableResult
    func sDataSource<T: UITableView>(_ dataSource: UITableViewDataSource) -> T {
        self.dataSource = dataSource
        return self as! T
    }
    
    func sDequeue<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }

}
