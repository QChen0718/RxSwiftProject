//
//  BOViewModel.swift
//  RxSwift-viewmodel
//
//  Created by 陈庆 on 2020/7/8.
//  Copyright © 2020 陈庆. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class BOViewModel: NSObject {
//    响应SearchBar的输入
    let searchTextOB = BehaviorSubject(value: "")
    lazy var searchData:Driver<[BOReposityModel]> = {
        // 每隔300毫秒请求一直，并且在主线程发起请求
        return self.searchTextOB.asObserver()
            .throttle(0.3, scheduler: MainScheduler.instance)
//        阻止发送相同的信号
        .distinctUntilChanged()
            .flatMapFirst(BOViewModel.requestData)
            // 如果出错，则返回空数组
        .asDriver(onErrorJustReturn: [])
    }()
//    json解析
    static func requestData(_ githubId: String) -> Observable<[BOReposityModel]>{
        guard !githubId.isEmpty,let url = URL(string: "https://api.github.com/users/\(githubId)/repos") else {
            return Observable.just([])
        }
        return URLSession.shared.rx.json(url: url)
        .retry()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map(BOViewModel.parseData)
    }
    static func parseData(_ json:Any) -> [BOReposityModel] {
        guard let datas = json as? [[String:Any]] else {
            return []
        }
        guard let result = [BOReposityModel].deserialize(from: datas) else {
            return []
        }
        return result as! [BOReposityModel]
    }
}
