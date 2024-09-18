import UIKit
import SDWebImage

class TemperatureCollectionViewCell: UICollectionViewCell {
    
    let backgroundImageView = UIImageView()
    let icon_temperaure_StackView = UIStackView()
    let weatherInfoStackView = UIStackView()
    let weatherIcon = UIImageView()
    let temperatureLabel = UILabel()
    let weatherDescriptionLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLayout()
    }
    
    private func setUpLayout() {
        // Configure the cell layout
        layer.cornerRadius = LAYOUT_CONSTANTS.CORNER_RADIUS
        backgroundImageView.image = UIImage(named: IMAGE_CONSTANTS.WEATHER_INFO)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // Configure the weather icon
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.clipsToBounds = true
        
        // Configure the temperature label
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = UIFont(name: AppConstants.FONT_STYLE, size: LAYOUT_CONSTANTS.TEMPERATURE_LABEL_FONT_SIZE)
        temperatureLabel.textColor = .white
        
        // Configure the horizontal stack view (icon_temperaure_StackView)
        icon_temperaure_StackView.axis = .horizontal
        icon_temperaure_StackView.alignment = .center
        
        // add weather icon and temperature label to horizontal stack view (icon_temperaure_StackView)
        icon_temperaure_StackView.addArrangedSubview(weatherIcon)
        icon_temperaure_StackView.addArrangedSubview(temperatureLabel)
        
        // Configure the weather description label
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.font = UIFont(name: AppConstants.FONT_STYLE, size: LAYOUT_CONSTANTS.WEATHER_DESCRIPTION_FONT_SIZE)
        weatherDescriptionLabel.textColor = .white
        
        // Configure the vertical stack view (weatherInfoStackView)
        weatherInfoStackView.axis = .vertical
        weatherInfoStackView.alignment = .center
        weatherInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // add icon_temperaure_StackView and weather description label to vertical stack view (weatherInfoStackView)
        weatherInfoStackView.addArrangedSubview(icon_temperaure_StackView)
        weatherInfoStackView.addArrangedSubview(weatherDescriptionLabel)

        contentView.addSubview(weatherInfoStackView)
        
        // Pin the weather info stack view to the center of the cell
        NSLayoutConstraint.activate([
            weatherInfoStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherInfoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        // Set a size for the weather icon
        NSLayoutConstraint.activate([
            weatherIcon.widthAnchor.constraint(equalToConstant: LAYOUT_CONSTANTS.WEATHER_ICON_WIDTH),
            weatherIcon.heightAnchor.constraint(equalToConstant: LAYOUT_CONSTANTS.WEATHER_ICON_HEIGHT)
        ])
    }
    
    func configure(_ weatherData: WeatherCardData) {
        
        temperatureLabel.text = weatherData.value
        weatherDescriptionLabel.text = weatherData.descriptionText
        
        if let imageUrl = weatherData.image {
            weatherIcon.sd_setImage(with: imageUrl)
        }
    }
}
