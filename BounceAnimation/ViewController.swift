//
//  ViewController.swift
//  BounceAnimation
//
//  Created by Paul Tang on 2019-07-08.
//  Copyright © 2019 Paul Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var safeView: UIView!
    
    var animation = animationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animation.superView = safeView
        animation.image = UIImage(named: "megaphone")
        animation.startAnimation()
        
        // delay for 5 s
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.animation.stopAnimation()
        }        
    }
}


/**
 
 HOW-TO GUIDE:
 
 1. Put:
 ---
 var loadingAnimation = animationView()
 ---
 in ViewController class
 
 
 2. Set up loadingAnimation by setting up the superView and image (optional):
 ---
 loadingAnimation.superView = scrollView
 if let image = UIImage(named: "IMAGE_NAME") {
 loadingAnimation.image = image
 }
 ---
 
 
 3. Start animation:
 ---
 loadingAnimation.startAnimation()
 ---
 
 
 4. Stop animation:
 ---
 loadingAnimation.stopAnimation()
 ---
 
 **/

struct animationView {
    
    // This is used to remove the animation view
    var viewTag: Int? = Int.random(in: 999..<99999)     // <-- default value to a random number
    
    // This is used to add/ remove view to/from the inputed view
    var superView: UIView?
    
    // This is a custome image to put for animation
    var image: UIImage?
    
    // sets up animation view
    // using mutating func to be able to modify viewTag initialized above
    func startAnimation() {
        
        // unwrap optionals
        guard
            let tagNum = self.viewTag,
            let view = self.superView
            else {
                return
        }
        
        // add animation view to self.view
        let animationView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        
        // do any design of the animation view here
        animationView.backgroundColor = UIColor.gray
        
        // set tag for animation view to be able to remove it later, add animation view to inputed view
        animationView.tag = tagNum
        view.addSubview(animationView)
        
        // image argument can be optional, in that case, only the animation view is displayed and the image view won't be added to animation view
        if let image = self.image {
            
            // add imageView to animation view
            let imageView = UIImageView(image: image)
            // put imageView in center of animationView and set width & height to 100
            let height: CGFloat = 100
            let width: CGFloat = 100
            imageView.frame = CGRect(x: animationView.bounds.width / 2 - (width / 2), y: animationView.bounds.height / 2 - (height / 2), width: width, height: height)
            // do any design of the animation view here
            
            // add imageView to animation view
            animationView.addSubview(imageView)
            
            // set up "jumping" animations for imageView
            UIView.animate(withDuration: 0.6, animations: {
                imageView.frame.origin.y -= 60
            }) {
                _ in
                // down
                UIView.animateKeyframes(withDuration: 0.6, delay: 0.1, options: [.autoreverse, .repeat], animations: {
                    imageView.frame.origin.y += 60
                })
            }
        }
    }
    
    // dismisses animatiovn view
    func stopAnimation() {
        guard
            let viewTag = viewTag,
            let superView = superView,
            let animationView = superView.viewWithTag(viewTag)
            else {
                // !!! cannot dismiss animation view !!!
                return
        }
        // remove view
        animationView.removeFromSuperview()
    }
}


