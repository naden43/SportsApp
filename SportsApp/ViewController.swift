//
//  ViewController.swift
//  SportsApp
//
//  Created by Salma on 10/05/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnFav: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the border of btnFav
        btnFav.layer.borderWidth = 0
        btnFav.layer.borderColor = UIColor.clear.cgColor
    }
    
    
}


