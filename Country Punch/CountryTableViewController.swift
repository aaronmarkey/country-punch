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
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: Properties
    var countries = [Country]()
    var searchedCountries = [Country]()
    let searchController = UISearchController(searchResultsController: nil)



    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load country data
        loadCountries({(newCountries: [Country]) in
            self.countries = newCountries
            self.tableView.reloadData()
        })
        
        self.navigationItem.title = "Country Punch"
        
        //define search bar
        generateSearchBar(searchController)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    // MARK: - functions
    
    //loads the Countries from restcountries.eu API
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
    
    //creates the searchbar controller and puts in in view
    func generateSearchBar(searchController: UISearchController) {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        //set text field cursor color
        let textFieldInsideSearchBar = searchController.searchBar.valueForKey("searchField") as? UITextField
        textFieldInsideSearchBar?.tintColor = UIColor.init(red: 0/255, green:  128/255, blue:  64/255, alpha:  1)

        //set search bar bg color and cancel button text color
        searchController.searchBar.barTintColor = UIColor.init(red: 0/255, green:  128/255, blue:  64/255, alpha:  1)
        searchController.searchBar.tintColor = UIColor.whiteColor()
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    //the search function
    func searchThroughCountries(searchText: String) {
        searchedCountries = countries.filter({(country) in
            return country.name.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return searchedCountries.count
        } else {
            return countries.count
        }
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CountryTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CountryTableViewCell
        
        let country: Country
        if searchController.active && searchController.searchBar.text != "" {
            country = searchedCountries[indexPath.row]
        } else {
            country = countries[indexPath.row]
        }
        
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
            if searchController.active && searchController.searchBar.text != "" {
                nextScene.country = searchedCountries[countryIndex!.row]
            } else {
                nextScene.country = countries[countryIndex!.row]
            }
        }
    }
    

}


extension CountryTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchThroughCountries(searchController.searchBar.text!)
    }
}
