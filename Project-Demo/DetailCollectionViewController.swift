import UIKit

private let reuseIdentifier = AppConstants.CELL

@objc protocol DetailCollectionViewProtocol : AnyObject {
    func weatherDataFetched(_ weatherCardArray : [WeatherCardData]) -> Void
    func failedWithError(_ error : Error) -> Void
}

@objc class DetailCollectionViewController: UICollectionViewController {
    
    @objc var cityName : String?
    @objc var lon: NSNumber?
    @objc var lat: NSNumber?
    
    var weatherCardDataArray: [WeatherCardData] = []
    
    var spinner: UIActivityIndicatorView!
    @objc var viewModel: DetailCollectionViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = cityName
        
        // Initialize spinner
        spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        spinner.startAnimating()
        
        // Register the custom cells
        collectionView.register(TemperatureCollectionViewCell.self, forCellWithReuseIdentifier: CELL_LABEL.TEMPERATURE)
        collectionView.register(HumidityCollectionViewCell.self, forCellWithReuseIdentifier: CELL_LABEL.HUMIDITY)
        collectionView.register(WindCollectionViewCell.self, forCellWithReuseIdentifier: CELL_LABEL.WIND)
        collectionView.register(SunriseCollectionViewCell.self, forCellWithReuseIdentifier: CELL_LABEL.SUNRISE)
        collectionView.register(SunsetCollectionViewCell.self, forCellWithReuseIdentifier: CELL_LABEL.SUNSET)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Fetch weather data
        if let cityName = cityName {
            self.viewModel?.fetchWeatherData(cityName: cityName, latitude: lat as! Double, longitude: lon as! Double)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherCardDataArray.count
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Invalidate the collection view layout to recalculate the cell sizes
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weatherData = weatherCardDataArray[indexPath.row]
        
        switch weatherData.type {
        case CELL_LABEL.TEMPERATURE:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_LABEL.TEMPERATURE, for: indexPath) as! TemperatureCollectionViewCell
            cell.configure(weatherData)
            return cell
        case CELL_LABEL.HUMIDITY:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_LABEL.HUMIDITY, for: indexPath) as! HumidityCollectionViewCell
            cell.configure(weatherData)
            return cell
        case CELL_LABEL.WIND:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_LABEL.WIND, for: indexPath) as! WindCollectionViewCell
            cell.configure(weatherData)
            return cell
        case CELL_LABEL.SUNRISE:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_LABEL.SUNRISE, for: indexPath) as! SunriseCollectionViewCell
            cell.configure(weatherData)
            return cell
        case CELL_LABEL.SUNSET:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_LABEL.SUNSET, for: indexPath) as! SunsetCollectionViewCell
            cell.configure(weatherData)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}


extension DetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Get safe area insets
        let safeAreaInsets = collectionView.safeAreaInsets
        let totalSafeAreaHeight = collectionView.safeAreaLayoutGuide.layoutFrame.height
        let totalWidth = view.bounds.width
        
        let spacing = LAYOUT_CONSTANTS.CELL_SPACING
        
        if indexPath.item == 0 {
            // First cell takes 45% of the total height and full width
            let firstCellHeight = totalSafeAreaHeight * 0.45
            return CGSize(width: totalWidth - 2 * spacing, height: firstCellHeight)
        } else {
            // Remaining cells form a 2x2 grid that takes 50% of the total height
            let gridHeight = (totalSafeAreaHeight * 0.5) / 2  // Divide 50% of the height into 2 rows
            
            // Adjust for safe area insets on the left and right
            let gridWidth = (totalWidth - safeAreaInsets.left - safeAreaInsets.right - 3 * spacing) / 2  // Divide width into 2 columns
            
            return CGSize(width: gridWidth, height: gridHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Ensure there is padding around the edges of the cells
        return UIEdgeInsets(top: LAYOUT_CONSTANTS.CELL_INSETS, left: LAYOUT_CONSTANTS.CELL_INSETS, bottom: LAYOUT_CONSTANTS.CELL_INSETS, right: LAYOUT_CONSTANTS.CELL_INSETS)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LAYOUT_CONSTANTS.MINIMUM_LINE_SPACING // Spacing between rows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LAYOUT_CONSTANTS.MINIMUM_INTER_ITEM_SPACING // Spacing between items in the same row
    }
}


extension DetailCollectionViewController: DetailCollectionViewProtocol {
    @objc func weatherDataFetched( _ weatherCardArray : [WeatherCardData]) {
        self.weatherCardDataArray = weatherCardArray
        self.collectionView.reloadData()
        self.spinner.stopAnimating()
    }
    
    @objc func failedWithError(_ error: any Error) {
        self.spinner.stopAnimating()
        // show error alert
        let alert = UIAlertController(title: Messages.ERROR, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Messages.OK, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
