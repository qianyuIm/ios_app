//
//  QYHomeController.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import UIKit

class QYHomeController: QYBaseVMController {
    private lazy var searchItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: R.image.icon_navigation_search(),style: .plain, target: self, action: #selector(handleSearchAction))
        return item
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sender = UIButton(type: .system)
        sender.setTitle("更改Theme", for: .normal)
        sender.rx.tap.subscribe { _ in
            QYMapLocationManager.shared.singleLocation(withReGeocode: true) { location, regeocode, error in
                if let error = error {
                    QYLogger.error(error.errorDescription)
                    return
                }
                QYLogger.debug("regeocode => \(regeocode)")

            }

        }.disposed(by: rx.disposeBag)
        
        view.addSubview(sender)
        sender.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.navigationItem.leftBarButtonItem = searchItem
        navigationItem.title = "首页"
    }
    
    @objc func handleSearchAction() {
        let vc = QYBaseController()
        navigationController?.pushViewController(vc, completion: nil)
    }
    
    
}
