//
//  TripsViewController.swift
//  TripApp
//
//  Created by Pogos Azaryan on 17.11.16.
//  Copyright © 2016 Pogos Azaryan. All rights reserved.
//

import UIKit

class TripsViewController: UITableViewController {
    
    @IBOutlet var myTableView: UITableView!
    
    private let tripModel = TripModel.get()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripModel.getTripsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath)
        do {
            let object = try tripModel.getTrip(index: indexPath.row)
            cell.textLabel?.text = object.destination
            cell.detailTextLabel?.text = object.description
        } catch (TripModel.TripsError.TripNotFound(let errorMessage)) {
            showAlertDialog(message: errorMessage)
        } catch {}
        return cell
    }
    
    private func showAlertDialog(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onAddButtonClick(_ sender: UIBarButtonItem) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "EditTripController") as! EditTripController
        destination.setIsAddingNewTrip(isAddingNewTrip: true)
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "DetailTripViewController") as! DetailTripController
        destination.selectedTripIndex = indexPath.row
        navigationController?.pushViewController(destination, animated: true)
    }
    
}
