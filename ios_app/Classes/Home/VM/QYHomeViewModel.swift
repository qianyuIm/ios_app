//
//  QYHomeViewModel.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import Foundation
import RxSwift
import RxCocoa

class QYHomeViewModel: QYRefreshViewModel {
    struct Input {
        /// 初始化
        let trigger: Observable<Void>
    }
    struct Output {
        let dataSource: BehaviorRelay<[QYHomeSection]>
    }
    
}
extension QYHomeViewModel: QYViewModelable {
    
    func transform(input: Input) -> Output {
        
        let dataSource = BehaviorRelay<[QYHomeSection]>(value: [])
        
        input.trigger.flatMapLatest { () in
            Observable.zip(self.bannerRequest(),
                           self.recommendResourceRequest())
                .trackError(self.error)
                .trackActivity(self.loading)
                .catchErrorJustComplete()
            
        }.subscribe (onNext: { (bannerWrap, recommendResourceWrap) in
            var sections: [QYHomeSection] = []
            if let banners = bannerWrap.banners {
                sections.append(.bannerSection(items: [.bannerItem(items: banners)]))
            }
            if let resources = recommendResourceWrap.recommend {
                sections.append(.resourceSection(items: [.resourceItem(items: resources)]))
            }
            dataSource.accept(sections)
        }).disposed(by: rx.disposeBag)
        
        
        
        
        return Output(dataSource: dataSource)
    }
    
    
}
private extension QYHomeViewModel {
    /// banner
    func bannerRequest() -> Observable<QYHomeBannerWrap> {
        let result = MusicHomeApi
            .banner
            .request()
            .mapMusicObject(QYHomeBannerWrap.self)
            .asObservable()
        
        return result
    }
    /// 推荐歌单 需要登录
    func recommendResourceRequest() -> Observable<QYHomeRecommendResourceWrap> {
        let result = MusicHomeApi
            .recommendResource
            .request()
            .mapMusicObject(QYHomeRecommendResourceWrap.self)
            .asObservable()
        return result
    }
}
