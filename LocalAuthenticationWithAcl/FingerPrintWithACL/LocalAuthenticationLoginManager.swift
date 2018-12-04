//
//  LocalAuthenticationLoginManager.swift
//  FingerPrintWithACL
//
//  Created by Vinit Shanbhag on 13/09/18.
//  Copyright © 2018 Vinit Shanbhag. All rights reserved.
//

import Foundation


public typealias AlertCompletion = () -> Void

protocol BiometricLoginType {
    func askToEnableBiometricLogin(onConfirm: @escaping AlertCompletion, onCancel: @escaping AlertCompletion)
    func tryLoginWithCredentials(username: String, password: String)
    func showErrorAlert(title: String, message: String, onOk completion: AlertCompletion?)
}

final class LocalAuthenticationLoginManager  {
    
    
    
}
