//
//  DetailCollectionViewController.swift
//  Project-Demo
//
//  Created by kaushik.bha on 04/09/24.
//

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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @objc var viewModel: DetailCollectionViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        
        if let cityName = cityName {
            self.viewModel?.fetchWeatherData(cityName: cityName, latitude: lat as! Double, longitude: lon as! Double)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.navigationItem.title = cityName
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
        case AppConstants.TEMPERATURE:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.TEMPERATURE, for: indexPath) as! TemperatureCollectionViewCell
            cell.configure(weatherData)
            return cell
        case AppConstants.HUMIDITY:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.HUMIDITY, for: indexPath) as! HumidityCollectionViewCell
            cell.configure(weatherData)
            return cell
        case AppConstants.WIND:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.WIND, for: indexPath) as! WindCollectionViewCell
            cell.configure(weatherData)
            return cell
        case AppConstants.SUNRISE:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.SUNRISE, for: indexPath) as! SunriseCollectionViewCell
            cell.configure(weatherData)
            return cell
        case AppConstants.SUNSET:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.SUNSET, for: indexPath) as! SunsetCollectionViewCell
            cell.configure(weatherData)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //         let width = collectionView.frame.width // Set width equal to collection view's width
    //         return CGSize(width: width, height: 150) // Set height to 150
    //     }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension DetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Get safe area insets
        let safeAreaInsets = collectionView.safeAreaInsets
        let totalSafeAreaHeight = collectionView.safeAreaLayoutGuide.layoutFrame.height
        let totalWidth = view.bounds.width
        
        let spacing: CGFloat = 10
        
        if indexPath.item == 0 {
            // First cell takes 40% of the total height and full width
            let firstCellHeight = totalSafeAreaHeight * 0.4
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
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Spacing between rows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Spacing between items in the same row
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
