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
        // Initialization code, if any
        layer.cornerRadius = 10
    }
    
    func configure(with sunrise: String, backgroundImage: UIImage) {
        if let sunriseTimestamp = TimeInterval(sunrise)
        {
            let sunriseDate = Date(timeIntervalSince1970: sunriseTimestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let formattedSunriseTime = dateFormatter.string(from: sunriseDate)
            sunriseLabel.text = "Sunrise \n \(formattedSunriseTime)"
            //        backgroundImageView.image = backgroundImage
        }
    }
    
}
