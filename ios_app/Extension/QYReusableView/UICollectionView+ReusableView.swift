//
//  UICollectionView+QYReusableView.swift
//  QYBaseGeneral
//
//  Created by cyd on 2020/3/13.
//

import UIKit

enum QYCollectionViewElementKind {
    case header, footer
    var type: String {
        switch self {
        case .header:
            return UICollectionView.elementKindSectionHeader
        case .footer:
            return UICollectionView.elementKindSectionFooter
        }
    }
}

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(_ : Cell.Type) {
        self.register(Cell.self,
                           forCellWithReuseIdentifier: Cell.defaultReuseIdentifier)
    }
    
    func register<View: UICollectionReusableView>(_ : View.Type, forSupplementaryViewElementOfKind kind: QYCollectionViewElementKind) {
        self.register(View.self,
                           forSupplementaryViewOfKind: kind.type,
                           withReuseIdentifier: View.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.defaultReuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.defaultReuseIdentifier)")
        }
        return cell
    }
    func dequeueReusableSupplementaryView<View: UICollectionReusableView>(ofKind elementKind: QYCollectionViewElementKind, for indexPath: IndexPath) -> View {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: elementKind.type, withReuseIdentifier: View.defaultReuseIdentifier, for: indexPath) as? View else {
            fatalError("Could not dequeue supplementary view with identifier: \(View.defaultReuseIdentifier)")
        }
        return view
    }
}
