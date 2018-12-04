//
//  LocalAuthenticationLoginManager.swift
//  FingerPrintWithACL
//
//  Created by Vinit Shanbhag on 13/09/18.
//  Copyright © 2018 Vinit Shanbhag. All rights reserved.
//

import Foundation


public typealias AlertCompletion = () -> Void

protocol LocalAuthenticationLoginDelegate: class {
    func askToEnableBiometricLogin(onConfirm: @escaping AlertCompletion, onCancel: @escaping AlertCompletion)
    func tryLoginWithCredentials(username: String, password: String)
    func showErrorAlert(title: String, message: String, onOk completion: AlertCompletion?)
}


protocol LocalAuthenticationLoginManagerType: class {
    var delegate: LocalAuthenticationLoginDelegate? { get set }
    var isLocalAuthenticationLoginEnabled: Bool { get set }
    var savedUserName: String? { get }
    func useSavedCredntialsToLogin()
    func loggedIn(_ userName: String, password: String, onCompletion: @escaping (() -> Void) )
    func verifyPassword( password: String, completionHandler: (_ error: Error?) -> Void)
}


final class LocalAuthenticationLoginManager: LocalAuthenticationLoginManagerType {
    
    private enum LAKeys {
        static let isLAEnabled = "MyAPP_LAkeyEnabled"
    }
    
    private var credentialStore: UserCredentialStoreType
    private let preferenceStore = UserDefaults.standard
    weak var delegate: LocalAuthenticationLoginDelegate?
    
    var savedUserName: String? {
        return credentialStore.userName
    }
    
    private var currentlySignedInUserName: String? {
        return "Some name"
    }
    
    var isLocalAuthenticationLoginEnabled: Bool {
        set {
            preferenceStore.set(newValue, forKey: LAKeys.isLAEnabled)
        }
        get {
            if let signedInName = currentlySignedInUserName, let savedName = savedUserName, signedInName.caseInsensitiveCompare(savedName) != .orderedSame {
                return false
            }
            return preferenceStore.value(forKey: LAKeys.isLAEnabled) as? Bool ?? false
        }
        
    }
    
    init() {
        self.credentialStore = CredentialManager()
    }
    
    func loggedIn(_ userName: String, password: String, onCompletion: @escaping (() -> Void)) {
        guard  LocalAuthenticationCordinator.canAuthenticateWithBiometrics() else {
            onCompletion()
            return
        }
        
        // if the new username is not same as the old one then remove the stored password and store new one
        let cachedName = savedUserName
        guard cachedName != userName else {
            if isLocalAuthenticationLoginEnabled {
                credentialStore.storePassword(password: "")
                credentialStore.storePassword(password: password)
            }
            onCompletion()
            return
        }
        
        delegate?.askToEnableBiometricLogin(onConfirm: { [weak self] in
            self?.credentialStore.userName = userName
            let authenticationReason = "Enable Local Authentication to sign in next time"
            
            let success: LocalAuthenticationCordinator.AuthenticationSuccess = { [weak self] in
                self?.isLocalAuthenticationLoginEnabled = true
                self?.credentialStore.storePassword(password: "")
                self?.credentialStore.storePassword(password: password)
                
               onCompletion()
            }
            
            let failure: LocalAuthenticationCordinator.AuthenticationFailure = { [weak self] error in
                let authenticationMethod = LocalAuthenticationCordinator.isFaceIDAvailable() ? "Face ID" : "Touch ID"
                let alertTitle = "\(authenticationMethod)"
                let alertMessage = "The authentication is not succesful"
                self?.delegate?.showErrorAlert(title: alertTitle, message: alertMessage, onOk: {
                    onCompletion()
                })
                
            }
            
            LocalAuthenticationCordinator.authenticate(with: authenticationReason, success: success, failure: failure)
            }, onCancel: { [weak self] in
                if cachedName == nil {
                    self?.credentialStore.userName = userName
                }
                onCompletion()
        })
        
        
    }
    
    func useSavedCredntialsToLogin() {
        guard isLocalAuthenticationLoginEnabled, LocalAuthenticationCordinator.canAuthenticateWithBiometrics(),
            let username = savedUserName else {return}
        
        credentialStore.retrievePassword(reasonForAcess: "Sign in with the biometric ") { [weak self] (password, error) in
            guard let strongSelf = self else {return}
            
            if error != nil {
                let alertMethodFailure = LocalAuthenticationCordinator.isFaceIDAvailable() ? "Face ID" : "Touch ID"
                let alertTitle = "\(alertMethodFailure)"
                let alertMessage = "Failed to authenticate"
                strongSelf.delegate?.showErrorAlert(title: alertTitle, message: alertMessage, onOk: nil)
                
            }
            
            DispatchQueue.main.async {
                strongSelf.delegate?.tryLoginWithCredentials(username: username, password: password ?? "")
            }
        }
        
        
    }
    
    func verifyPassword(password: String, completionHandler: (Error?) -> Void) {
        
    }
    
    
}
