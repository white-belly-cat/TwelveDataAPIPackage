//
//  TwelveDataStocksAPIExec.swift

import Foundation
import TwelveDataStocksAPI

@main
struct StocksAPIExec{
    
    nonisolated(unsafe) static let stocksAPI = TradeTrackerStocksAPI()
    
    static func main() async {
        do {
            let quotes = try await stocksAPI.fetchQuotes(
                symbols: "TSLA, MSFT",
                apikey: "YourAPIKEY!!!!"
            )
            print(quotes)
            
            let tickers = try await stocksAPI.searchTickers(query: "tesla")
            for ticker in tickers {
                print(ticker.country!)
            }
            
            let chart = try await stocksAPI.fetchChartData(
                symbol: "TSLA",
                range: .oneDay,
                apikey: "YourAPIKEY!!!!"
            )
            print(chart!)
        }    catch let apiError as APIError {
            
            // Вывод кастомной ошибки
            let description = apiError.errorUserInfo[NSLocalizedDescriptionKey] as? String ?? "Unknown error"
            print("Custom API Error: \(description)")
        } catch {
            print("Other error: \(error.localizedDescription)")
        }
    }
}
