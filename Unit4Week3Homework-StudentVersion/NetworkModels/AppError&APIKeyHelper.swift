//
//  AppError&APIKeyHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

//WEATHER: will need a unique identifier for input for the zipcode entry
//7 day forecast
//EX)"https://api.aerisapi.com/forecasts/\(keyword)?\(APIKeys.weatherClientID)&client_secret=\(APIKeys.weatherSecretKey)"

//PIXABAY: will need keyword to get random image for the city
//EX) "https://pixabay.com/api/?key=\(APIKeys.pixabayAPIKey)&q=\(keyword)=photo"

struct APIKeys{
    private init(){}
    static let weatherClientID = "IG2CMqgjQ7CTs9A58ipt7"
    static let weatherSecretKey = "wt32P2wpKj5jkZc0mpaGdaJ38rZGdLxpk0KscnQO"
    static let pixabayAPIKey = "6859963-67ff765beafa661121af31c"
}

