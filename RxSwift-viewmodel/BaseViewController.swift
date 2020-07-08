//
//  BaseViewController.swift
//  RxSwift-viewmodel
//
//  Created by 陈庆 on 2020/7/8.
//  Copyright © 2020 陈庆. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
class BaseViewController: UIViewController {
    public var disposeBag:DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
