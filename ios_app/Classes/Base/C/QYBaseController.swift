//
//  QYBaseController.swift
//  ios_app
//
//  Created by cyd on 2021/10/9.
//

import UIKit
import RxSwift
import RxCocoa
class QYBaseController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return globalStatusBarStyle.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _prepare()
        _registerNotification()
        _setupUI()
        _setupConstraints()
        _setupTheme()
    }
    
    /// 1. 常量设置
    func _prepare() {
        automaticallyAdjustsScrollViewInsets = false
    }
    /// 2. 通知
    func _registerNotification() {}
    /// 3. UI设置
    func _setupUI() { }
    /// 4. 约束设置
    func _setupConstraints() {}
    /// 5. 皮肤设置
    func _setupTheme() {
        appThemeProvider.rx
            .bind({ $0.backgroundColor }, to: view.rx.backgroundColor)
            .disposed(by: rx.disposeBag)
        appThemeProvider.rx
            .bind({ $0.statusBarStyle }, to: UIApplication.shared.rx.statusBarStyle)
            .disposed(by: rx.disposeBag)
        appThemeProvider.typeStream.subscribe(onNext: { [weak self](theme) in
            guard let self = self else { return }
            self.hbd_setNeedsUpdateNavigationBar()
        }).disposed(by: rx.disposeBag)
       
    }
    
    deinit {
        QYLogger.debug("\(self) 移除了")
    }
    
}
