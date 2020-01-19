//
//  HouseViewController.swift
//  SudorExercise
//

import UIKit

class HouseViewController: UIViewController, NetworkSessionDelegate {
 
    
    @IBOutlet weak var houseTableView: UITableView!
    
    let networkSession = NetworkSession.sharedInstance
    var houses: [House]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        houseTableView.delegate = self
        houseTableView.dataSource = self
        
        networkSession.sessionDelegate = self

        networkSession.fetchHouseFromAPI()
    }
    
    func loadTable() {
        houses = networkSession.house
        houseTableView.reloadData()
    }
}

extension HouseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.rowHeight = 75
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath) as! HouseTableViewCell
        cell.house = self.houses?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = (self.storyboard?.instantiateViewController(identifier: "DetailsViewController")) as! DetailsViewController
        vc.house = self.houses?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

