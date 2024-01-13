//
//  Array + toRealmList.swift
//  RealmPractice
//
//  Created by TAEHYOUNG KIM on 1/13/24.
//

import Foundation
import RealmSwift

extension Array where Element: Object {
    func toRealmList() -> List<Element> {
        let list = List<Element>()
        list.append(objectsIn: self)
        return list
    }
}
