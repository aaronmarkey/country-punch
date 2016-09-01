//
//  CountryTableViewController.swift
//  Country Punch
//
//  Created by Aaron Markey on 8/29/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit

class CountryTableViewController: UITableViewController {
    
    //MARK: Outlets
    
    
    //MARK: Properties
    var countries = [Country]()
    
    func loadCountries() {
        let country1 = Country(name: "USA", capital: "Washington D.C.", lat: 45.67, long: 5.7)
        let country2 = Country(name: "North Korea", capital: "Washington D.C.", lat: 45.67, long: 5.7)
        
        countries += [country1, country2]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountries()
        self.navigationItem.title = "Country Punch"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CountryTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CountryTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let country = countries[indexPath.row]
        
        cell.countyTitleLabel.text = country.name
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCountryDetails" {
            let nextScene =  segue.destinationViewController as! CountryDetailsViewController
            let countryIndex = tableView.indexPathForSelectedRow as NSIndexPath?
            
            //set back button text on
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
            //pass country to next view
            nextScene.country = countries[countryIndex!.row]
        }
    }
    

}
