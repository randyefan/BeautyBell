//
//  ServiceViewModel.swift
//  BeautyBell
//
//  Created by Randy Efan Jayaputra on 27/05/21.
//

import UIKit

struct ServiceViewModel {
    
    private let service: Service
    
    var name: String {
        return service.name
    }
    
    var price: Int {
        return service.price
    }
    
    var caption: String {
        return service.caption
    }
    
    init(service: Service) {
        self.service = service
    }
}
