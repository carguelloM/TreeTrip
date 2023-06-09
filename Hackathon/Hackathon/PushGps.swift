//
//  ContentView.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/15/23.
//
import Foundation
import CoreLocation
import SwiftUI

struct PushGps: View {
    
    @ObservedObject var showDummy: screenView = screenView.shared
   
    
    @StateObject var locationDataManager = LocationDataManager()
    var body: some View {
        VStack {
            switch locationDataManager.locationManager.authorizationStatus {
            case .authorizedWhenInUse:  // Location services are available.
                // Insert code here of what should happen when Location services are authorized
                Text("Your current location is:")
                Text("Latitude: \(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "Error loading")")
                Text("Longitude: \(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")
                LoadingView(name: "treeGif")
                // Send location to server every 60 seconds
                let _ = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
                    let location = locationDataManager.locationManager.location
                    let latitude = location?.coordinate.latitude
                    let longitude = location?.coordinate.longitude
                    //let timestamp = Int(Date().timeIntervalSince1970)
                    let locationObject = ["latitude": latitude, "longitude": longitude] as [String : Any]
//                    if(showDummy.showLoadingScreen != false)
//                    {
//                        print("Test")
//                        postLocationToServer(locationObject: locationObject)
//                    }
//                    if (latitude == last_latitude && longitude == last_longitude){
//                        return
//                    }
                    //LoadingView(name: "treeGif")
                }
                
                //check_val = check_val + 1
            case .restricted, .denied:  // Location services currently unavailable.
                // Insert code here of what should happen when Location services are NOT authorized
                Text("Current location data was restricted or denied.")
            case .notDetermined:        // Authorization not determined yet.
                Text("Finding your location...")
                ProgressView()
            default:
                ProgressView()
            }
        }
        .onAppear{
                let _ = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
                    let location = locationDataManager.locationManager.location
                    let latitude = location?.coordinate.latitude
                    let longitude = location?.coordinate.longitude
                    let timestamp = Int(Date().timeIntervalSince1970)
                    let locationObject = ["latitude": latitude, "longitude": longitude, "timestamp": timestamp] as [String : Any]
                    if(showDummy.showLoadingScreen != false)
                    {
                        print("Test")
                        postLocationToServer(locationObject: locationObject)
                    }
    //                    if (latitude == last_latitude && longitude == last_longitude){
    //                        return
    //                    }
                    //LoadingView(name: "treeGif")
                }
            }
    }

    func postLocationToServer(locationObject: [String: Any]) {
           let url = URL(string: "http://10.28.54.95:5000/store_point")!
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           guard let httpBody = try? JSONSerialization.data(withJSONObject: locationObject, options: []) else {
               return
           }
           request.httpBody = httpBody
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error: \(error.localizedDescription)")
                   return
               }else if let httpResponse = response as? HTTPURLResponse {
                   print("Status code: \(httpResponse.statusCode)")
                   if httpResponse.statusCode == 208 {
                       DispatchQueue.main.async {
                           showDummy.showDummyScreen = true
                           showDummy.showHomeScreen = false
                           showDummy.showLoadingScreen = false
                       }
                   }
               }
              
               // Check if data was received
                 if let data = data {
                     // Convert the data to a string
                     if let stringData = String(data: data, encoding: .utf8) {
                         print("Data as string: \(stringData)")
                     } else {
                         print("Unable to convert data to string")
                     }
                 } else {
                     print("No data received")
                 }
           }
           task.resume()
       }
}
class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            break
            
        case .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied
            break
            
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Insert code to handle location updates
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    
}



struct PushGPS_view: PreviewProvider {
    static var previews: some View {
        PushGps().previewDevice("iPhone 14 pro Max")
    }
}

