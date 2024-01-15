//
//  ListViewModel.swift
//  RealmPractice
//
//  Created by TAEHYOUNG KIM on 1/13/24.
//

import Foundation
import CoreLocation
import UIKit

import RealmSwift

class ListViewModel {
    let realmManager = RealmManager()

    func addChangeListener(_ tableView: UITableView?) {
            realmManager.notificationToken =
        trackingDatas.observe { changes in
                if let tableView {
                    switch changes {
                    case .initial:
                        tableView.reloadData()
                    case .update(_, let deletions, let insertions, let modifications):
                        tableView.beginUpdates()
//                        tableView.performBatchUpdates {
                            tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }),
                                                 with: .automatic)
                            tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                                 with: .automatic)
                            tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                                 with: .automatic)
//                        }
                            tableView.endUpdates()
                    case .error(let error):
                        fatalError("\(error)")
                    }
                }
//            }
        }
    }

    let coordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 36.11718380894785, longitude: 127.74610298094235),
        CLLocationCoordinate2D(latitude: 35.81723839701605, longitude: 128.91672753017977),
        CLLocationCoordinate2D(latitude: 36.55314773525556, longitude: 126.99313829926376),
        CLLocationCoordinate2D(latitude: 35.55445100684264, longitude: 128.1578804023872),
        CLLocationCoordinate2D(latitude: 36.86439867852934, longitude: 126.49312283970347),
        CLLocationCoordinate2D(latitude: 37.451010909797446, longitude: 126.71073499237042),
        CLLocationCoordinate2D(latitude: 37.558501120587884, longitude: 126.96433434330197),
        CLLocationCoordinate2D(latitude: 37.25743030437133, longitude: 127.03025186775291),
        CLLocationCoordinate2D(latitude: 37.25378678106246, longitude: 127.26004769612767)
    ]

    var trackingDatas: Results<TrackingData> {
        realmManager.read()
    }

    var speedInfos: List<SpeedInfo> {
        let infos: [SpeedInfo]  = [
            SpeedInfo(value: 12, unit: "km", title: "Time"),
            SpeedInfo(value: 16, unit: "km", title: "Top Speed"),
            SpeedInfo(value: 345, unit: "km", title: "Average Speed"),
            SpeedInfo(value: 124, unit: "km", title: "Distance"),
        ]
        return infos.toRealmList()
    }

    var pathInfos: List<PathInfo> {
        let infos: [PathInfo] = [
            PathInfo(coordinate: coordinates.randomElement()!, speed: 121),
            PathInfo(coordinate: coordinates.randomElement()!, speed: 121),
            PathInfo(coordinate: coordinates.randomElement()!, speed: 121),
            PathInfo(coordinate: coordinates.randomElement()!, speed: 121)
        ]
        return infos.toRealmList()
    }

    func addItem() {
        Task {
            let data = TrackingData(
                speedInfos: speedInfos, pathInfos: pathInfos, startDate: Date(), endDate: Date(), startLocation: try await reverseGeocodeLocation(pathInfos.first!.coordinate), endLocation: try await reverseGeocodeLocation(pathInfos.last!.coordinate)
            )

            DispatchQueue.main.async {
                self.realmManager.create(object: data)
            }
        }
    }

    func deleteObjectsOfTrackingData() {
        realmManager.deleteObjectsOf(type: trackingDatas)
    }

    func reverseGeocodeLocation(_ coordinate: CLLocationCoordinate2D) async throws -> String {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let placemark = try await geocoder.reverseGeocodeLocation(location).first
        //간단한 주소
        let result = "\(placemark?.locality ?? String()) \(placemark?.subLocality ?? String())"

        if result.trimmingCharacters(in: .whitespaces).count > 0 {
            return result
        } else {
            return "lat: \(coordinate.latitude), long: \(coordinate.longitude)"
        }
    }


}
