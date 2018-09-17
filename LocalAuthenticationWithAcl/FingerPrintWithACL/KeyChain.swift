//
//  KeyChain.swift
//  FingerPrintWithACL
//
//  Created by Vinit Shanbhag on 15/09/18.
//  Copyright © 2018 Vinit Shanbhag. All rights reserved.
//

import Foundation

public enum KeyChainError: Error{
    case addItemFailure
    case itemNotFound
    
    var stringValue: String {
        switch self {
        case .addItemFailure: return "Not able to add Item to the keychain"
        case .itemNotFound: return "Item not found in keychain for the key specified"
        }
    }
}

/// To work with all sorts of keychain related api s
final class KeyChain {
    
    /// Store any object with key/value
    public func store(value: String, for key: String) -> KeyChainError? {
        let data = value.data(using: .utf8)!
        let addQuery: Dictionary<String, Any> = [kSecClass as String: kSecClassKey,
                                                 kSecAttrApplicationTag as String: key,
                                                 kSecValueData as String: data]
        
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        guard status == errSecSuccess else {
            return KeyChainError.addItemFailure
        }
        return nil
    }
    
    /// Retrieve value with specific key
    public func getValue(for key: String) -> (result :String?, error: Error?) {
        let getQuery: Dictionary<String, Any> = [kSecClassKey as String: kSecClassKey,
                                                 kSecAttrApplicationTag as String: key,
                                                 kSecReturnData as String: kCFBooleanTrue]
        
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(getQuery as CFDictionary, UnsafeMutablePointer($0))
            
        }
        
        guard status == noErr, let value = String(data: queryResult as! Data , encoding: .utf8) else {
            return (nil, KeyChainError.itemNotFound)
        }
        return (value, nil)
    }
    
    
    /// Store the important passwords
    public func set(password: String, forKey key: String)  -> KeyChainError? {
        var error: Unmanaged<CFError>?
        
        guard let accessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .touchIDCurrentSet, &error) else {
            assertionFailure("failed to create the access control object")
            return nil
        }

        var query: Dictionary<String, Any> = [:]
        
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrLabel as String] = CFBundleGetIdentifier(Bundle.main as! CFBundle) as CFString
        query[kSecAttrAccount as String] = "FingerPrintWithACL Account" as CFString
        query[kSecValueData as String] = password.data(using: .utf8)! as CFData
        query[kSecAttrApplicationTag as String] = key
        query[kSecAttrAccessControl as String] = accessControl
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != noErr {
            return KeyChainError.addItemFailure
        }
        return nil
    }
    
    /// Retrieve password
    public func getString(for key: String, localizedReason: String, completionHandler: (String? , Error?) -> Void) {
        
        var query = [String: Any]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecAttrAccount as String] = "FingerPrintWithACL Account" as CFString
        query[kSecAttrApplicationTag as String] = key
        query[kSecAttrLabel as String] =  CFBundleGetIdentifier(Bundle.main as! CFBundle) as CFString
        query[kSecUseOperationPrompt as String] = localizedReason as CFString
        
        var queryResult: AnyObject?
        
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if status == noErr, let password = String(data: queryResult as! Data, encoding: .utf8) {
            completionHandler(password, nil)
        } else {
            completionHandler(nil, KeyChainError.itemNotFound)
        }
        
    }
}
