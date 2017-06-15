//
//  MapMarkerView.swift
//  test
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import UIKit

class MapMarkerView: UIView {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK: - Life cycle 
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.backgroundColor = UIColor.white
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2.5
        imageView.layer.cornerRadius = bounds.width / 2
        imageView.clipsToBounds = true
    }
}
