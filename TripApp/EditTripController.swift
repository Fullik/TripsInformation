//
//  EditTripController.swift
//  TripApp
//
//  Created by Pogos Azaryan on 17.11.16.
//  Copyright © 2016 Pogos Azaryan. All rights reserved.
//

import UIKit

class EditTripController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var tripBeginTimeTextField: UITextField!
    @IBOutlet weak var tripEndTimeTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var isAddingNewTrip = true
    private let tripModel = TripModel.get()
    private var activyTextView: UIView?
    var selectedTripIndex = -1
    
    func setIsAddingNewTrip(isAddingNewTrip: Bool) {
        self.isAddingNewTrip = isAddingNewTrip
    }
    
    override func viewDidLoad() {
        descriptionTextView.delegate = self
        if !isAddingNewTrip {
            do {
                let trip = try tripModel.getTrip(index: selectedTripIndex)
                destinationTextField.text! = trip.destination!
                tripBeginTimeTextField.text! = trip.timeTripBegin!
                tripEndTimeTextField.text! = trip.timeTripEnd!
                descriptionTextView.text! = trip.description!
                navigationBar.title! = "Edit Trip"
            } catch TripModel.TripsError.TripNotFound(let errorMessage) {
                showAlertDialog(message: errorMessage)
            } catch {}
        }
        NotificationCenter.default.addObserver(self, selector: #selector(EditTripController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditTripController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func onDoneButtonClick(_ sender: UIBarButtonItem) {
        do {
            if (isAddingNewTrip) {
                try tripModel.addTrip(destination: destinationTextField.text, tripTimeBegin: tripBeginTimeTextField.text,
                                      tripTimeEnd: tripEndTimeTextField.text, description: descriptionTextView.text)
            } else {
                try tripModel.editTrip(index: selectedTripIndex, destination: destinationTextField.text, tripTimeBegin: tripBeginTimeTextField.text,
                                      tripTimeEnd: tripEndTimeTextField.text, description: descriptionTextView.text)
            }
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        } catch TripModel.TripsError.AddinTripError(let errorMessage) {
            showAlertDialog(message: errorMessage)
        } catch {}
    }
    
    func textViewDidChange(_ textView: UITextView) {
        activyTextView = textView
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activyTextView = nil
    }
    
    private func showAlertDialog(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.cgRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    @IBAction private func textFieldDidBeginEditing(_ sender: UITextField) {
        activyTextView = sender
    }
    
    @IBAction private func textFieldDidEndEditing(_ sender: UITextField) {
        activyTextView = nil
    }

    
    func keyboardWillHide(notification: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }


    
}
