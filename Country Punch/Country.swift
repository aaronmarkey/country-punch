//
//  Country.swift
//  Country Punch
//
//  Created by Aaron Markey on 8/29/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit

class Country {
    //MARL: Properties
    
    var name: String
    var capital: String
    var latitude: Float
    var longitude: Float
    
    //MARK: Initialization
    
    init(name: String, capital: String, lat: Float, long: Float) {
        self.name = name
        self.capital = capital
        self.latitude = lat
        self.longitude = long
    }
}
