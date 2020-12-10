//
//  PurpleViewController.swift
//  MyPersonals
//
//  Created by Danish Siddiqui on 11/18/20.
//  Copyright © 2020 SFSU. All rights reserved.
//

import UIKit

class StatesCovidViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var covidDetailList = [StatesCovidDetail]()
    let covidDetailRequest = CovidApiDetailRequest()
    
    
    
    @IBOutlet weak var statesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCovidDetails {
            self.statesTableView.reloadData()
        }
        
        
        statesTableView.delegate = self
        statesTableView.dataSource = self
    }
    
    
    //    func stationCountry(_ country: String) {
    //
    //        covidDetailRequest.getCovidDetails {
    //           covidDetailList in
    //            print(getCovidDetails)
    //
    //            self.covidDetailList = covidDetailList
    //
    //            DispatchQueue.main.async {
    //                self.tableView.reloadData()
    //            }
    //            }
    //
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covidDetailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = self.covidDetailList[indexPath.row].state
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCovidDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CovidDetailsViewController {
            destination.stateCovid = covidDetailList[(statesTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    func getCovidDetails(completion: @escaping () -> ()) {
        //        let covidUrl = "https://coronavirus-19-api.herokuapp.com/countries/"
        
        let covidUrl = "https://api.covidtracking.com/v1/states/current.json"
        
        guard let url = URL(string: covidUrl) else {
            fatalError()
        }
        let task = URLSession.shared.dataTask(with: url) { (maybeData, maybeResponse, maybeError) in
            guard let jsonData = maybeData else {
                print("DataNotFound")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.covidDetailList = try decoder.decode([StatesCovidDetail].self, from: jsonData)
                
                DispatchQueue.main.async {
                    completion()
                }
                
                print("Data Received")
                
            }
            catch {
                print(error)
                print("NOOOOOo")
            }
        }
        
        task.resume()
        
    }
    
    
    
    
    
    
    
}
