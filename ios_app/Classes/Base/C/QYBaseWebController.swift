//
//  QYBaseWebController.swift
//  ios_app
//
//  Created by cyd on 2021/10/19.
//

import UIKit
import WebKit


class QYScriptMessageHandler: NSObject,WKScriptMessageHandler {
    
    weak var scriptDelegate: WKScriptMessageHandler?
    init(scriptDelegate: WKScriptMessageHandler) {
        self.scriptDelegate = scriptDelegate
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.scriptDelegate?.userContentController(userContentController, didReceive: message)
    }
    deinit {
        QYLogger.debug("\(self) 移除了")
    }
}
private let kEstimatedProgressKeyPath = "estimatedProgress"
private let kTitleKeyPath = "title"
private let kCookieKey = "Cookie"

class QYBaseWebController: QYBaseController {
    
    private(set) var webView: WKWebView?
    
    var webUrl: String?
    /// 进度条颜色
    var progressColor: UIColor = UIColor(white: 1, alpha: 0) {
        didSet {
            progressView.trackTintColor = progressColor
        }
    }
    /// 进度
    private (set) var estimatedProgress: Double = 0 {
        didSet {
            progressView.alpha = 1
            progressView.setProgress(Float(estimatedProgress), animated: true)
            if estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: {
                    finished in
                    self.progressView.setProgress(0, animated: false)
                })
            }
        }
    }
    /// 通用方法 -> 返回首页
    private let kGeneralMethodGoBackHome = "goBackHome"
    
    lazy fileprivate var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.alpha = 1
        progressView.trackTintColor = progressColor
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.load()
        }
        
    }
    
    override func _prepare() {
        super._prepare()
        setupWebView()
    }
    
    override func _setupConstraints() {
        super._setupConstraints()
        progressView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(3)
        }
        webView?.snp.makeConstraints({ make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(progressView.snp.bottom)
        })
    }
    
     
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case kEstimatedProgressKeyPath?:
            guard let estimatedProgress = webView?.estimatedProgress else {
                return
            }
            self.estimatedProgress = estimatedProgress
        case kTitleKeyPath?:
            
            if let title = webView?.title {
                navigationItem.title = title
            } else {
                navigationItem.title = "123"
            }
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    private func load() {
        guard let webUrl = webUrl else { return }
        guard let url = URL(string: webUrl) else {
            return
        }
        webView?.load(createRequest(with: url))
    }
    private func createRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url,cachePolicy: .reloadIgnoringLocalCacheData,timeoutInterval: 20.0)
        /// 设置 Cookies
        if let cookies = HTTPCookieStorage.shared.cookies, let value = HTTPCookie.requestHeaderFields(with: cookies)[kCookieKey] {
//            request.addValue(value, forHTTPHeaderField: kCookieKey)
        }
//        let string = "MUSIC_A_T=1501461434597; MUSIC_U=409d6946403d823744ab456df03e02bf85f92d03bcf5bbe69090a3a3cee6612a8a08bd5bf851808fd78b6050a17a35e705925a4e6992f61d07c385928f88e8de;__csrf=07a33bded309e5d5525636890f4feb36;MUSIC_R_T=1564817429039;__remember_me=true"
//        request.addValue(string, forHTTPHeaderField: kCookieKey)
        
        return request
    }
    deinit {
        webView?.removeObserver(self, forKeyPath: kEstimatedProgressKeyPath)
        webView?.removeObserver(self, forKeyPath: kTitleKeyPath)
    }

}
//MARK: -- WKNavigationDelegate
extension QYBaseWebController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        var actionPolicy: WKNavigationActionPolicy = .allow
        defer {
            decisionHandler(actionPolicy)
        }
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
}
//MARK: -- WKUIDelegate
extension QYBaseWebController: WKUIDelegate {
    
}
//MARK: -- WKUIDelegate
extension QYBaseWebController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case kGeneralMethodGoBackHome:
            AppHelper.toRootController(true, .home)
            break
        default:
            break
        }
    }
}
//MARK: -- setup
extension QYBaseWebController {
    func setupWebView() {
        webView = WKWebView(frame: .zero,configuration: setupWebConfig())
        if #available(iOS 11.0, *) {
            webView?.scrollView.contentInsetAdjustmentBehavior = .never
        }
        setupUserAgent()
        /// 滑动返回
        webView?.allowsBackForwardNavigationGestures = true
        webView?.sizeToFit()
        webView?.navigationDelegate = self
        webView?.uiDelegate = self
        
        
        webView?.addObserver(self, forKeyPath: kEstimatedProgressKeyPath, options: .new, context: nil)
        webView?.addObserver(self, forKeyPath: kTitleKeyPath, options: .new, context: nil)
        view.addSubview(progressView)
        view.addSubview(webView!)
    }
    
    func setupWebConfig() -> WKWebViewConfiguration {
        let wkWebConfig = WKWebViewConfiguration.init()
        setupGeneralMethods(user: wkWebConfig.userContentController)
        return wkWebConfig
    }
    func setupUserAgent() {
        webView?.evaluateJavaScript("navigator.userAgent") { [weak self] result, error in
            guard let weakSelf = self else {
                return
            }
            guard error == nil, let originalUserAgent = result as? String else {
                weakSelf.webView?.customUserAgent = QYConfig.userAgent
                return
            }
            weakSelf.webView?.customUserAgent = String(format: "%@ %@", originalUserAgent, QYConfig.userAgent)
        }
    }
    func setupGeneralMethods(user: WKUserContentController) {
        /*fix； 这里会强制持有self，造成webView无法释放*/
        let scriptDelegate = QYScriptMessageHandler(scriptDelegate: self)
        user.add(scriptDelegate, name: kGeneralMethodGoBackHome)
    }
}
