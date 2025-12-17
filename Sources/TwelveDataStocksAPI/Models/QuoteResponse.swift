//
//  QuoteResponse.swift

import Foundation

public struct Quote: Codable {
    
    public let id = UUID() //id для SwiftUI
    
    public let symbol: String
    public let name: String?
    public let exchange: String?
    public let micCode: String?
    public let currency: String?
    public let datetime: Date?
    public let timestamp: Date?
    public let lastQuoteAt: Date?
    public let open: String?
    public let high: String?
    public let low: String?
    public let close: String?
    public let volume: String?
    public let previousClose: String?
    public let change: String?
    public let changePercent: String?
    public let averageVolume: String?
    public let isMarketOpen: Bool?
    public let fiftyTwoWeek: FiftyTwoWeekData?
    
    public init(
        symbol: String,
        name: String? = nil,
        exchange: String? = nil,
        micCode: String? = nil,
        currency: String? = nil,
        datetime: Date? = nil,
        timestamp: Date? = nil,
        lastQuoteAt: Date? = nil,
        open: String? = nil,
        high: String? = nil,
        low: String? = nil,
        close: String? = nil,
        volume: String? = nil,
        previousClose: String? = nil,
        change: String? = nil,
        changePercent: String? = nil,
        averageVolume: String? = nil,
        isMarketOpen: Bool? = nil,
        fiftyTwoWeek: FiftyTwoWeekData? = nil
    ) {
        self.symbol = symbol
        self.name = name
        self.exchange = exchange
        self.micCode = micCode
        self.currency = currency
        self.datetime = datetime
        self.timestamp = timestamp
        self.lastQuoteAt = lastQuoteAt
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
        self.previousClose = previousClose
        self.change = change
        self.changePercent = changePercent
        self.averageVolume = averageVolume
        self.isMarketOpen = isMarketOpen
        self.fiftyTwoWeek = fiftyTwoWeek
    }
    
    enum CodingKeys: String, CodingKey { //Переприсвоили все названия из файла json
        
        case symbol
        case name
        case exchange
        case micCode = "mic_code"
        case currency
        case datetime
        case timestamp
        case lastQuoteAt = "last_quote_at"
        case open
        case high
        case low
        case close
        case volume
        case previousClose = "previous_close"
        case change
        case changePercent = "percent_change"
        case averageVolume = "average_volume"
        case isMarketOpen = "is_market_open"
        case fiftyTwoWeek = "fifty_two_week"
        
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        symbol = try container.decodeIfPresent(String.self, forKey: .symbol) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name)
        exchange = try container.decodeIfPresent(String.self, forKey: .exchange)
        micCode = try container.decodeIfPresent(String.self, forKey: .micCode)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        
        if let dateString = try container.decodeIfPresent(String.self, forKey: .datetime) {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            datetime = formatter.date(from: dateString)
            
        } else {
            
            datetime = nil
            
        }
        
        if let timestampValue = try container.decodeIfPresent(Double.self, forKey: .timestamp) {
            
            timestamp = Date(timeIntervalSince1970: timestampValue)
            
        } else {
            timestamp = nil
        }
        
        if let lastQuoteAtValue = try container.decodeIfPresent(Double.self, forKey: .lastQuoteAt) {
            
            lastQuoteAt = Date(timeIntervalSince1970: lastQuoteAtValue)
            
        } else {
            
            lastQuoteAt = nil
            
        }
        
        open = try container.decodeIfPresent(String.self, forKey: .open)
        high = try container.decodeIfPresent(String.self, forKey: .high)
        low = try container.decodeIfPresent(String.self, forKey: .low)
        close = try container.decodeIfPresent(String.self, forKey: .close)
        volume = try container.decodeIfPresent(String.self, forKey: .volume)
        previousClose = try container.decodeIfPresent(String.self, forKey: .previousClose)
        change = try container.decodeIfPresent(String.self, forKey: .change)
        changePercent = try container.decodeIfPresent(String.self, forKey: .changePercent)
        averageVolume = try container.decodeIfPresent(String.self, forKey: .averageVolume)
        isMarketOpen = try container.decodeIfPresent(Bool.self, forKey: .isMarketOpen)
        fiftyTwoWeek = try container.decodeIfPresent(FiftyTwoWeekData.self, forKey: .fiftyTwoWeek)
        
    }
}

public struct FiftyTwoWeekData: Codable {
    
    public let low: String?
    public let high: String?
    public let lowChange: String?
    public let highChange: String?
    public let lowChangePercent: String?
    public let highChangePercent: String?
    public let range: String?
    
    enum CodingKeys: String, CodingKey {
        
        case low
        case high
        case lowChange = "low_change"
        case highChange = "high_change"
        case lowChangePercent = "low_change_percent"
        case highChangePercent = "high_change_percent"
        case range
        
    }
    
    public init(
        
        low: String?,
        high: String?,
        lowChange: String?,
        highChange: String?,
        lowChangePercent: String?,
        highChangePercent: String?,
        range: String?
        
    ) {
        
        self.low = low
        self.high = high
        self.lowChange = lowChange
        self.highChange = highChange
        self.lowChangePercent = lowChangePercent
        self.highChangePercent = highChangePercent
        self.range = range
        
    }
}
