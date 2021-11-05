//
//  ContainerSliderViewController.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 05/11/21.
//

import UIKit

class ContainerSliderViewController: UIViewController {
    @IBOutlet weak var sliderContainerView: UIView!
    @IBOutlet weak var labelValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vcSlider = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Custom_Slider") as! CustomSlider
        sliderContainerView.addSubview(vcSlider.view)
        addChild(vcSlider)
        
        let sliderHeight = 150
        let sliderWidth = 300
        
        vcSlider.configure(
            frame: CGRect(x: Int((sliderContainerView.bounds.midX)) - (sliderWidth / 2),
                          y: Int((sliderContainerView.bounds.midY)) - (sliderHeight / 2),
                          width: sliderWidth, height: sliderHeight),
            paddingOut: 20, value: (2, 12), thumbImg: UIImage(systemName: "square.fill"), thumbBackgroundColor: UIColor.black,
            vEmptyColor: UIColor.gray, vFullColor: UIColor.blue,
            callback: {value in
                self.labelValue.text = "\(value)"
            }
        )
    }
    
}
