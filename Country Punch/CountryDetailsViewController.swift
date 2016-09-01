//
//  CountryDetailsViewController.swift
//  Country Punch
//
//  Created by Aaron Markey on 8/31/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    //MARK: Variables
    var country: Country!
    
    //MARK: Outlets
    @IBOutlet weak var someLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = country.name
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
