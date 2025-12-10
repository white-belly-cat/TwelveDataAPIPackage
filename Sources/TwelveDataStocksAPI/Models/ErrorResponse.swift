//
//  ErrorResponse.swift

import Foundation

public struct ErrorResponse: Decodable {
    
    public let code: Int
    public let message: String
    public let status: String
    
    public init(code: Int, message: String, status: String) {
        
        self.code = code
        self.message = message
        self.status = status
        
    }
}
