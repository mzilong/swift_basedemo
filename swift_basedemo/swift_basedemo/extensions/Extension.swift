//
//  Extension.swift
//  swift_basedemo
//
//  Created by Oscarma on 2018/4/28.
//  Copyright © 2018年 Oscarma. All rights reserved.
//

import UIKit

extension UIView{
    func addConstraintsWithVisual(format: String, views: UIView...){
        var viewsDct = [String :UIView]();
        
        for (index , view) in views.enumerated() {
            let key = "v\(index)";
            viewsDct[key] = view;
            view.translatesAutoresizingMaskIntoConstraints = false;
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDct));
    }
}

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func rgba(red: CGFloat, green: CGFloat , blue: CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: alpha);
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async() {
                            self.image = image
                        }
                        
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
            
            }.resume()
        
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
