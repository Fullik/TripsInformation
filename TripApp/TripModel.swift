//
//  TripModel.swift
//  TripApp
//
//  Created by Pogos Azaryan on 18.11.16.
//  Copyright © 2016 Pogos Azaryan. All rights reserved.
//

import Foundation

class TripModel {
    
    private static let DESTINATION_NOT_ENTERED = "You didn't enter destination"
    private static let TRIP_BEGIN_TIME_NOT_ENTERED = "You didn't enter trip begin time"
    private static let TRIP_END_TIME_NOT_ENTERED = "You didn't enter trip end time"
    private static let DESCRIPTION_NOT_ENTERED = "You didn't enter description"
    private static let TRIP_NOT_FOUND = "You didn't enter trip not found"
    
    private var trips = [Trip]()
    
    private static var tripStatic: TripModel?
    
    enum TripsError: Error {
        case TripNotFound(errorMessage: String)
        case AddinTripError(errorMessage: String)
    }
    
    static func get() -> TripModel {
        if (tripStatic == nil) {
            tripStatic = TripModel()
        }
        return tripStatic!
    }
    
    func getTripsCount() -> Int {
        return trips.count
    }
    
    func getTrip(index: Int) throws -> Trip {
        if (index >= 0 && index < trips.count) {
            return trips[index]
        } else {
            throw TripsError.TripNotFound(errorMessage: TripModel.TRIP_NOT_FOUND)
        }
    }
    
    func checkData(_ destination: String?,_ tripTimeBegin: String?,
                   _ tripTimeEnd: String?,_ description: String?) -> (Bool, String) {
        if (destination == nil || (destination?.isEmpty)!) {
            return (true, TripModel.DESTINATION_NOT_ENTERED)
        }
        if (tripTimeBegin == nil || (tripTimeBegin?.isEmpty)!) {
            return (true, TripModel.TRIP_BEGIN_TIME_NOT_ENTERED)
        }
        if (tripTimeEnd == nil || (tripTimeEnd?.isEmpty)!) {
            return (true, TripModel.TRIP_END_TIME_NOT_ENTERED)
        }
        if (description == nil || (description?.isEmpty)!) {
            return (true, TripModel.DESCRIPTION_NOT_ENTERED)
        }
        
        return (false, "")
    }
    
    func addTrip(destination: String?, tripTimeBegin: String?,
                 tripTimeEnd: String?, description: String?) throws {
        
        let error = checkData(description, tripTimeBegin, tripTimeEnd, description)
        if (error.0) {
            throw TripsError.AddinTripError(errorMessage: error.1)
        }
        
        trips.append(Trip(destination: destination!, timeTripBegin: tripTimeBegin!,
                          timeTripEnd: tripTimeEnd!, description: description!))
    }
    
    func editTrip(index: Int, destination: String?, tripTimeBegin: String?,
                  tripTimeEnd: String?, description: String?) throws {
        
        let error = checkData(description, tripTimeBegin, tripTimeEnd, description)
        if (error.0) {
            throw TripsError.AddinTripError(errorMessage: error.1)
        }
        
        var trip = trips[index]
        trip.destination = destination!
        trip.timeTripBegin = tripTimeBegin!
        trip.timeTripEnd = tripTimeEnd!
        trip.description = description!
        trips[index] = trip
    }
    
}
