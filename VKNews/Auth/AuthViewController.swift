//
//  ViewController.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 15.03.2023.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
//        let scene = UIApplication.shared.connectedScenes.first
//        authService = (scene?.delegate as? SceneDelegate)!.authService
    }

    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

