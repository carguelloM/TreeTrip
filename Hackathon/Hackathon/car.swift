//
//  car.swift
//  Hackathon
//
//  Created by Cesar Arguello on 4/15/23.
//

import Foundation
import UIKit


//func getJSON()
//{
//    struct Make: Codable {
//        let make_id: String
//        let make_display: String
//        let make_is_common: String
//        let make_country: String
//    }
//
//    struct MakesResponse: Codable {
//        let Makes: [Make]
//    }
//
//    guard let url = URL(string: "https://www.carqueryapi.com/api/0.3/?cmd=getMakes&sold_in_us=1") else {
//        print("Invalid URL")
//        return
//    }
//
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//        guard let data = data else {
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//            } else {
//                print("Error: No data returned.")
//            }
//            return
//        }
//
//        guard let httpResponse = response as? HTTPURLResponse else {
//            print("Error: Invalid response.")
//            return
//        }
//
//        if httpResponse.statusCode != 200 {
//            print("Error: Invalid status code \(httpResponse.statusCode).")
//            return
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            let makesResponse = try decoder.decode(MakesResponse.self, from: data)
//            let makes = makesResponse.Makes
//            var makeDisplayStrings = [String]()
//            for make in makes {
//                      print(make.make_display)
//                    makeDisplayStrings.append(makeDisplay)
//                  }
//        } catch let error {
//            print("Error decoding JSON: \(error.localizedDescription)")
//        }
//    }.resume()
//}


func getMakes(completion: @escaping ([String]?, Error?) -> Void) {
    struct Make: Codable {
        let make_id: String
        let make_display: String
        let make_is_common: String
        let make_country: String
        }
    
    struct MakesResponse: Codable {
            let Makes: [Make]
        }
    
    guard let url = URL(string: "https://www.carqueryapi.com/api/0.3/?cmd=getMakes&sold_in_us=1") else {
        completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        return
    }

    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            completion(nil, error ?? NSError(domain: "Unknown error", code: -1, userInfo: nil))
            return
        }

        do {
            let decoder = JSONDecoder()
            let makesResponse = try decoder.decode(MakesResponse.self, from: data)
            let makes = makesResponse.Makes
            let makeDisplays = makes.map { $0.make_display }
            completion(makeDisplays, nil)
        } catch let error {
            completion(nil, error)
        }
    }.resume()
}


