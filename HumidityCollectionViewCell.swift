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
        layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS
    }
    
    func configure(_ weatherData : WeatherCardData) {
        humidityLabel.text = weatherData.value
    }
}
