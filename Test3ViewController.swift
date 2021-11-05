//
//  Test3ViewController.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 05/11/21.
//

import UIKit

class Test3ViewController: UIViewController {
    @IBOutlet weak var customView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(gesture:)))
        tapGesture.numberOfTapsRequired = 2
        customView.addGestureRecognizer(tapGesture)
       
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(gesture:)))
        swipeGesture.direction = .right
        customView.addGestureRecognizer(swipeGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(gesture:)))
        view.addGestureRecognizer(panGesture)

    }

    @objc func tapAction(gesture: UITapGestureRecognizer) {
        print("tap")
    }
    
    @objc func swipeAction(gesture: UISwipeGestureRecognizer) {
        print("swipe")
    }
    
    @objc func panAction(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        var frame = customView.frame
        frame.origin = location
        customView.frame = frame
    }
}
