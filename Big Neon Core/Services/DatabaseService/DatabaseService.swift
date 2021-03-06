

import Foundation
import SwiftKeychainWrapper

public class DatabaseService {
    
    public class var shared: DatabaseService {
        struct Static {
            static let instance: DatabaseService = DatabaseService()
        }
        return Static.instance
    }
    
    public init() {
    }
    
    public func fetchAcessToken() -> String? {
        return KeychainWrapper.standard.string(forKey: Constants.keychainAccessToken)
    }
    
    public func fetchRefreshToken() -> String? {
        return KeychainWrapper.standard.string(forKey: Constants.keychainRefreshToken)
    }
    
}
