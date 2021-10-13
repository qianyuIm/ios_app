//
//  UITableView+QYReusableView.swift
//  QYBaseGeneral
//
//  Created by cyd on 2020/3/13.
//

import UIKit

extension UITableView {
    func register<Cell: UITableViewCell>(_ : Cell.Type) {
        self.register(Cell.self,
                           forCellReuseIdentifier: Cell.defaultReuseIdentifier)
    }
    
    func registerHeaderFooterView<View: UITableViewHeaderFooterView>(_ : View.Type) {
        self.register(View.self,
                           forHeaderFooterViewReuseIdentifier: View.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.defaultReuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.defaultReuseIdentifier)")
        }
        return cell
    }
    func dequeueReusableHeaderFooterView<View: UITableViewHeaderFooterView>() -> View {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: View.defaultReuseIdentifier) as? View else {
            fatalError("Could not dequeue supplementary view with identifier: \(View.defaultReuseIdentifier)")
        }
        return view
    }
}
