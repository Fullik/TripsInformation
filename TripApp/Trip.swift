//
//  Trip.swift
//  TripApp
//
//  Created by Pogos Azaryan on 17.11.16.
//  Copyright © 2016 Pogos Azaryan. All rights reserved.
//

import Foundation

struct Trip {
    var destination: String?
    var timeTripBegin: String?
    var timeTripEnd: String?
    var description: String?
    
    init(destination: String, timeTripBegin: String, timeTripEnd: String, description: String) {
        self.destination = destination
        self.timeTripBegin = timeTripBegin
        self.timeTripEnd = timeTripEnd
        self.description = description
    }
}
