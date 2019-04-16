//
//  InitialAnimationVC.swift
//  UlluCab
//
//  Created by maropost on 15/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import RimhTypingLetters

class InitialAnimationVC: UIViewController {
    
    @IBOutlet weak var imageAnimation: UIImageView!
    @IBOutlet weak var labelTypeText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.animateLabel()
    }
    
    func configureUI() {
        self.labelTypeText.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 60)
    }
    
    func bounceAnimation() {
        UIView.animate(withDuration:1,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.6,
                       options: [],
                       animations: {
                       self.imageAnimation.center.y = self.view.center.y - 50
        }, completion: {
            (value: Bool) in
            self.rotateAnimation()
        })
        
    }
    
    func animateLabel() {
        self.labelTypeText.typeText("Ullu Cab", typingSpeedPerChar: 0.2, didResetContent: true) {
            DispatchQueue.main.async {
                self.bounceAnimation()
            }
        }
    }
    
    func rotateAnimation() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.rotateAnimation(direction: 0)
        }) { (success) in
            UIView.animate(withDuration: 0.5, animations: {
                self.rotateAnimation(direction: 1)
            }) { (success) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.imageAnimation.transform = CGAffineTransform(rotationAngle: 0)
                }) { (success) in
                    self.navigate()
                }
            }
        }
    }
    
    func rotateAnimation(direction: Int) {
        if direction == 0 {
            self.imageAnimation.transform = CGAffineTransform(rotationAngle: -100)
            
        } else {
            self.imageAnimation.transform = CGAffineTransform(rotationAngle: 100)
        }
    }
    
    func navigate() {
        let authStoryboard = UIStoryboard.init(name: "Authentication", bundle: nil)
        let authVC = authStoryboard.instantiateViewController(withIdentifier: "LoginVC")
        self.view.window?.rootViewController = authVC
    }
}

