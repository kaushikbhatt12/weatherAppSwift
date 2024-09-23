import UIKit

class WindCollectionViewCell: UICollectionViewCell {
    
    let backgroundImageView = UIImageView()
    let windLabel = UILabel()
    
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
        
        backgroundImageView.image = UIImage(named: IMAGE_CONSTANTS.WIND)
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
        
        // Configure the wind label
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.textAlignment = .center
        windLabel.font = UIFont(name: AppConstants.FONT_STYLE, size: AppConstants.FONT_SIZE)
        windLabel.textColor = .white
        windLabel.numberOfLines = LAYOUT_CONSTANTS.NUMBER_OF_LINES
        
        // Add wind label to the view
        contentView.addSubview(windLabel)
        
        //Pin the wind label to the center of the cell
        NSLayoutConstraint.activate([
            windLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            windLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(_ weatherData: WeatherCardData) {
        windLabel.text = weatherData.value
    }
}
