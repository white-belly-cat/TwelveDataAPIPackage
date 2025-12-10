//
//  ChartRange.swift

import Foundation

public enum ChartRange: String, CaseIterable{
    
    case oneDay = "1440" //1 min
    case oneWeek = "2016" //5 min
    case oneMonth = "1488" //30 min
    case threeMonth = "2232" //1 h
    case sixMonth = "2233" //2 h
    case oneYear = "1752"//5 h
    case twoYear = "730" //1 d
    case fiveYear = "261" //1 week
    case tenYear = "522" //1 week
    case max = "1044" //1 week
    
    public var interval: String {
        
        switch self {
            
            case .oneDay: return "1min"
            case .oneWeek: return "5min"
            case .oneMonth: return "30min"
            case .threeMonth: return "1h"
            case .sixMonth: return "2h"
            case .oneYear: return "5h"
            case .twoYear: return "1day"
            case .fiveYear, .tenYear, .max: return "1week"
                
        }
    }
}
