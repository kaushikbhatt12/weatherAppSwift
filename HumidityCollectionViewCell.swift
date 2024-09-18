import UIKit

class HumidityCollectionViewCell: UICollectionViewCell {
    
    let backgroundImageView = UIImageView()
    let humidityLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLayout()
    }
    
    private func setUpLayout() {
        // Configure the cell layout
        layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS
        backgroundImageView.image = UIImage(named: IMAGE_CONSTANTS.HUMIDITY)
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
        
        // Configure the humidity label
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.textAlignment = .center
        humidityLabel.font = UIFont(name: AppConstants.FONT_STYLE, size: AppConstants.FONT_SIZE)
        humidityLabel.textColor = .white
        humidityLabel.numberOfLines = LAYOUT_CONSTANTS.NUMBER_OF_LINES
        
        // Add humidity label to the view
        contentView.addSubview(humidityLabel)
        
        // Pin the humidity label to the center of the cell
        NSLayoutConstraint.activate([
            humidityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            humidityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(_ weatherData : WeatherCardData) {
        humidityLabel.text = weatherData.value
    }
}
