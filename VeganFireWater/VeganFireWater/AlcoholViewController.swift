//
//  AlcoholViewController.swift
//  VeganFireWater
//
//  Created by Diego Aguirre on 9/29/16.
//  Copyright © 2016 home. All rights reserved.
//

import Firebase
import UIKit

class AlcoholViewController: UITableViewController {

    @IBInspectable var alcoholType: String? {
        
        didSet {
            switch alcoholType {
            case .Some("beer"): type = .Beer
            case .Some("wine"): type = .Wine
            case .Some("liquor"): type = .Liquor
            default:
                break
            }
        }
    }
    
    var alcohols = [Alcohol]()
    var type: AlcoholType?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        type?.ref.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.alcohols.removeAll()
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if let json = child.value as? [String:AnyObject] {
                    if let alcohol = Alcohol(dictionary: json, type: self.type!) {
                        self.alcohols.append(alcohol)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alcohols.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        let alcohol = alcohols[indexPath.row]
        
        cell.textLabel?.text = alcohol.companyName
        cell.detailTextLabel?.text = "\(alcohol.alcoholType)"

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
