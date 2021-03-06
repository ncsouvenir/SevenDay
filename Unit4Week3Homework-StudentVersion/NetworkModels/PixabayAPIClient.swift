//
//  PixabayAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation


class PixabayAPIClient {
    private init(){}
    static let manager = PixabayAPIClient()

    func getCityImage(from urlStr: String,
                     completionHandler: @escaping (PixabayImage) -> Void,
                     errorHandler: @escaping (Error) -> Void){
        
         guard let request = buildRequest(with: urlStr) else {errorHandler(AppError.badURL(str: urlStr)); return}

        //set completion
        let parseDataIntoImages: (Data) -> Void = {(data: Data) in
            do{
                let decoder = JSONDecoder()
                let allResults = try decoder.decode(ImageResponseWrapper.self, from: data) //when you decode the top layer you see what's inside.
                let pixabayImage = allResults.hits.first ?? PixabayImage(previewURL: "", webURL: "", id: 0.0) //PixabayImage
               
                completionHandler(pixabayImage)
                //print("JSON Data is now a PixabayImage")
            } catch {
                errorHandler(AppError.badData)
                print("bad data from pixabay")
            }
        }
        NetworkHelper.manager.performDataTask(with: request,
                                              completionHandler: parseDataIntoImages,
                                              errorHandler: errorHandler)
    }
    private func buildRequest(with str: String) -> URLRequest? {
        //string being used to pass into Weather API call
        let urlStr = "https://pixabay.com/api/?key=\(APIKeys.pixabayAPIKey)&q=" + str + "&photo&safesearch=true"
        let searchString = urlStr.removingWhitespaces()
        guard let url = URL(string: searchString) else { return nil }
        let request = URLRequest(url: url)
        return request
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

 
