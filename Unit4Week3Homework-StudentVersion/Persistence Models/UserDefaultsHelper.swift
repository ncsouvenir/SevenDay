//
//  UserDefaultsHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Nicole Souvenir on 1/6/18.
//  Copyright © 2018 C4Q . All rights reserved.
//
import Foundation
struct UserDefaultsHelper {
    static let manager = UserDefaultsHelper()
    private init() {}
    
    private let dateKey = "date"
    private let zipcodeKey = "zipcode"
    
    //Save Stuff
    func getTomorrowDate() -> Date? {
        return UserDefaults.standard.value(forKey: dateKey) as? Date
    }
    func getZipcode() -> String? {
        return UserDefaults.standard.string(forKey: zipcodeKey)
    }
    
    //Get Stuff
    func setTomorrowDate(to newDate: Date) {
        UserDefaults.standard.setValue(newDate, forKey: dateKey)
    }
    func setZipcode(to newZipcode: String) {
        UserDefaults.standard.setValue(newZipcode, forKey: zipcodeKey)
    }
}
