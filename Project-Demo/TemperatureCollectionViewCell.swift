//
//  TemperatureCollectionViewCell.swift
//  Project-Demo
//
//  Created by kaushik.bha on 06/09/24.
//

import UIKit
import SDWebImage

class TemperatureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS
    
    }
    
    func configure(_ weatherData: WeatherCardData) {
        
        temperatureLabel.text = weatherData.value
        weatherDescriptionLabel.text = weatherData.descriptionText
        
        if let imageUrl = weatherData.image {
            weatherIcon.sd_setImage(with: imageUrl)
        }
    }
}
