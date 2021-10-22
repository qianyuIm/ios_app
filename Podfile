platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'

target 'ios_app' do
  # OC
  # 定位SDK
  pod 'AMapLocation', '~> 2.7.0'
  pod 'AMapSearch', '~> 7.9.0'
  # 极光
  pod 'JCore', '~> 2.7.1'
  pod 'JPush', '~> 4.3.6'
  pod 'JMLink', '~> 1.2.4'
  
  # Rx
  pod 'RxActivityIndicator'
  pod 'NSObject+Rx'
  pod 'Moya/RxSwift'
  pod 'RxDataSources'
  pod 'RxReachability', '~> 1.1.0'
  pod 'RxTheme'
  pod 'RxSwiftExt'
  
  # navigation
  pod 'HBDNavigationBar','~> 1.8.1'
  # tabbar
  pod "ESTabBarController-swift", '~> 2.8.0'
  # Router
  pod 'URLNavigator', '~> 2.3.0'
  # 资源管理
  pod 'R.swift', '~> 5.4.0'
  pod 'Localize-Swift', '~> 3.2.0'
  # lottie
  pod 'lottie-ios', '~> 3.2.3'
  pod 'EmptyDataSet-Swift', '~> 5.0.0'
  pod 'SwiftRichString', '~> 3.7.2'
  # json -> model
  pod 'HandyJSON', '~> 5.0.2'
  # layout
  pod 'SnapKit'
  pod 'AutoInch'
  # Refresh
  pod 'MJRefresh', '~> 3.7.2'
  # image
  pod 'SDWebImageWebPCoder', '~> 0.8.4'
  pod 'SDWebImageFLPlugin', '~> 0.5.0'
  # alert
  pod 'SwiftEntryKit', '~> 1.2.7'
  pod 'Toaster', '~> 2.3.0'
  # hud
  pod 'NVActivityIndicatorView', '~> 5.1.1'
  pod 'MBProgressHUD', '~> 1.2.0'
  # ad
  pod 'XHLaunchAd', '~> 3.9.12'
  # UserDefaults
  pod 'SwiftyUserDefaults', '~> 5.3.0'
  # 分类
  pod 'SwifterSwift', '~> 5.2.0'
  # debug log
  pod 'SwiftyBeaver', '~> 1.9.5'
  # debug tool
  pod 'MLeaksFinder', :git => "https://github.com/Tencent/MLeaksFinder.git", :configurations => ['Debug']
  # debug tool
  pod 'FLEX', '~> 4.2.2',:configurations => ['Debug']
  
  
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
        end
    end
end
