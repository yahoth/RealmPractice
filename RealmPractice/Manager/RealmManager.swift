//
//  RealmManager.swift
//  RealmPractice
//
//  Created by TAEHYOUNG KIM on 1/13/24.
//

import Foundation

import RealmSwift

class RealmManager {
    var realm: Realm

    var notificationToken: NotificationToken?

    init() {
        self.realm = try! Realm()
    }

    func create(object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func read() -> Results<TrackingData> {
        realm.objects(TrackingData.self).sorted(byKeyPath: "startDate", ascending: false)
    }

    //Delete All Objects in a Realm
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    //Delete All Objects of a Specific Type
    func deleteObjectsOf(type: Object) {
        do {
            try realm.write {
                let allObjectsOfType = realm.objects(Object.self)
                realm.delete(allObjectsOfType)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func update(str: String) {
        let item = realm.objects(TrackingData.self).first!

        do {
            try realm.write {
                item.startPlace = str
                item.endPlace = str
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
