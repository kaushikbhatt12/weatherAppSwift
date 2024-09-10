//
//  DetailCollectionViewController.swift
//  Project-Demo
//
//  Created by kaushik.bha on 04/09/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetailCollectionViewController: UICollectionViewController {
    
    @objc var cityName : String?

    var weatherCardDataArray: [WeatherCardData] = []
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let viewModel = DetailCollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        spinner.startAnimating()
        
        if let cityName = cityName {
            viewModel.fetchWeatherData(for: cityName)
        }
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.navigationItem.title = cityName
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
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

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weatherData = weatherCardDataArray[indexPath.row]
            
            switch weatherData.type {
            case "Temperature":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Temperature", for: indexPath) as! TemperatureCollectionViewCell
                cell.configure(with: weatherData.value, imageParameter: weatherData.image, description: weatherData.description)
                return cell
            case "Humidity":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Humidity", for: indexPath) as! HumidityCollectionViewCell
                cell.configure(with: weatherData.value)
                return cell
            case "Wind":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Wind", for: indexPath) as! WindCollectionViewCell
                cell.configure(with: weatherData.value)
                return cell
            case "Sunrise":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Sunrise", for: indexPath) as! SunriseCollectionViewCell
                cell.configure(with: weatherData.value)
                return cell
            case "Sunset":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Sunset", for: indexPath) as! SunsetCollectionViewCell
                cell.configure(with: weatherData.value)
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

extension DetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-10, height: 200)
    }
}

extension DetailCollectionViewController: DetailCollectionViewModelDelegate {
    func didUpdateWeatherData(_ weatherData: [WeatherCardData]) {
        self.weatherCardDataArray = weatherData
        self.collectionView.reloadData()
        self.spinner.stopAnimating()
    }
    
    func didFailWithError(_ error: Error) {
        self.spinner.stopAnimating()
        // Show error alert to user
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
