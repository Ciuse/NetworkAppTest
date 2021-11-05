//
//  TestViewController.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 04/11/21.
//

import UIKit

class TestViewController: UIViewController {
    private var lbl1: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addLabel(text: "lorem ipsu")
        addButton(rect: CGRect(x: 20, y: 100, width: 80, height: 50), title: "Add", selector: #selector(actionAdd(sender:)))
        addButton(rect: CGRect(x: 20, y: 160, width: 80, height: 50), title: "Remove", selector: #selector(actionRemove(sender:)))
    }

    private func addLabel(text: String) {
        let txtLabel = UILabel()
        txtLabel.frame = CGRect(x: 20, y: 20, width: 120, height: 50)
        txtLabel.text = text
        self.view.addSubview(txtLabel)
        txtLabel.backgroundColor = UIColor(red: 200/255, green: 120/255, blue: 170/255, alpha: 1)
        txtLabel.textAlignment = .right
        
        lbl1 = txtLabel
        
//        DispatchQueue.global().async {
//            for i in 1...10 {
//                DispatchQueue.main.async {
//                    txtLabel.text = "\(text) + \(i)"
//                }
//                sleep(1)
//            }
//        }
    }
    
    private func addButton(rect: CGRect, title: String, selector: Selector) {
        let button = UIButton(frame: rect)
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor.green
        self.view.addSubview(button)
        button.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    @objc private func actionClick(sender: UIButton) {
        print(sender.titleLabel?.text)
    }
    
    @objc private func actionAdd(sender: UIButton) {
        addLabel(text: "ciaoo")
    }
    
    @objc private func actionRemove(sender: UIButton) {
        lbl1?.removeFromSuperview()
    }
    
}
