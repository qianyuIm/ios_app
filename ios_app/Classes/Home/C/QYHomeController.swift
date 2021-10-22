//
//  QYHomeController.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import UIKit
import RxSwift
import RxCocoa

class QYHomeController: QYBaseCollectionVMController {
    let searchItemDidTap = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "首页"
    }
    
    @objc func handleSearchAction() {
        let vc = QYBaseController()
        navigationController?.pushViewController(vc, completion: nil)
    }
    override func _setupUI() {
        super._setupUI()
        let searchItem = UIBarButtonItem()
        searchItem.image = R.image.icon_navigation_search()
        searchItem.rx.tap
            .bind(to: searchItemDidTap)
            .disposed(by: rx.disposeBag)
        self.navigationItem.leftBarButtonItem = searchItem
    }
    override func _bindViewModel() {
        super._bindViewModel()
        guard let viewModel = viewModel as? QYHomeViewModel else {
            return
        }
        
        let trigger = Observable.merge(searchItemDidTap,
                                       Observable.just(()),
                                       viewModel.refreshOutput.emptyDataSetViewTap.asObservable())
        let input = QYHomeViewModel.Input(trigger: trigger)
        let output = viewModel.transform(input: input)
        output.dataSource.subscribe (onNext: { sections in
            QYLogger.debug("sections => \(sections.count)")
        }).disposed(by: rx.disposeBag)
    }
}
