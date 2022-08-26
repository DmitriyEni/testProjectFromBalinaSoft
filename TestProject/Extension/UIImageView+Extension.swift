//
//  UIImageView+Extension.swift
//  TestProject
//
//  Created by Dmitriy Eni on 25.08.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromURL(_ url: String) {
        DispatchQueue.global().async {
            if let pictureUrl = URL(string: url) {
                if let data = try? Data(contentsOf: pictureUrl) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }
        }
    }
}
