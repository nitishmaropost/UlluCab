//
//  LoginVC.swift
//  UlluCab
//
//  Created by maropost on 09/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var textFieldUsername: DesignableTextField!
    @IBOutlet weak var textFieldPassword: DesignableTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    func configureUI() {
        self.textFieldUsername.withImage(direction: .Left, image: UIImage(named: "placeholder_username.png") ?? UIImage(), andColor: UIColor.lightGray)
        self.textFieldPassword.withImage(direction: .Left, image: UIImage(named: "placeholder_password.png") ?? UIImage(), andColor: UIColor.lightGray)
    }
    
    @IBAction func buttonLoginPressed(sender: UIButton) {
        self.performSegue(withIdentifier: UlluConstants.shared.SEGUE_LOGIN_TO_HOME, sender: nil)
    }
}
