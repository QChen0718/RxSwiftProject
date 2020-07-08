//
//  ViewController.swift
//  RxSwift-viewmodel
//
//  Created by 陈庆 on 2020/7/8.
//  Copyright © 2020 陈庆. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: BaseViewController {
    
    public var pubsubject:PublishSubject = PublishSubject<String>()
    fileprivate lazy var button:UIButton={
        let btn = UIButton(type: .custom)
        btn.setTitle("点击", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .red
        return btn
    }()
    fileprivate lazy var textfield:UITextField={
        let text = UITextField(frame: .zero)
        text.placeholder = "请输入内容"
        text.borderStyle = .line
        return text
    }()
    fileprivate lazy var backcontent:UILabel={
        let label = UILabel(frame: .zero)
        label.textColor = .red
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
        setFrame()
        pubsubject.subscribe { (content) in
            print(content.element ?? "")
        }.disposed(by: disposeBag)
    }
}

extension ViewController{
    fileprivate func initUI(){
        view.addSubview(button)
        button.rx.tap.subscribe {[weak self](value) in
            print("按钮被点击\(value)")
           let vc = DetailViewController()
            vc.pubject.subscribe { (content) in
                print(content.element ?? "")
                self?.backcontent.text = content.element
            }.disposed(by: self!.disposeBag)
            self?.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        view.addSubview(backcontent)
        view.addSubview(textfield)
    }
    fileprivate func setFrame(){
        button.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        backcontent.snp.makeConstraints { (make) in
            make.top.equalTo(button.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 30))
        }
        textfield.snp.makeConstraints { (make) in
            make.top.equalTo(backcontent.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 400, height: 30))
        }
    }
}
