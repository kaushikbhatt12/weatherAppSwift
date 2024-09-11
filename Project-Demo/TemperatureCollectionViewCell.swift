//
//  TemperatureCollectionViewCell.swift
//  Project-Demo
//
//  Created by kaushik.bha on 06/09/24.
//

import UIKit

class TemperatureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Adjust the frame or bounds if necessary
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code, if any
        layer.cornerRadius = 10
    
        
    }
    
    func configure(_ weatherData: WeatherCardData) {
        
        temperatureLabel.text = weatherData.value
        weatherDescriptionLabel.text = weatherData.description
        
        if let imageParameter = weatherData.image {
            DispatchQueue.global(qos: .background).async {
                NetworkManager.shared.fetchImageIcon(for: imageParameter) { data in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.weatherIcon.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
}
