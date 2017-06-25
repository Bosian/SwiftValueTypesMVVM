//
//  ViewController.swift
//  POPMVVM
//
//  Created by 劉柏賢 on 2016/7/10.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit
import ValueTypesFramework

class MainViewController: UIViewController, Viewer, Keyboarder, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    typealias ViewModelType = MainViewModel
    var viewModel: ViewModelType! {
        didSet {
            label.text = viewModel.now
            text1.text = viewModel.text
            text2.text = viewModel.text
            imageView.image = viewModel.image
            
            tableView.reloadData()
        }
    }
    
    /// 取得SrollView
    var scrollView: UIScrollView? {
        return tableView
    }
    
    /**
     * 鍵盤是否已顯示
     */
    var isKeyboardShown: Bool = false
    
    /// ScrollView Content Inset (鍵盤調整使用)
    var scrollViewOriginalContentInset: UIEdgeInsets = .zero
    
    /**
     * View的高度 (鍵盤調整View使用)
     */
    var viewHeightForKeyboard: CGFloat = 0.0
    
    /**
     * 鍵盤已顯示 Register Object
     */
    var observerForKeyboardDidShowNotification: NSObjectProtocol?
    
    /**
     * 鍵盤將顯示 Register Object
     */
    var observerForKeyboardWillShowNotification: NSObjectProtocol?
    
    /**
     * 鍵盤將隱藏 Register Object
     */
    var observerForKeyboardWillHideNotification: NSObjectProtocol?
    
    deinit {
        unRegisterKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text1.delegate = self
        text2.delegate = self
        
        registerKeyboard()
        
        viewModel = ViewModelType(binder: self)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let view = self.view else {
            return false
        }
        
        let lastTextFieldTag = 2
        guard textField.tag == lastTextFieldTag else
        {
            let nextTextFieldTag = textField.tag + 1
            view.viewWithTag(nextTextFieldTag)?.becomeFirstResponder()
            
            return false
        }
        
        self.view.endEditing(true)
        
        let buttonTag = 3
        guard let button = view.viewWithTag(buttonTag) as? UIButton else {
            return false
        }
        
        button.sendActions(for: .touchUpInside)
        textField.resignFirstResponder()
        
        return false
    }
    
    @IBAction func text1Handler(_ sender: UITextField) {
        viewModel.text = sender.text ?? ""
    }
    
    @IBAction func text2Handler(_ sender: UITextField) {
        viewModel.text = sender.text ?? ""
    }

    @IBAction func handler(_ sender: UIButton) {
        viewModel.handler()
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
        
        let id = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        
        if let binder = cell as? Binder
        {
            binder.dataContext = viewModel.cellViewModels[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        let oldValue = cellViewModel.title
        let newValue = Date().toString("yyyy/MM/dd HH:mm:ss", locale: .current, timeZone: .current)
        
        viewModel.cellViewModels[indexPath.row].tapHandler(cellViewModel.indexPath , oldValue, newValue, cellViewModel)
    }
}
