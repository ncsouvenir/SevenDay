//
//  NetworkHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

enum AppError: Error {
    case invalidImage
    case goodStatusCode(num: Int)
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL(str: String)
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
    case badData
    case codingError(rawError: Error)
    case badStatusCode(num: Int)
    case urlError(rawError: Error)
}

enum HTTPVerb: String {
    case GET
    case POST
}

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: .default)
    
    func performDataTask(with url: URLRequest, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((AppError) -> Void)) {
        
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                
                guard let data = data else {
                    errorHandler(AppError.noDataReceived)
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    errorHandler(AppError.goodStatusCode(num: response.statusCode))
                }
                
                if let error = error as? URLError {
                    switch error {
                    case URLError.notConnectedToInternet:
                        errorHandler(AppError.noInternetConnection)
                        return
                    default:
                        errorHandler(AppError.urlError(rawError: error))
                    }
                }
                
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        errorHandler(AppError.noInternetConnection)
                        return
                    }
                    else {
                        errorHandler(AppError.other(rawError: error))
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}
