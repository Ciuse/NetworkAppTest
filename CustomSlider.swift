//
//  CustomSlider.swift
//  NetworkApp1
//
//  Created by Giuseppe Mauri on 05/11/21.
//

import UIKit

class CustomSlider: UIViewController {
    
    @IBOutlet private weak var imgThumb: UIImageView!
    @IBOutlet private weak var viewFull: UIView!
    @IBOutlet private weak var viewEmpty: UIView!
    @IBOutlet private weak var viewContainer: UIView!
    @IBOutlet private weak var lblValue: UILabel!
    
    private var minValue: CGFloat = 0
    private var maxValue: CGFloat = 0
    private var sliderValue: CGFloat = 0
    private var paddingOut: CGFloat = 0
    private var tapOffset: CGFloat = 0
    private var callback: ((CGFloat) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(gesture:)))
        imgThumb.addGestureRecognizer(panGesture)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(gesture:)))
        viewFull.addGestureRecognizer(tapGesture)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(tapAction2(gesture:)))
        viewEmpty.addGestureRecognizer(tapGesture2)
        //        imgThumb.image = UIImage(systemName: "square.fill")
        //        imgThumb.backgroundColor = UIColor.black
        //        imgThumb.frame.origin = CGPoint(x: viewContainer.bounds.midX - imgThumb.bounds.midX, y: viewContainer.bounds.midY - imgThumb.bounds.midY)
        //
//        configure(frame: CGRect(x: 0, y: 0, width: 100, height: 90),
//                  paddingOut: 20, value: (2, 12), thumbImg: UIImage(systemName: "square.fill"), thumbBackgroundColor: UIColor.black, vEmptyColor: UIColor.gray, vFullColor: UIColor.blue)
    }
    
    func configure(frame: CGRect, paddingOut: CGFloat, value: (min: CGFloat, max: CGFloat), thumbImg: UIImage?, thumbBackgroundColor: UIColor, vEmptyColor: UIColor, vFullColor: UIColor, callback: @escaping (CGFloat) -> Void) {
        viewContainer.frame = frame
        self.paddingOut = paddingOut
        
        minValue = value.min
        maxValue = value.max
        sliderValue = (value.max + value.min) / 2
        lblValue.text = "\(sliderValue)"
        
        imgThumb.image = thumbImg
        imgThumb.backgroundColor = thumbBackgroundColor
        
        var imgFrame = imgThumb.frame
        imgFrame.size = CGSize(width: 30, height: 30)
        imgThumb.frame = imgFrame
        
        viewFull.backgroundColor = vFullColor
        viewEmpty.backgroundColor = vEmptyColor
        
        updateThumbPosition(
            x: viewContainer.bounds.midX - imgThumb.bounds.midX,
            y: viewContainer.bounds.midY - imgThumb.bounds.midY
        )
        
        updateTrackViews()
        
        self.callback = callback
        self.callback?(sliderValue)

    }

    
    @objc private func panAction(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: viewContainer)
        if gesture.state == .began {
            tapOffset = location.x - imgThumb.frame.origin.x

        } else {
            calculateThumbPosition(location: location)
            updateTrackViews()
            
            lblValue.text = "\(calculateSliderValueWith(location: location))"
            callback?(calculateSliderValueWith(location: location))
        }
        
        
    }
    
    @objc private func tapAction(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: viewContainer)
        tapOffset = imgThumb.bounds.midX
        calculateThumbPosition(location: location)
        updateTrackViews()
        
        lblValue.text = "\(calculateSliderValueWith(location: location))"
        callback?(calculateSliderValueWith(location: location))
    }
    
    @objc private func tapAction2(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: viewContainer)
        tapOffset = imgThumb.bounds.midX
        calculateThumbPosition(location: location)
        updateTrackViews()
        
        lblValue.text = "\(calculateSliderValueWith(location: location))"
        callback?(calculateSliderValueWith(location: location))
    }

    private func calculateThumbPosition(location: CGPoint) {
        var newThumbOriginX: CGFloat = imgThumb.frame.origin.x
        
        // print("\(imgThumb.bounds.width / 2),= \(imgThumb.bounds.midX),= \(imgThumb.frame.width / 2),!= \(imgThumb.frame.midX), " )
        switch location.x {
        case let x where x < viewContainer.bounds.minX + tapOffset + paddingOut:
            newThumbOriginX = viewContainer.bounds.minX + paddingOut
            
        case let x where x > viewContainer.bounds.maxX - paddingOut - (imgThumb.frame.width - tapOffset):
            newThumbOriginX = viewContainer.bounds.maxX - imgThumb.bounds.maxX - paddingOut
            
        default:
            newThumbOriginX = location.x - tapOffset
        }
        updateThumbPosition(x: newThumbOriginX, y: viewContainer.bounds.midY - imgThumb.bounds.midY)
    }
    
    
    private func updateTrackViews() {
        viewFull.frame = CGRect(
            origin: CGPoint(x: viewContainer.bounds.minX + paddingOut, y: viewContainer.bounds.midY - viewFull.bounds.midY),
            size: CGSize(width: imgThumb.frame.midX - paddingOut, height: viewFull.frame.height)
        )
        viewEmpty.frame = CGRect(
            origin: CGPoint(x: imgThumb.frame.midX, y: viewContainer.bounds.midY - viewFull.bounds.midY),
            size: CGSize(width: viewContainer.bounds.maxX - imgThumb.frame.midX - paddingOut, height: viewEmpty.frame.height)
        )
    }
    
    private func updateThumbPosition(x: CGFloat, y: CGFloat) {
        var imgFrame = imgThumb.frame
        imgFrame.origin = CGPoint(x: x , y: y)
        imgThumb.frame = imgFrame
    }
    
    private func calculateSliderValueWith(location: CGPoint) -> CGFloat {
        let valueRange = maxValue - minValue
        
        let minValidLoc = viewContainer.bounds.minX + paddingOut + tapOffset
        let maxValidLoc = viewContainer.bounds.maxX - paddingOut - (imgThumb.frame.width - tapOffset)
        let locationValidRange = maxValidLoc - minValidLoc

        switch location.x {
        case let x where x < minValidLoc:
            return minValue
            
        case let x where x > maxValidLoc:
            return maxValue
            
        default:
            return ((location.x - minValidLoc) / locationValidRange * valueRange) + minValue
        }
    }
}
