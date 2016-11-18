//
//  DetailTripController.swift
//  TripApp
//
//  Created by Pogos Azaryan on 18.11.16.
//  Copyright © 2016 Pogos Azaryan. All rights reserved.
//

import UIKit

class DetailTripController: UIViewController {
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var tripBeginLabel: UILabel!
    @IBOutlet weak var tripEndLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let tripModel = TripModel.get()
    var selectedTripIndex = -1
    var loadedForFirstTime = true
    
    override func viewDidLoad() {
        showData()
        loadedForFirstTime = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (loadedForFirstTime) {
            showData()
        } else {
            loadedForFirstTime = !loadedForFirstTime
        }
    }
    
    func showData() {
        do {
            let trip = try tripModel.getTrip(index: selectedTripIndex)
            destinationLabel.text! = trip.destination!
            tripBeginLabel.text! = trip.timeTripBegin!
            tripEndLabel.text! = trip.timeTripEnd!
            descriptionLabel.text! = trip.description!
        } catch TripModel.TripsError.TripNotFound(let errorMessage) {
            showAlertDialog(message: errorMessage)
        } catch {}
    }
    
    @IBAction func onEditButtonClick(_ sender: UIBarButtonItem) {
        
        if selectedTripIndex != -1 {
            let destination = storyboard?.instantiateViewController(withIdentifier: "EditTripController") as! EditTripController
            destination.setIsAddingNewTrip(isAddingNewTrip: false)
            destination.selectedTripIndex = selectedTripIndex
            navigationController?.pushViewController(destination, animated: true)
        }
        
    }
    
    private func showAlertDialog(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
