//
//  APIError.swift

import Foundation

public enum APIError: CustomNSError {
    
    case invalidURL
    case invalidResponseType
    case httpStatusCodeFailed(statusCode: Int, error: ErrorResponse?)
    
    
    public static var errorDomain: String {"TradeTrackerStocksAPI"}
    
    public var errorCode: Int {
        
        switch self{
            
            case .invalidURL: return 0
            case .invalidResponseType: return 1
            case .httpStatusCodeFailed: return 2
                
        }
    }
    
    public var errorUserInfo: [String : Any] {
        
        let text: String
        
        switch self {
                
            case .invalidURL:
                text = "Invalid URL"
            case .invalidResponseType:
                text = "Invalid response type"
            case let .httpStatusCodeFailed(statusCode, error):
                
                if let error = error {
                    
                    text = "Error: Status Code\(error.code), message: \(error.message)"
                    
                } else {
                    
                    text = "Error: Status Code \(statusCode)"
                    
                }
                
        }
        
        return [NSLocalizedDescriptionKey: text]
        
    }
}
