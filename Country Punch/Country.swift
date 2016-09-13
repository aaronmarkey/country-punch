//
//  Country.swift
//  Country Punch
//
//  Created by Aaron Markey on 8/29/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit
import SwiftyJSON

class Country: NSObject {
    //MARK: Properties
    
    let alpha3code: String
    let capital: String
    let latitude: Float
    let longitude: Float
    let domains: [String]
    let currencies: [String]
    let region: String
    let subregion: String
    let languages: [String]
    let population: Double
    let area: Double
    let timezones: [String]
    let borders: [String]

    let name: String
    let nameTranslations: [String]
    let nameAltSpellings: [String]
    let nameNative: String
    
    
    //MARK: Initialization
    init(json: (String, JSON)) {
        self.alpha3code = json.1["alpha3code"].stringValue
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
