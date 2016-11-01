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
    func loadCountries(_ completion: @escaping ([Country])->()) {
        var countryList = [Country]()
        Alamofire.request("https://restcountries.eu/rest/v1/all").validate().responseJSON { response in
            if let value = response.result.value {
                let json = JSON(value)
                for j in json {
                    let country = Country(json: j)
                    countryList.append(country)
                }
                completion(countryList)
            } else {
                self.generateAlert(title: "Could not connect", message: "We couldn't connect to the map data. Please check to see if you're connected to the internet.")
            }
        }
    }
    
    //creates the searchbar controller and puts in in view
    func generateSearchBar(_ searchController: UISearchController) {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        //set text field cursor color
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.tintColor = UIColor.init(red: 0/255, green:  128/255, blue:  64/255, alpha:  1)

        //set search bar bg color and cancel button text color
        searchController.searchBar.barTintColor = UIColor.init(red: 0/255, green:  128/255, blue:  64/255, alpha:  1)
        searchController.searchBar.tintColor = UIColor.white
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    //the search function
    func searchThroughCountries(_ searchText: String) {
        searchedCountries = countries.filter({(country) in
            return country.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func generateAlert(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: { (self) in
            print("restcountry.eu not available alert reached")
        })
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return searchedCountries.count
        } else {
            return countries.count
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CountryTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountryTableViewCell
        
        let country: Country
        if searchController.isActive && searchController.searchBar.text != "" {
            country = searchedCountries[(indexPath as NSIndexPath).row]
        } else {
            country = countries[(indexPath as NSIndexPath).row]
        }
        
        cell.countyTitleLabel.text = country.name
        
        return cell
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCountryDetails" {
            let nextScene =  segue.destination as! CountryDetailsViewController
            let countryIndex = tableView.indexPathForSelectedRow as IndexPath?
            
            //set back button text on navbar
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
            //pass country to next view
            if searchController.isActive && searchController.searchBar.text != "" {
                nextScene.country = searchedCountries[(countryIndex! as NSIndexPath).row]
            } else {
                nextScene.country = countries[(countryIndex! as NSIndexPath).row]
            }
        }
    }
    

}


extension CountryTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchThroughCountries(searchController.searchBar.text!)
    }
}
