//
//  ViewController.swift
//  Projects13-15-Milestone
//
//  Created by Giulia Boscaro on 31/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class CountriesViewController: UITableViewController {
    
    var countries: [Country] = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryCell")
        title = "Countries Facts"
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    @objc func fetchJSON() {
        let url = "https://restcountries.eu/rest/v2"
        
        if let url = URL(string: url) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                self.parseJSON(json: data)
            }.resume()
            
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    func parseJSON(json: Data) {
        let decoder = JSONDecoder()
        if let jsonCountries = try? decoder.decode([Country].self, from: json) {
            countries = jsonCountries
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
            print("Error decoding")
        }
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed, please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FactsViewController()
        vc.selectedCountry = countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

