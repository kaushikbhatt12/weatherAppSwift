import UIKit

class SunsetCollectionViewCell: UICollectionViewCell {
    
    let backgroundImageView = UIImageView()
    let sunsetLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpLayout()
    }
    
    private func setUpLayout() {
        // Configure the cell layout
        layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS
        clipsToBounds = true

        // Set up background image
        backgroundImageView.image = UIImage(named: IMAGE_CONSTANTS.SUNSET)
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
        
        // Configure the sunset label
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        sunsetLabel.textAlignment = .center
        sunsetLabel.font = UIFont(name: AppConstants.FONT_STYLE, size: AppConstants.FONT_SIZE)
        sunsetLabel.textColor = .white
        sunsetLabel.numberOfLines = LAYOUT_CONSTANTS.NUMBER_OF_LINES
        
        // Add sunset label to the view
        contentView.addSubview(sunsetLabel)
        
        // Pin the sunset label to the center of the cell
        NSLayoutConstraint.activate([
            sunsetLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sunsetLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // Configure the cell with data
    func configure(_ weatherData: WeatherCardData) {
        sunsetLabel.text = weatherData.value
    }
}
