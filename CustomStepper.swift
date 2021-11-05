//
//  CustomStepperViewController.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 04/11/21.
//

import UIKit

protocol CustomStepperProtocol: AnyObject {
    func update(value: Int)
}

class CustomStepper: UIViewController {
    @IBOutlet private weak var leftBtn: UIButton!
    @IBOutlet private weak var rightBtn: UIButton!
    @IBOutlet private weak var lblValue: UILabel!
    
    /// Description
    private var minimunValue: Int = 0
    private var maximunValue: Int = 0
    
    private var _currentValue: Int = 0
    private var currentValue: Int {
        get {
            _currentValue
        }
        
        set {
            if newValue >= minimunValue, newValue <= maximunValue {
                _currentValue = newValue
            }

            lblValue.text = "\(currentValue)"
        }
    }

    private var callBackFunc: ((_ value: Int) -> Void)?
    private weak var delegate: CustomStepperProtocol? //Va messo il weak per gestire correttamente la memoria
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure

    /// Description
    /// - Parameters:
    ///   - dimension: dimension description
    ///   - minValue: minValue description
    ///   - maxValue: maxValue description
    ///   - leftButtonImage: leftButtonImage description
    ///   - rightButtonImage: rightButtonImage description
    ///   - callBack: callBack description
    func configure(frame: CGRect, value: (min: Int, max: Int), btnImages: (left: UIImage?, right: UIImage?),
                          callback: @escaping (_ value: Int) -> Void) {
        configure(frame: frame, value: value, btnImages: btnImages)
        
        callBackFunc = callback
        callBackFunc?(currentValue)
  }
    
    func configure(delegate: CustomStepperProtocol?, frame: CGRect, value: (min: Int, max: Int), btnImages: (left: UIImage?, right: UIImage?)) {
        configure(frame: frame, value: value, btnImages: btnImages)
        
        self.delegate = delegate
        self.delegate?.update(value: currentValue)
    }
    
    private func configure(frame: CGRect, value: (min: Int, max: Int), btnImages: (left: UIImage?, right: UIImage?)) {
        view.frame = frame

        minimunValue = value.min
        maximunValue = value.max
        currentValue = (value.min + value.max) / 2
        
        lblValue.text = "\(currentValue)"
        
        configureButton(button: leftBtn, buttonImage: btnImages.left, action: #selector(leftBtnClick(sender:)))
        configureButton(button: rightBtn, buttonImage: btnImages.right, action: #selector(rightBtnClick(sender:)))
    }
    
    // MARK: - Helper tool
    
    private func configureButton(button: UIButton, buttonImage: UIImage?, action: Selector) {
        button.setTitle("", for: .normal)
        button.setImage(buttonImage, for: .normal)
        button.setBackgroundImage(UIImage(systemName: "rectangle"), for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    // MARK: - Handler function

    @objc private func leftBtnClick(sender: UIButton) {
        currentValue -= 1
        
        update()
    }
    
    @objc private func rightBtnClick(sender: UIButton) {
        currentValue += 1
        
        update()
    }
    
    private func update() {
        rightBtn.isEnabled = currentValue != maximunValue
        leftBtn.isEnabled = currentValue != minimunValue
        
        callBackFunc?(currentValue)
        delegate?.update(value: currentValue)
    }
}
