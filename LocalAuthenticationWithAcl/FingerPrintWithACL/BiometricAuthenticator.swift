//
//  BiometricAuthenticator.swift
//  FingerPrintWithACL
//
//  Created by Vinit Shanbhag on 13/09/18.
//  Copyright © 2018 Vinit Shanbhag. All rights reserved.
//

import Foundation
import LocalAuthentication

public final class BiometrciAuthenticator {
    
    public typealias AuthenticationSuccess = (() -> Void)
    
    public typealias AuthenticationFailure = ((Error) -> Void)
    
    public static func canAuthenticateWithBiometrics() -> Bool {
        
        var isBiometryEnabled: Bool = false
        var error: NSError? = nil
        
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            isBiometryEnabled = (error == nil)
        }
        
        return isBiometryEnabled
    }
    
    public static func authenticate(with localizedReason: String, fallbackTitle: String = "", success successBlock: @escaping AuthenticationSuccess, failure failureBlock: @escaping AuthenticationFailure) {
        
        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason) { (success, error) in
            if success {
                successBlock()
            }
            else {
                if let authError = error {
                    failureBlock(authError)
                }
            }
        }
        
    }
}