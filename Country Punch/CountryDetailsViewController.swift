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
    

    //MARK: View Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = country.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
