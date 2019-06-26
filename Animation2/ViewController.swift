//
//  ViewController.swift
//  Animation2
//
//  Created by Erwin Warkentin on 26.06.19.
//  Copyright © 2019 Erwin Warkentin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//Visualize the curve
//        let curvedView = CurvedView(frame: view.frame)
//        curvedView.backgroundColor = .yellow
//
//         view.addSubview(curvedView)
        

        

        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
 @objc func handleTap() {
        (0...10).forEach { (_) in
            generateAnimatedViews()
        }
    }

    fileprivate func generateAnimatedViews(){
//gives a random picture
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "thumbs_up") : #imageLiteral(resourceName: "heart")
//select the image
        let imageView = UIImageView(image: image)
//random size of the image
        let dimension = 20 + drand48() * 10
//frame of the image
        
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
//tell the animation whith path is has to go
        animation.path = customPath().cgPath
//the duration
        animation.duration = 2 + drand48() * 3
//
        animation.fillMode = .forwards
//after running the curve it Removes him self
        animation.isRemovedOnCompletion = false
//running properties
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        imageView.layer.add(animation, forKey: nil)
                view.addSubview(imageView)
    }

}

//draw the curve
func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x: 0, y: 200))
    
    let endPoint = CGPoint(x: 500, y: 200)
    
    let randomYShift = 200 + drand48() * 350
    let cp1 = CGPoint(x: 150, y: 100 - randomYShift)
    let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
    
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView: UIView {
    
    override func draw(_ rect: CGRect) {
//do some fancy curve drawing
        let path = customPath()
        path.lineWidth = 3
        path.stroke()
    
    }
}
