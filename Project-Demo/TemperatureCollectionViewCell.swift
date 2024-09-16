import UIKit
import SDWebImage

class TemperatureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS
        backgroundImageView.image = UIImage(named: IMAGE_CONSTANTS.WEATHER_INFO)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
    
    }
    
    func configure(_ weatherData: WeatherCardData) {
        
        temperatureLabel.text = weatherData.value
        weatherDescriptionLabel.text = weatherData.descriptionText
        
        if let imageUrl = weatherData.image {
            weatherIcon.sd_setImage(with: imageUrl)
        }
    }
}
