//
//  HumidityCollectionViewCell.swift
//  Project-Demo
//
//  Created by kaushik.bha on 06/09/24.
//

import UIKit

class HumidityCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code, if any
        layer.cornerRadius = 10
    }
    
    func configure(with humidity: String, backgroundImage: UIImage) {
        humidityLabel.text = "Humidity \n \(humidity)%"
//        backgroundImageView.image = backgroundImage
    }
}
