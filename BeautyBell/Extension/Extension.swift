//
//  Extension.swift
//  BeautyBell
//
//  Created by Randy Efan Jayaputra on 27/05/21.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension String{
     func toCurrencyFormat() -> String {
        if let intValue = Int(self){
           let numberFormatter = NumberFormatter()
           numberFormatter.locale = Locale(identifier: "id_ID")
           numberFormatter.numberStyle = NumberFormatter.Style.currency
           return numberFormatter.string(from: NSNumber(value: intValue)) ?? ""
      }
    return ""
  }
}
