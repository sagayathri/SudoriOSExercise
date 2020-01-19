//
//  DetailsViewController.swift
//  SudorExercise
//
//  Created by Myah Technologies on 17/01/2020.
//  Copyright © 2020 Gayathri Arumugam. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    var house: House? = nil
    var houseDetailsDict: [String: AnyObject] = [:]
    var houseDetailsArray = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        setHouseDetails()
    }
    
    func setHouseDetails() {
        
        var name = house!.name
        
        //MARK:- Removes 'House' from name
        if let range = name.range(of: "House ") {
            name.removeSubrange(range)
            self.logoImageView.image = UIImage(named: name)
            //MARK:- Sets the controller title
            self.title = name
        }
        
        do {
            let jsonString = try JSONEncoder().encode(house!)
            let json = String(data: jsonString, encoding: .utf8)!
            self.houseDetailsDict = self.convertStringToDictionary(json: json) ?? [:]
        }
        catch{}
    }
    
    //MARK:- Converts json string to dictionary
    func convertStringToDictionary(json: String) -> [String: AnyObject]? {
        if let data = json.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
                return json
            }
            catch {
                print("Failed to convert string to dictionary")
            }
        }
        return nil
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! DetailsTableViewCell

        let array = houseDetailsDict.map { $0 }.sorted { $0.key < $1.key }
        let element = array[indexPath.row]
        cell.keyLabel.text = element.key.uppercased()
        //MARK:- If the value is empty, it fills with 'No data'
        cell.valueLabel.text = "\(element.value)" == "" ? "No data" : "\(element.value)"
        
        return cell
    }
}
