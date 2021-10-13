//
//  QYBaseVMController.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx
import SwiftRichString
import Localize_Swift
import EmptyDataSet_Swift

class QYBaseVMController: QYBaseController {
    
    var viewModel: QYViewModel?
    init(viewModel: QYViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 是否在加载
    let isLoading = BehaviorRelay(value: false)
    /// 数据为空点击事件
    let emptyDataDidTap = PublishSubject<Void>()
    /// 数据为空 - 网络未连接 是否允许滚动
    var emptyUnConnectionShouldAllowScroll: Bool = false
    /// 数据为空 -  是否允许滚动
    var emptyShouldAllowScroll: Bool = true
    /// 数据为空 - 网络未连接图片
    var emptyUnConnectionImage: UIImage?
    /// 数据为空 - 图片
    var emptyImage: UIImage?
    /// 数据为空 - 网络未连接 title
    var emptyUnConnectionTitle: NSAttributedString?
    /// 数据为空 -  title
    var emptyTitle: NSAttributedString?
    /// 数据为空 - 网络未连接 detail
    var emptyUnConnectionDetail: NSAttributedString?
    /// 数据为空 -  detail
    var emptyDetail: NSAttributedString?
    /// 数据为空
    var verticalOffset: CGFloat = 0
    /// 刷新头部
    lazy var refreshHeader: QYRefreshHeader = {
        return QYRefreshHeader()
    }()
    /// 刷新尾部
    lazy var refreshFooter: QYRefreshFooter = {
        return QYRefreshFooter()
    }()
    ///  数据为空 默认文本
    let emptyTitleStyle = Style {
        $0.font = QYFont.fontSemibold(16)
        $0.color = QYColor.color("#768087")
    }
    ///  数据为空 默认文本
    let emptyDetailStyle = Style {
        $0.font = QYFont.fontRegular(12)
        $0.color = QYColor.color("#B9C3C9")
    }
    lazy var baseEmptyView: QYBaseEmptyView = {
        // 防止约束冲突的 高度给个大高度
        let emptyView = QYBaseEmptyView(frame: CGRect(x: 0, y: 0, width: QYInch.screenWidth - QYInch.value(40), height: QYInch.value(400)))
        emptyView.backgroundColor = .red
        return emptyView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        _bindViewModel()
    }
    
    override func _prepare() {
        super._prepare()
        emptyUnConnectionImage = R.image.icon_empty_network()
        emptyUnConnectionTitle = R.string.localizable.emptyUnConnectedTitle.key.localized().set(style: emptyTitleStyle)
        emptyUnConnectionDetail = R.string.localizable.emptyUnConnectedDetail.key.localized().set(style: emptyDetailStyle)
        
        emptyImage = R.image.icon_empty()
        emptyTitle = R.string.localizable.emptyTitle.key.localized().set(style: emptyTitleStyle)
        emptyDetail = R.string.localizable.emptyDetail.key.localized().set(style: emptyDetailStyle)
    }
    
    func _bindViewModel() {
        guard viewModel != nil else {
            return
        }
        viewModel!.loading
            .drive(isLoading)
            .disposed(by: rx.disposeBag)
        
        viewModel!.error.asObservable().subscribe(onNext: { [weak self](error) in
//            guard let self = self else { return }
            
        }).disposed(by: rx.disposeBag)
    }
    
    
}

extension QYBaseVMController: EmptyDataSetDelegate {
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return !isLoading.value
    }
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        switch QYReachability.shared.connectionValue {
        case .none, .unavailable:
            return emptyUnConnectionShouldAllowScroll
        case .cellular, .wifi:
            return emptyShouldAllowScroll
        }
    }
    func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        emptyDataDidTap.onNext(())
    }
}
extension QYBaseVMController: EmptyDataSetSource {
    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        switch QYReachability.shared.connectionValue {
        case .none ,.unavailable:
            baseEmptyView.imageView.image = emptyUnConnectionImage
            baseEmptyView.titleLabel.attributedText = emptyUnConnectionTitle
            baseEmptyView.detailLabel.attributedText = emptyUnConnectionDetail
        case .cellular, .wifi:
            baseEmptyView.imageView.image = emptyImage
            baseEmptyView.titleLabel.attributedText = emptyTitle
            baseEmptyView.detailLabel.attributedText = emptyDetail
        }
        return baseEmptyView
    }
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }
}
