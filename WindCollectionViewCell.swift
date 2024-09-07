//
//  WindCollectionViewCell.swift
//  Project-Demo
//
//  Created by kaushik.bha on 06/09/24.
//

import UIKit

class WindCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var windLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code, if any
        layer.cornerRadius = 10
    }
    
    func configure(with wind: String, backgroundImage: UIImage) {
        windLabel.text = "Wind Speed - \(wind)"
//        backgroundImageView.image = backgroundImage
    }
}
