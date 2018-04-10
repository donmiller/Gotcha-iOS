//
//  UIImageView.swift
//  Gotcha
//
//  Created by Don Miller on 3/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func changeTintColor(imageName:String, tintColor:UIColor) {
        let nameImage = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        self.image = nameImage
        self.tintColor = tintColor
    }
    
    func circleWithBorder(color: CGColor) {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = color
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
    private func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    

}
