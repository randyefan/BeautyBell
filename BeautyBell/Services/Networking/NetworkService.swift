//
//  NetworkService.swift
//  BeautyBell
//
//  Created by Randy Efan Jayaputra on 27/05/21.
//

import Foundation
import Alamofire
import SwiftyJSON

enum APIError: String {
    case networkError
    case apiError
    case decodingError
}

enum Apis: URLRequestConvertible {
    case listArtisan
    case artisanDetail
    
    static let endpoint = URL(string: "https://604048b4f34cf600173c7cda.mockapi.io/api/v1/")!
    
    var path: String {
        switch self {
        case .listArtisan:
            return "list-artisan"
        case .artisanDetail:
            return ":id"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: URLEncoding {
        return URLEncoding.init(destination: .methodDependent, arrayEncoding: .noBrackets)
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: Self.endpoint.appendingPathComponent(path))
        
        switch self {
        case .listArtisan:
            request = try URLEncoding.default.encode(request, with: nil)
        case .artisanDetail:
            request = try URLEncoding.default.encode(request, with: nil)
        }
        
        return request
    }
}

struct NetworkService {
    func getArtisan(completion: @escaping(JSON?, APIError?) -> ()) {
        Alamofire.request(Apis.listArtisan).validate().responseJSON { (json) in
            switch json.result {
            case .failure:
                completion(nil, .apiError)
            case .success(let jsonData):
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonData, options: .sortedKeys) {
                    do {
                        let data = try JSON(data: jsonData)
                        completion(data, nil)
                    } catch {
                        completion(nil, .decodingError)
                    }
                } else {
                    completion(nil, .networkError)
                }
            }
        }
    }
    
    func getDetailArtisan(id: Int, completion: @escaping(JSON?, APIError?) -> ()) {
        Alamofire.request(Apis.artisanDetail).validate().responseJSON { (json) in
            switch json.result {
            case .failure:
                completion(nil, .apiError)
            case .success(let jsonData):
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonData, options: .sortedKeys) {
                    do {
                        let data = try JSON(data: jsonData)
                        completion(data, nil)
                    } catch {
                        completion(nil, .decodingError)
                    }
                } else {
                    completion(nil, .networkError)
                }
            }
        }
    }
}
