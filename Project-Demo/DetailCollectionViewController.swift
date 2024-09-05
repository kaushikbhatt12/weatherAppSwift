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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = NetworkManager.shared
        
        // fetching coordinates
        NetworkManager.shared.getCoordinatesForTheCity(for: cityName!) { coordinates in
            DispatchQueue.main.async {
                if let (latitude, longitude) = coordinates {
                    print("Latitude: \(latitude), Longitude: \(longitude)")
                    
                    // Fetch weather data on a background queue
                    DispatchQueue.global(qos: .background).async {
                        NetworkManager.shared.fetchWeatherData(for: latitude, longitude: longitude) { weatherResponse in
                            DispatchQueue.main.async {
                                if let weatherResponse = weatherResponse {
                                    print("City: \(weatherResponse.name)")
                                    print("Country: \(weatherResponse.sys.country)")
                                    print("Temperature: \(weatherResponse.main.temp)K")
                                    print("Humidity: \(weatherResponse.main.humidity)%")
                                    print("Weather: \(weatherResponse.weather.first?.main ?? "") - \(weatherResponse.weather.first?.description ?? "")")
                                    print("Wind Speed: \(weatherResponse.wind.speed)m/s")
                                    print("Sunrise: \(weatherResponse.sys.sunrise)")
                                    print("Sunset: \(weatherResponse.sys.sunset)")
                                    
                                    // Update your UI elements here
                                    // For example:
                                    // self.updateWeatherCards(with: weatherResponse)
                                } else {
                                    print("Failed to fetch weather data")
                                }
                            }
                        }
                    }
                } else {
                    print("Failed to fetch coordinates")
                }
            }
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
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        return cell
    }

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
