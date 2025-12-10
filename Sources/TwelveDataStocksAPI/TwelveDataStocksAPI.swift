//
//  TwelveDataStoksAPI.swift

import Foundation

public struct TradeTrackerStocksAPI {
    
    private let session = URLSession.shared
    private let jsonDecoder = {
        let decoder = JSONDecoder()
        return decoder
        
    }()
    
    private let baseURL = "https://api.twelvedata.com"
    public init() {}
    
    public func fetchChartData(symbol: String, range: ChartRange, apikey: String) async throws -> ChartResponse?{
        
        guard var urlComponents = URLComponents(string: "\(baseURL)/time_series") else {
            
            throw APIError.invalidURL
            
        }
        
        urlComponents.queryItems = [
            
            .init(name: "symbol", value: symbol),
            .init(name: "interval", value: range.interval),
            .init(name: "outputsize", value: range.rawValue),
            .init(name: "apikey", value: apikey)
            
        ]
        
        guard let url = urlComponents.url else {
            
            throw APIError.invalidURL
            
        }
        
        let (response, statusCode): (ChartResponse, Int) = try await fetch(
            
            url: url
            
        )
        
        return response
        
    }
    
    public func searchTickers(query: String, isEquityTypeOnly: Bool = true) async throws -> [Ticker]{
        
        guard var urlComponents = URLComponents(string: "\(baseURL)/symbol_search") else {
            throw APIError.invalidURL
            
        }
        
        urlComponents.queryItems = [.init(name: "symbol", value: query)]
        
        guard let url = urlComponents.url else {
            
            throw APIError.invalidURL
            
        }
        
        let (response, statusCode): (SearchTickerResponce, Int) = try await fetch(url: url)
        
        if isEquityTypeOnly{
            
            return (response.data ?? [])
            
                .filter{($0.instrumentType ?? "").localizedCaseInsensitiveCompare("Common Stock") == .orderedSame}
            
        } else {
            
            return response.data ?? []
            
        }
    }
    
    public func fetchQuotes(symbols: String, apikey: String) async throws -> [Quote] {
        
        guard var urlComponents = URLComponents(string: "\(baseURL)/quote") else {
            
            throw APIError.invalidURL
            
        }
        
        urlComponents.queryItems = [
            
            .init(name: "symbol", value: symbols),
            .init(name: "apikey", value: apikey)
            
        ]
        
        guard let url = urlComponents.url else {
            
            throw APIError.invalidURL
            
        }
        if symbols.count <= 6 {
            let (response, statusCode): (Quote, Int) = try await fetch(url: url)
            return [response]
        } else {
            let (response, statusCode): ([String: Quote], Int) = try await fetch(url: url)
            return Array(response.values)
        }
    }
    
    private func fetch<D: Decodable>(url: URL) async throws -> (D, Int) {
        let (data, response) = try await session.data(from: url)
        
//        Debug: Печатаем сырой ответ для отладки
//        print("Debug: HTTP Response received. Status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
//        if let rawString = String(data: data, encoding: .utf8) {
//            print("Debug: Raw response body: \(rawString)")
//        } else {
//            print("Debug: No readable response body")
//        }
        
        let statusCode = try validateHTTPResponseCode(response)
        
//        Если статус >=400, декодируем как ошибку и кидаем APIError
        
        if statusCode >= 400 {
            
            print("Debug: Status >=400, attempting to decode as ErrorResponse")
            
            if let errorResponse = try? jsonDecoder.decode(ErrorResponse.self, from: data) {
                
                print("Debug: Decoded ErrorResponse: code=\(errorResponse.code), message=\(errorResponse.message), status=\(errorResponse.status)")
                
                throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: errorResponse)
                
            } else {
                
                print("Debug: Failed to decode ErrorResponse")
                
                throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: nil)
                
            }
        }
        
//        Только для успешных статусов: Декодируем как D
//        print("Debug: Status OK, decoding as successful response")
        
        return (try jsonDecoder.decode(D.self, from: data), statusCode)
        
    }
    
    private func validateHTTPResponseCode(_ response: URLResponse) throws -> Int{
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponseType
        }
        
        guard 200...299 ~= httpResponse.statusCode || 400...499 ~= httpResponse.statusCode
                
        else {
            
            throw APIError
                .httpStatusCodeFailed(
                    statusCode: httpResponse.statusCode,
                    error: nil
                )
        }
        
        return httpResponse.statusCode
    }
}
