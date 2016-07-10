//
//  ViewController.swift
//  POPMVVM
//
//  Created by 劉柏賢 on 2016/7/10.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModel! {
        didSet {
            label.text = viewModel.now
            text1.text = viewModel.text
            text2.text = viewModel.text
            imageView.image = viewModel.image
            
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel()
    }

    @IBAction func text1Handler(_ sender: UITextField) {
        viewModel.text = sender.text ?? ""
    }
    
    @IBAction func text2Handler(_ sender: UITextField) {
        viewModel.text = sender.text ?? ""
    }

    var count: Int = 0
    
    @IBAction func handler(_ sender: UIButton) {
        
        let now = Date().toString("yyyy/MM/dd HH:mm:ss", locale: Locale.current, timeZone: TimeZone.default)
        
        viewModel.now = now
        
        count += 1
        viewModel.image = (count % 2 == 0) ? #imageLiteral(resourceName: "swift-128x128_2x") : #imageLiteral(resourceName: "lena")
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell
        cell.viewModel = viewModel.cellViewModels[indexPath.row]
        
        print(indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let now = Date().toString("yyyy/MM/dd HH:mm:ss", locale: Locale.current, timeZone: TimeZone.default)
        viewModel.cellViewModels[indexPath.row].title = now
    }
}
