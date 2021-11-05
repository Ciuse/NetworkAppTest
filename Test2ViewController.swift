//
//  Test2ViewController.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 04/11/21.
//

import UIKit


class Test2ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblStepperValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vcStepper = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Custom_Stepper") as! CustomStepper
        containerView.addSubview(vcStepper.view)
//        containerView.clipsToBounds = false
//        vcStepper.view.frame = containerView.bounds
        addChild(vcStepper) //aggiunge la logica del "self" del selettore anche a questa view
        
        let stepperWidth: Int = 200
        let stepperHeight: Int = 100
//        vcStepper.configure(
//            frame: CGRect(
//                x: Int((containerView.bounds.width / 2)) - (stepperWidth / 2),
//                y: Int((containerView.bounds.height / 2)) - (stepperHeight / 2),
//                width: stepperWidth,
//                height: stepperHeight
//            ),
//            value: (min: 0, max: 10),
//            btnImages: (left: UIImage(systemName: "minus"), right: UIImage(systemName: "plus")),
//            callback: { value in
//                self.updateLblStepperValue(value: value)
//            }
//        )
        
        vcStepper.configure(
            delegate: self,
            frame: CGRect(
                x: Int((containerView.bounds.width / 2)) - (stepperWidth / 2),
                y: Int((containerView.bounds.height / 2)) - (stepperHeight / 2),
                width: stepperWidth,
                height: stepperHeight
            ),
            value: (min: 0, max: 10),
            btnImages: (left: UIImage(systemName: "minus"), right: UIImage(systemName: "plus"))
        )
    }
    
    private func updateLblStepperValue (value: Int) {
        self.lblStepperValue.text = value.formatted()
        
    }
}

extension Test2ViewController : CustomStepperProtocol {
    func update(value: Int) {
        updateLblStepperValue(value: value)
    }

}
