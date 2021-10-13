//
//  QYLottieTabBarItemContentView.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import UIKit
import ESTabBarController_swift
import Lottie

enum LottieColorKeyPath: String {
    case stroke = "**.描边 1.Color"
    case combine = "**.描边 1.Color\n**.填充 1.Color"
    case fill = "**.填充 1.Color"
}
class QYLottieTabBarItemContentView: ESTabBarItemContentView {
    
    lazy var lottieView: AnimationView = {
        let lottieView = AnimationView(name: lottieName)
        return lottieView
    }()
    var lottieName: String
    var colorKeyPath: LottieColorKeyPath
    init(lottieName: String,
         colorKeyPath: LottieColorKeyPath) {
        self.lottieName = lottieName
        self.colorKeyPath = colorKeyPath
        super.init(frame: .zero)
        
        appThemeProvider.rx
            .bind({ $0.tabbarTheme.textColor}, to: rx.textColor)
            .bind({ $0.tabbarTheme.highlightTextColor }, to: rx.highlightTextColor)
            .bind({ $0.tabbarTheme.iconColor}, to: rx.iconColor)
            .bind({ $0.tabbarTheme.highlightIconColor}, to: rx.highlightIconColor)
            .disposed(by: rx.disposeBag)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func selectAnimation(animated: Bool, completion: (() -> Void)?) {
        super.selectAnimation(animated: animated, completion: nil)
        imageView.isHidden = true
        lottieView.frame = imageView.frame
        self.addSubview(lottieView)
        
        let highlightIconColor = appThemeProvider.attrs.tabbarTheme.highlightIconColor
        let r = Double(highlightIconColor.rgbComponents.red) / 255.0
        let g = Double(highlightIconColor.rgbComponents.green) / 255.0
        let b = Double(highlightIconColor.rgbComponents.blue) / 255.0
        // 改变颜色
        if (colorKeyPath == .combine) {
            let keys = colorKeyPath.rawValue.components(separatedBy: "\n")
            for key in keys {
                let colorKeyPath = AnimationKeypath(keypath: key)
                let colorValueProvider = ColorValueProvider(Color(r: r, g: g, b: b, a: 1))
                lottieView.setValueProvider(colorValueProvider, keypath: colorKeyPath)
            }
        } else {
            let colorKeyPath = AnimationKeypath(keypath: colorKeyPath.rawValue)
            let colorValueProvider = ColorValueProvider(Color(r: r, g: g, b: b, a: 1))
            lottieView.setValueProvider(colorValueProvider, keypath: colorKeyPath)
        }
        lottieView.play { _ in
            self.imageView.isHidden = false
            self.lottieView.stop()
            self.lottieView.removeFromSuperview()
        }
    }
    /// 重写 不super
    override func updateLayout() {
        let w = self.bounds.size.width
        let h = self.bounds.size.height
        
        imageView.isHidden = (imageView.image == nil)
        titleLabel.isHidden = (titleLabel.text == nil)
        
        if self.itemContentMode == .alwaysTemplate {
            var s: CGFloat = 0.0 // image size
            let f: CGFloat = 11.0 // font
            var isLandscape = false
            if let keyWindow = UIApplication.shared.keyWindow {
                isLandscape = keyWindow.bounds.width > keyWindow.bounds.height
            }
            let isWide = isLandscape || traitCollection.horizontalSizeClass == .regular // is landscape or regular
            if #available(iOS 11.0, *), isWide {
                s = UIScreen.main.scale == 3.0 ? 23.0 : 20.0
                //                f = UIScreen.main.scale == 3.0 ? 13.0 : 12.0
            } else {
                s = 23.0
                //                f = 10.0
            }
            
            if !imageView.isHidden && !titleLabel.isHidden {
                titleLabel.font = QYFont.fontSemibold(f, isAuto: false)
                titleLabel.sizeToFit()
                if #available(iOS 11.0, *), isWide {
                    titleLabel.frame = CGRect.init(x: (w - titleLabel.bounds.size.width) / 2.0 + (UIScreen.main.scale == 3.0 ? 14.25 : 12.25),
                                                   y: (h - titleLabel.bounds.size.height) / 2.0,
                                                   width: titleLabel.bounds.size.width,
                                                   height: titleLabel.bounds.size.height)
                    imageView.frame = CGRect.init(x: titleLabel.frame.origin.x - s - (UIScreen.main.scale == 3.0 ? 6.0 : 5.0),
                                                  y: (h - s) / 2.0,
                                                  width: s,
                                                  height: s)
                } else {
                    titleLabel.frame = CGRect.init(x: (w - titleLabel.bounds.size.width) / 2.0,
                                                   y: h - titleLabel.bounds.size.height - 1.0,
                                                   width: titleLabel.bounds.size.width,
                                                   height: titleLabel.bounds.size.height)
                    imageView.frame = CGRect.init(x: (w - s) / 2.0,
                                                  y: (h - s) / 2.0 - 6.0,
                                                  width: s,
                                                  height: s)
                }
            } else if !imageView.isHidden {
                imageView.frame = CGRect.init(x: (w - s) / 2.0,
                                              y: (h - s) / 2.0,
                                              width: s,
                                              height: s)
            } else if !titleLabel.isHidden {
                titleLabel.font = QYFont.fontSemibold(f, isAuto: false)
                titleLabel.sizeToFit()
                titleLabel.frame = CGRect.init(x: (w - titleLabel.bounds.size.width) / 2.0,
                                               y: (h - titleLabel.bounds.size.height) / 2.0,
                                               width: titleLabel.bounds.size.width,
                                               height: titleLabel.bounds.size.height)
            }
            
            if let _ = badgeView.superview {
                let size = badgeView.sizeThatFits(self.frame.size)
                if #available(iOS 11.0, *), isWide {
                    badgeView.frame = CGRect.init(origin: CGPoint.init(x: imageView.frame.midX - 3 + badgeOffset.horizontal, y: imageView.frame.midY + 3 + badgeOffset.vertical), size: size)
                } else {
                    badgeView.frame = CGRect.init(origin: CGPoint.init(x: w / 2.0 + badgeOffset.horizontal, y: h / 2.0 + badgeOffset.vertical), size: size)
                }
                badgeView.setNeedsLayout()
            }
            
        } else {
            if !imageView.isHidden && !titleLabel.isHidden {
                titleLabel.sizeToFit()
                imageView.sizeToFit()
                titleLabel.frame = CGRect.init(x: (w - titleLabel.bounds.size.width) / 2.0,
                                               y: h - titleLabel.bounds.size.height - 1.0,
                                               width: titleLabel.bounds.size.width,
                                               height: titleLabel.bounds.size.height)
                imageView.frame = CGRect.init(x: (w - imageView.bounds.size.width) / 2.0,
                                              y: (h - imageView.bounds.size.height) / 2.0 - 6.0,
                                              width: imageView.bounds.size.width,
                                              height: imageView.bounds.size.height)
            } else if !imageView.isHidden {
                imageView.sizeToFit()
                imageView.center = CGPoint.init(x: w / 2.0, y: h / 2.0)
            } else if !titleLabel.isHidden {
                titleLabel.sizeToFit()
                titleLabel.center = CGPoint.init(x: w / 2.0, y: h / 2.0)
            }
            
            if let _ = badgeView.superview {
                let size = badgeView.sizeThatFits(self.frame.size)
                badgeView.frame = CGRect.init(origin: CGPoint.init(x: w / 2.0 + badgeOffset.horizontal, y: h / 2.0 + badgeOffset.vertical), size: size)
                badgeView.setNeedsLayout()
            }
        }
    }
    
}
