//
//  SunriseCollectionViewCell.swift
//  Project-Demo
//
//  Created by kaushik.bha on 08/09/24.
//

import UIKit

class SunriseCollectionViewCell: UICollectionViewCell {
    

    
    @IBOutlet weak var sunriseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    func configure(_ weatherData: WeatherCardData) {
        sunriseLabel.text = weatherData.value
    }
    
}
