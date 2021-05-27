//
//  HomeViewModel.swift
//  BeautyBell
//
//  Created by Randy Efan Jayaputra on 27/05/21.
//

import RxSwift
import RxCocoa
import SwiftyJSON

struct ArtisansListViewModel {
    
    let networkService: NetworkService?
    
    var artisanList = BehaviorRelay<Artisans>(value: [])
    var artisanListFilter = BehaviorRelay<Artisans>(value: [])
    var isLoading = BehaviorRelay<Bool>(value: false)
    var error = BehaviorRelay<String?>(value: nil)
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        fetchArtisan()
    }
    
    func fetchArtisan() {
        networkService?.getArtisan(completion: { data, error in
            self.isLoading.accept(true)
            
            if error != nil {
                self.error.accept(error.map {$0.rawValue})
                self.isLoading.accept(false)
            }
            
            guard let data = data else { return }
            
            var artisanList: Artisans = []
            
            for i in data.arrayValue {
                artisanList.append(Artisan(i))
            }
            
            self.artisanList.accept(artisanList)
            self.isLoading.accept(false)
        })
    }
}
