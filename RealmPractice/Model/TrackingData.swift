//
//  TrackingData.swift
//  RealmPractice
//
//  Created by TAEHYOUNG KIM on 1/13/24.
//

import Foundation
import CoreLocation

import RealmSwift

class TrackingData: Object {
    @Persisted var startPlace: String?
    @Persisted var endPlace: String?
    @Persisted var startDate: Date
    @Persisted var endDate: Date

    convenience init(startPlace: String?, endPlace: String?, startDate: Date, endDate: Date) {
        self.init()
        self.startPlace = startPlace
        self.endPlace = endPlace
        self.startDate = startDate
        self.endDate = endDate
    }
}

//class TrackingData: Object {
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted var speedInfos: List<SpeedInfo>
//    @Persisted var pathInfos: List<PathInfo>
//    @Persisted var startDate: Date
//    @Persisted var endDate: Date
//    @Persisted var startLocation: String?
//    @Persisted var endLocation: String?
//    @Persisted var tripType: String = "oneWay"
//
//    convenience init(speedInfos: List<SpeedInfo>, pathInfos: List<PathInfo>, startDate: Date, endDate: Date, startLocation: String?, endLocation: String?, tripType: String = "oneWay"
//    ) {
//        self.init()
//        self.speedInfos = speedInfos
//        self.pathInfos = pathInfos
//        self.startDate = startDate
//        self.endDate = endDate
//        self.startLocation = startLocation
//        self.endLocation = endLocation
//        self.tripType = tripType
//    }
//}
//
//class SpeedInfo: Object {
//    @Persisted var value: Double
//    @Persisted var unit: String? = nil
//    @Persisted var title: String
//
//    convenience init(value: Double, unit: String? = nil, title: String) {
//        self.init()
//        self.value = value
//        self.unit = unit
//        self.title = title
//    }
//}
//
//class PathInfo: Object {
//    @Persisted var coordinate: CLLocationCoordinate2D
//    @Persisted var speed: Double
//
//    convenience init(coordinate: CLLocationCoordinate2D, speed: Double) {
//        self.init()
//        self.coordinate = coordinate
//        self.speed = speed
//    }
//}
//
//enum TripType: String {
//    case oneWay
//    case round
//}



