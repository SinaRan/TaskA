//
//  LabelExtension.swift
//  TaskA
//
//  Created by Sina on 10/30/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

enum dateErrors: Error {
    case givenTextIsNotaDate
    case noTextFound
}
extension UILabel{
    func setDate(text: String = "") throws{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = self.text else {throw dateErrors.noTextFound}
        guard let transformedDate = dateFormatter.date(from: date) else {
            throw dateErrors.givenTextIsNotaDate
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.text = "\(text) \(dateFormatter.string(from: transformedDate))"
    }
}
