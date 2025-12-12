//
//  Ticker.swift

import Foundation

public struct SearchTickerResponce: Codable{
    
    public let data: [Ticker]?
    public let status: String?
    
    enum CodingKeys: String, CodingKey {
        
        case data
        case status
        
    }
    
    public init(from decoder: Decoder, status: String?) throws {
        
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try? container.decodeIfPresent([Ticker].self, forKey: .data)
        
        self.status = status
    }
}

public struct Ticker: Codable, Hashable, Equatable, Identifiable {
    
    public let id = UUID()
    
    public let symbol: String?
    public let instrumentName: String?
    public let exchange: String?
    public let micCode: String?
    public let exchangeTimezone: String?
    public let instrumentType: String?
    public let country: String?
    public let currency: String?
    
    enum CodingKeys: String, CodingKey {
        
        case symbol
        case instrumentName = "instrument_name"
        case exchange
        case micCode = "mic_code"
        case exchangeTimezone = "exchange_timezone"
        case instrumentType = "instrument_type"
        case country
        case currency
        
    }
    
    public init(
        
        symbol: String?,
        instrumentName: String? = nil,
        exchange: String? = nil,
        micCode: String? = nil,
        exchangeTimezone: String? = nil, 
        instrumentType: String? = nil,
        country: String? = nil,
        currency: String? = nil
        
    ){
        
        self.symbol = symbol
        self.instrumentName = instrumentName
        self.exchange = exchange
        self.micCode = micCode
        self.exchangeTimezone = exchangeTimezone
        self.instrumentType = instrumentType
        self.country = country
        self.currency = currency
        
    }
}
