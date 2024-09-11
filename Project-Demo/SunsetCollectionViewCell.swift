//
//  SunsetCollectionViewCell.swift
//  Project-Demo
//
//  Created by kaushik.bha on 08/09/24.
//

import UIKit

class SunsetCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var sunsetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    func configure(_ weatherData: WeatherCardData) {
        sunsetLabel.text = weatherData.value
    }
}
