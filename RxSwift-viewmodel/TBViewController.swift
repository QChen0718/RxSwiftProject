//
//  TBViewController.swift
//  RxSwift-viewmodel
//
//  Created by 陈庆 on 2020/7/8.
//  Copyright © 2020 陈庆. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class TBViewController: BaseViewController {
    
    @IBOutlet weak var searTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let viewModel = BOViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        实现 view - model绑定
        self.searTextfield.rx.text.orEmpty
            .bind(to: viewModel.searchTextOB)
        .disposed(by: disposeBag)

//        实现 model 绑定 view
        self.viewModel.searchData.map { (array) -> String in
            return "共\(array.count)个结果"
        }.drive(self.navigationItem.rx.title)
        .disposed(by: disposeBag)

        self.viewModel.searchData.drive(self.tableView.rx.items){
            (tableView,row,model) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.url
            return cell
        }.disposed(by: disposeBag)
    }

}
