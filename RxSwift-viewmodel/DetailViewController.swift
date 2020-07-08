//
//  DetailViewController.swift
//  RxSwift-viewmodel
//
//  Created by 陈庆 on 2020/7/8.
//  Copyright © 2020 陈庆. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
class DetailViewController: BaseViewController {
    public var pubject:PublishSubject=PublishSubject<String>()
    fileprivate lazy var button:UIButton={
        let btn = UIButton(type: .custom)
        btn.setTitle("返回数据", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .gray
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        initUI()
        setFrame()
        button.rx.tap.subscribe {[weak self] (value) in
            self?.pubject.onNext("返回数据123")
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
    }
}
extension DetailViewController{
    fileprivate func initUI(){
        view.addSubview(button)
    }
    fileprivate func setFrame(){
        button.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
}
