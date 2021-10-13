//
//  QYRefreshFooter.swift
//  ios_app
//
//  Created by cyd on 2021/10/13.
//

import MJRefresh

class QYRefreshFooter: MJRefreshAutoNormalFooter {

    override func prepare() {
        super.prepare()
        self.triggerAutomaticallyRefreshPercent = 0.2
        self.setTitle("", for: .idle)
        self.setTitle("正在加载中", for: .refreshing)
        self.setTitle("没有更多了", for: .noMoreData)
    }

}
