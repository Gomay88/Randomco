//
//  DownloadImage.swift
//  Randomco
//
//  Created by Víctor Jimenez on 31/10/21.
//

import UIKit

extension UIImageView{
    func load(url: URL) {
        startSpinner()
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.endSpinner()
                    }
                }
            } catch {
                self?.endSpinner()
            }
        }
    }
}
