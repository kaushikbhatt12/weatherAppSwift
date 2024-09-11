//
//  WindCollectionViewCell.swift
//  Project-Demo
//
//  Created by kaushik.bha on 06/09/24.
//

import UIKit

class WindCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var windLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    func configure(_ weatherData: WeatherCardData) {
        windLabel.text = weatherData.value
    }
}
