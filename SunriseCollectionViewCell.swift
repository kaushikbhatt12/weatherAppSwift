import UIKit

class SunriseCollectionViewCell: UICollectionViewCell {
    
    let backgroundImageView = UIImageView()
    let sunriseLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLayout()
    }
    
    private func setUpLayout() {
        // Configure the cell layout
        layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS
        backgroundImageView.image = UIImage(named: IMAGE_CONSTANTS.SUNRISE)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImageView)
        
        // Pin the image view to the edges of the cell
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // Configure the sunrise label
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        sunriseLabel.textAlignment = .center
        sunriseLabel.font = UIFont(name: AppConstants.FONT_STYLE, size: AppConstants.FONT_SIZE)
        sunriseLabel.textColor = .white
        sunriseLabel.numberOfLines = LAYOUT_CONSTANTS.NUMBER_OF_LINES
        
        // Add sunrise label to the view
        contentView.addSubview(sunriseLabel)
        
        // Pin the sunrise label to the center of the cell
        NSLayoutConstraint.activate([
            sunriseLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sunriseLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(_ weatherData: WeatherCardData) {
        sunriseLabel.text = weatherData.value
    }
    
}
