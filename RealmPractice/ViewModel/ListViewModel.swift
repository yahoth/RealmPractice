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
        realmManager.notificationToken = trackingDatas.observe { changes in
            if let tableView {
                switch changes {
                case .initial:
                    tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    tableView.performBatchUpdates {
                        tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }),
                                             with: .automatic)
                        tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                             with: .automatic)
                        tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                             with: .automatic)
                    }
                case .error(let error):
                    fatalError("\(error)")
                }
            }
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

    var random: CLLocationCoordinate2D {
        coordinates.randomElement()!
    }

    var trackingDatas: Results<TrackingData> {
        realmManager.read()
    }

    func addItem() {
        Task {
            let data = TrackingData(
                startPlace: try await reverseGeocodeLocation(random),
                endPlace: try await reverseGeocodeLocation(random),
                startDate: Date(),
                endDate: Date()
            )

            DispatchQueue.main.async {
                self.realmManager.create(object: data)
            }
        }
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
