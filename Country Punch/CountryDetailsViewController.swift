//
//  CountryDetailsViewController.swift
//  Country Punch
//
//  Created by Aaron Markey on 8/31/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit
import MapKit

class CountryDetailsViewController: UIViewController {

    //MARK: Variables
    var country: Country!
    
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var regionAndSubregion: UILabel!
    @IBOutlet weak var timezones: UILabel!
    @IBOutlet weak var borderingCountries: UILabel!
    @IBOutlet weak var languages: UILabel!
    @IBOutlet weak var currencies: UILabel!
    @IBOutlet weak var tlds: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    

    //MARK: View Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set navbar title
        navigationItem.title = country.name
        
        //set details info
        capital.text = !country.capital.isEmpty ? country.capital : "None"
        population.text = self.formatNumber(country.population) + " people"
        area.text = self.formatNumber(country.area) + " square kilometers"
        regionAndSubregion.text = self.generateRegionText(country.region, subRegion: country.subregion)
        timezones.text = self.arrayToString(country.timezones, format: nil)
        borderingCountries.text = self.arrayToString(country.borders, format: nil)
        languages.text = self.arrayToString(country.languages, format: nil)
        currencies.text = self.arrayToString(country.currencies, format: {(code: String) -> String in
            let local = Locale(identifier: code)
            return (local as NSLocale).displayName(forKey: NSLocale.Key.currencySymbol, value: code)! + " (\(code))"
        })
        tlds.text = self.arrayToString(country.domains, format: nil)
        map.setRegion(generateMapRegion(country.latitude, long: country.longitude,
            area: country.area, height: map.bounds.height, width: map.bounds.width, size: 6), animated: true)
        map.addAnnotation(generateMapAnnotation(country.latitude, long: country.longitude, name: country.name))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func arrayToString(_ array: [String], format: ((String) -> String)?) -> String {
        var string = ""
        if !array.isEmpty {
            for item in array {
                if let formatter = format {
                    string += formatter(item)
                } else {
                    string += item
                }
                if item != array.last {
                    string += ", "
                }
            }
        } else {
            string = "None"
        }
    
        return string
    }
    
    func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        
        return formatter.string(from: number as NSNumber)!
    }
    
    func generateMapRegion(_ lat: Float, long: Float, area: Double, height: CGFloat, width: CGFloat, size: Double) -> MKCoordinateRegion {
        let square = sqrt(area)
        let latDelta = square/Double(height) * size
        let longDelta = square/Double(width) * size
        let center = CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(long))
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        return MKCoordinateRegion(center: center, span: span)
    }
    
    func generateMapAnnotation(_ lat: Float, long: Float, name: String) -> MKPointAnnotation {
        let anno = MKPointAnnotation()
        anno.coordinate.latitude = Double(lat)
        anno.coordinate.longitude = Double(long)
        anno.title = name
        
        return anno
    }
    
    func generateRegionText(_ region: String, subRegion: String!) -> String {
        if !subRegion.isEmpty {
            return region + ", " + subRegion
        } else {
            return region
        }
    }
    
    func getSymbolForCurrencyCode(_ code: String) -> String? {
        let locale = Locale(identifier: code)
        return (locale as NSLocale).displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }

}
