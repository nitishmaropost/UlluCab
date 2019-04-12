//
//  UITextField+PlaceholderIcon.swift
//  UlluCab
//
//  Created by maropost on 10/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    enum Direction {
        case Left
        case Right
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 16))
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 16))
        view.backgroundColor = .clear
        view.clipsToBounds = true
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 5, y: 0, width: 16, height: 16)
        view.addSubview(imageView)
        
        if(Direction.Left == direction){ // image left
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            self.rightViewMode = .always
            self.rightView = mainView
        }
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, andColor color: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 16))
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 16))
        view.backgroundColor = .clear
        view.clipsToBounds = true
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = color
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 5, y: 0, width: 16, height: 16)
        view.addSubview(imageView)
        
        if(Direction.Left == direction){ // image left
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            self.rightViewMode = .always
            self.rightView = mainView
        }
    }
}
