//
//  TemperatureCollectionViewCell.swift
//  Project-Demo
//
//  Created by kaushik.bha on 06/09/24.
//

import UIKit

class TemperatureCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Adjust the frame or bounds if necessary
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code, if any
        layer.cornerRadius = 10
    

        
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true

        
    }
    
    func configure(with temperature: String, imageParameter: String) {
        temperatureLabel.text = "\(temperature)°K"
        DispatchQueue.global(qos: .background).async {
            let urlString = "http://openweathermap.org/img/w/\(imageParameter).png"
            
            guard let url = URL(string: urlString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
//                        self.imageView.image = UIImage(data: data)
                        self.imageView.image = UIImage(named: "temperature2")
                    }
                }
            }
            
            task.resume()
        }
    }
}
