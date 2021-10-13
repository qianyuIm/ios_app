//
//  QYBaseCollectionVMController.swift
//  ios_app
//
//  Created by cyd on 2021/10/13.
//

import UIKit
import EmptyDataSet_Swift
import RxSwiftExt
import RxSwift
import RxCocoa

class QYBaseCollectionVMController: QYBaseVMController {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self._setupLayout())
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.alwaysBounceVertical = true
        collectionView.register(UICollectionViewCell.self)
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func _setupLayout() -> UICollectionViewLayout {
        return UICollectionViewFlowLayout()
    }
    override func _setupUI() {
        super._setupUI()
        view.addSubview(collectionView)
    }
    override func _setupConstraints() {
        super._setupConstraints()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func _bindViewModel() {
        super._bindViewModel()
        guard viewModel != nil else {
            return
        }
        let loading = isLoading
            .distinctUntilChanged()
            .mapToVoid()
        
        let network = QYReachability.shared.reachabilityConnection
            .skip(1)
            .distinctUntilChanged()
            .mapToVoid()
        
        Observable.of(loading,network)
            .merge()
            .bind(to: collectionView.rx.reloadEmptyData)
            .disposed(by: rx.disposeBag)
        
        bindEmptyDataSetViewTap()
        bindHeader()
        bindFooter()
        
    }
    
}

private extension QYBaseCollectionVMController {
    //  绑定没有网络时的点击事件
    private func bindEmptyDataSetViewTap() {
        guard let viewModel = viewModel as? QYRefreshViewModel else { return }
        emptyDataDidTap
            .bind(to: viewModel.refreshInput.emptyDataSetViewTap)
            .disposed(by: rx.disposeBag)
    }
    // MARK: - 绑定头部刷新回调和头部刷新状态
    private func bindHeader() {
        guard let refreshHeader = collectionView.mj_header,
              let viewModel = viewModel as? QYRefreshViewModel else { return }
        // 将刷新事件传递给 refreshVM
        refreshHeader.rx.refreshing
            .bind(to: viewModel.refreshInput.beginHeaderRefresh)
            .disposed(by: rx.disposeBag)
        
        // 头部状态
        viewModel
            .refreshOutput
            .headerRefreshState
            .drive(refreshHeader.rx.isRefreshing)
            .disposed(by: rx.disposeBag)
        
        // 失败时的头部状态
        viewModel
            .error
            .mapTo(false)
            .drive(refreshHeader.rx.isRefreshing)
            .disposed(by: rx.disposeBag)
    }
    // MARK: - 绑定尾部刷新回调和尾部刷新状态
    private func bindFooter() {
        guard let refreshFooter = collectionView.mj_footer,
              let viewModel = viewModel as? QYRefreshViewModel else { return }
        // 将刷新事件传递给 refreshVM
        refreshFooter.rx.refreshing
            .bind(to: viewModel.refreshInput.beginFooterRefresh)
            .disposed(by: rx.disposeBag)
        
        // 尾部状态
        viewModel
            .refreshOutput
            .footerRefreshState
            .drive(refreshFooter.rx.refreshFooterState)
            .disposed(by: rx.disposeBag)
        
        // 失败时的尾部状态
        viewModel
            .error
            .map { [weak self] _ -> RxMJRefreshFooterState in
                guard let self = self else { return .hidden }
                return (self.collectionView.mj_totalDataCount() == 0) ? .hidden : .default
            }
            .drive(refreshFooter.rx.refreshFooterState)
            .disposed(by: rx.disposeBag)
        
    }
}
