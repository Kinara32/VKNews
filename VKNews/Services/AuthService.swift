//
//  AuthService.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 17.03.2023.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    private let appId = "51582180"
    private let vkSdk: VKSdk
    weak var delegate: AuthServiceDelegate?
    var token: String? {
        VKSdk.accessToken().accessToken
    }

    var userId: String? {
        VKSdk.accessToken().userId
    }

    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }

    func wakeUpSession() {
        let scope = ["wall", "friends"]
        VKSdk.wakeUpSession(scope) { [delegate] state, _ in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInDidFail()
            }
        }
    }

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }

    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFail()
    }

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }

    func vkSdkNeedCaptchaEnter(_: VKError!) {
        print(#function)
    }
}
