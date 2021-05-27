//
//  ArtisanViewModel.swift
//  BeautyBell
//
//  Created by Randy Efan Jayaputra on 27/05/21.
//

import UIKit

struct ArtisanViewModel {
    
    private let artisan: Artisan
    
    var id: Int {
        return artisan.id
    }
    
    var name: String {
        return artisan.name
    }
    
    var avatar: String {
        return artisan.avatar
    }
    
    var image: String {
        return artisan.image
    }
    
    var rating: Int {
        return artisan.rating
    }
    
    var services: [Service] {
        return artisan.services
    }
    
    var description: String {
        return artisan.description
    }
    
    init(artisan: Artisan) {
        self.artisan = artisan
    }
}
