//
//  CredentialManager.swift
//  FingerPrintWithACL
//
//  Created by Vinit Shanbhag on 14/09/18.
//  Copyright © 2018 Vinit Shanbhag. All rights reserved.
//
import Foundation

public protocol UserCredentialStoreType {
    var userName: String { get set }
    func storePassword(password: String)
    func retrievePassword(reasonForAcess: String, comepletionHandler: @escaping (String?, Error?) -> Void)
}


final class CredentialManager: UserCredentialStoreType {
    
    private let secretStore = KeyChain()
    
    struct KeyIdentifiers {
        private static var prefix = "FingerPrintACLIdentity_"
        
        static let username = "\(prefix)username"
        static let password = "\(prefix)password"
        
    }
    
    public var userName: String {
        set {
            DispatchQueue.global().sync { [weak self]  in
                if let status = self?.secretStore.store(value: newValue, for: KeyIdentifiers.username) {
                    print((status as KeyChainError).stringValue)
                }
            }
        }
        get {
            var resultantName: String = ""
            let returnedValue = secretStore.getValue(for: KeyIdentifiers.username)
            if let name = returnedValue.result, returnedValue.error == nil  {
                resultantName = name
            }
            return resultantName
        }
    }
    
    public func storePassword(password: String) {
        
    }
    
    func retrievePassword(reasonForAcess: String, comepletionHandler: @escaping (String?, Error?) -> Void) {
        
    }
    
}
