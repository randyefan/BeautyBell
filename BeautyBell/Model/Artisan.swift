//
//  Artisan.swift
//  BeautyBell
//
//  Created by Randy Efan Jayaputra on 27/05/21.
//

import Foundation
import SwiftyJSON

typealias Artisans = [Artisan]

struct Artisan {
    var id: Int
    var name: String
    var avatar: String
    var image: String
    var rating: Int
    var services: [Service] = []
    
    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        avatar = json["avatar"].stringValue
        image = json["image"].stringValue
        rating = json["rating"].intValue
        
        for obj in json["services"].arrayValue {
            self.services.append(Service(obj))
        }
    }
}

struct Service {
    var name: String
    var price: Int
    var caption: String
    
    init (_ json: JSON) {
        name = json["name"].stringValue
        price = json["price"].intValue
        caption = json["caption"].stringValue
    }
}
