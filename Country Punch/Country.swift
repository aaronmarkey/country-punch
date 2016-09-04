//
//  Country.swift
//  Country Punch
//
//  Created by Aaron Markey on 8/29/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit
import SwiftyJSON

class Country {
    //MARK: Properties
    
    var capital: String
    var latitude: Float
    var longitude: Float
    var domains: [String]
    var currencies: [String]
    var region: String
    var subregion: String
    var languages: [String]
    var population: Double
    var area: Double
    var timezones: [String]
    var borders: [String]

    var name: String
    var nameTranslations: [String]
    var nameAltSpellings: [String]
    var nameNative: String
    
    
    //MARK: Initialization
    init(json: (String, JSON)) {
        self.capital = json.1["capital"].stringValue
        self.latitude = Float(json.1["latlng"][0].doubleValue)
        self.longitude = Float(json.1["latlng"][1].doubleValue)
        self.domains = Country.stepThroughJson(json.1["topLevelDomain"])
        self.currencies = Country.stepThroughJson(json.1["currencies"])
        self.region = json.1["region"].stringValue
        self.subregion = json.1["subregion"].stringValue
        self.languages = Country.stepThroughJson(json.1["languages"])
        self.population = json.1["population"].doubleValue
        self.area = json.1["area"].doubleValue
        self.timezones = Country.stepThroughJson(json.1["timezones"])
        self.borders = Country.stepThroughJson(json.1["borders"])

        self.name = json.1["name"].stringValue
        self.nameTranslations = Country.stepThroughJson(json.1["translations"])
        self.nameAltSpellings = Country.stepThroughJson(json.1["altSpellings"])
        self.nameNative = json.1["nativeName"].stringValue
    }
   
    
    //MARK: Prive class functions
    private class func stepThroughJson(json: JSON) -> [String] {
        var value = [String]()
        
        for j in json {
            value.append(String(j.1))
        }
        
        return value
    }
    
}
