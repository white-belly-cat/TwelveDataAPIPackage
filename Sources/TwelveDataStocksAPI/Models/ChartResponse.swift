//
//  ChartResponse.swift

import Foundation

public struct ChartResponse: Codable {
    
    public let id = UUID()
    
    public let meta: Meta?
    public let values: [Value]?
    
    enum CodingKeys: String, CodingKey {
        
        case meta
        case values
        
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meta = try container.decodeIfPresent(Meta.self, forKey: .meta)
        values = try container.decodeIfPresent([Value].self, forKey: .values)
        
    }
}


public struct Meta: Codable {
    
    public let symbol: String?
    public let interval: String?
    public let currency: String?
    public let exchangeTimezone: String?
    public let exchange: String?
    public let micCode: String?
    public let type: String?
    
    enum CodingKeys: String, CodingKey{
        case symbol
        case interval
        case currency
        case exchangeTimezone = "exchange_timezone"
        case exchange
        case micCode = "mic_code"
        case type
    }
    
    public init(
        
        symbol: String?,
        interval: String?,
        currency: String?,
        exchangeTimezone: String?,
        exchange: String?,
        micCode: String?,
        type: String?
        
    )
    {
    
    self.symbol = symbol
    self.interval = interval
    self.currency = currency
    self.exchangeTimezone = exchangeTimezone
    self.exchange = exchange
    self.micCode = micCode
    self.type = type
    
    }
}
public struct Value: Codable {
    
    public let datetime: Date?
    public let open: String?
    public let high: String?
    public let low: String?
    public let close: String?
    public let volume: String?
    
    enum CodingKeys: String, CodingKey {
        
        case datetime
        case open
        case high
        case low
        case close
        case volume
        
    }
    public init(
        
        datetime: Date?,
        open: String?,
        high: String?,
        low: String?,
        close: String?,
        volume: String?
        
    ) {
        
    self.datetime = datetime
    self.open = open
    self.high = high
    self.low = low
    self.close = close
    self.volume = volume
        
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let dateString = try container.decodeIfPresent(String.self, forKey: .datetime) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            datetime = formatter.date(from: dateString)
        } else {
            datetime = nil
        }
        
        open = try container.decodeIfPresent(String.self, forKey: .open)
        high = try container.decodeIfPresent(String.self, forKey: .high)
        low = try container.decodeIfPresent(String.self, forKey: .low)
        close = try container.decodeIfPresent(String.self, forKey: .close)
        volume = try container.decodeIfPresent(String.self, forKey: .volume)
        
    }
}
