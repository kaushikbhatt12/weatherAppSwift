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
        // Initialization code, if any
        layer.cornerRadius = 10
    }
    
    func configure(with sunset: String, backgroundImage: UIImage?) {
        if let sunsetTimestamp = TimeInterval(sunset)
        {
            let sunsetDate = Date(timeIntervalSince1970: sunsetTimestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let formattedSunsetTime = dateFormatter.string(from: sunsetDate)
            sunsetLabel.text = "Sunset \n \(formattedSunsetTime)"
        }
    }
}
