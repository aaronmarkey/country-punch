//
//  CountryTableViewController.swift
//  Country Punch
//
//  Created by Aaron Markey on 8/29/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CountryTableViewController: UITableViewController {
    
    
    //MARK: Properties
    var countries = [Country]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountries({(newCountries: [Country]) in
            self.countries = newCountries
            self.tableView.reloadData()
        })
        self.navigationItem.title = "Country Punch"
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    // MARK: - Table view data source
    func loadCountries(completion: ([Country])->()) {
        var countryList = [Country]()
        Alamofire.request(.GET, "https://restcountries.eu/rest/v1/all").validate().responseJSON { response in
            if let value = response.result.value {
                let json = JSON(value)
                for j in json {
                    let country = Country(json: j)
                    countryList.append(country)
                }
                completion(countryList)
            } else {
                print("Error in response")
            }
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CountryTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CountryTableViewCell
        
        let country = countries[indexPath.row]
        
        cell.countyTitleLabel.text = country.name
        
        return cell
    }


    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCountryDetails" {
            let nextScene =  segue.destinationViewController as! CountryDetailsViewController
            let countryIndex = tableView.indexPathForSelectedRow as NSIndexPath?
            
            //set back button text on navbar
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
            //pass country to next view
            nextScene.country = countries[countryIndex!.row]
        }
    }
    

}
