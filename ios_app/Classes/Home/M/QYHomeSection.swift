//
//  QYHomeSection.swift
//  ios_app
//
//  Created by cyd on 2021/10/22.
//

import RxDataSources

enum QYHomeSection {
    /// banner
    case bannerSection(items: [QYHomeViewSectionItem])
    /// 推荐歌单
    case resourceSection(items: [QYHomeViewSectionItem])
}
enum QYHomeViewSectionItem {
    case bannerItem(items: [QYHomeBanner])
    case resourceItem(items: [MusicPlaylist])
}

extension QYHomeSection: SectionModelType {
    
    
    typealias Item = QYHomeViewSectionItem
    
    var items: [QYHomeViewSectionItem] {
        switch self {
        case  .bannerSection(let items):
            return items
        case  .resourceSection(let items):
            return items
        }
    }
    
    init(original: QYHomeSection, items: [QYHomeViewSectionItem]) {
        switch original {
        case .bannerSection(let items):
            self = .bannerSection(items: items)
        case .resourceSection(let items):
            self = .resourceSection(items: items)
        }
    }
    
}
