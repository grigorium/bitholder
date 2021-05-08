//
//  NetworkService.swift
//  BitHolder
//
//  Created by grigori on 04.05.2021.
//

import Foundation

class NetworkService {
    
    let session = URLSession.shared
    
    static let shared = NetworkService()
    
    private init() { }
    
    func getStats(completion: @escaping (BtcStats)->()) {
        
        let url = URL(string: "https://api.blockchair.com/bitcoin/stats")!

        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            do {
                let statRespone = try! JSONDecoder().decode(BtcStats.self, from: data!)
                print(statRespone)
                completion(statRespone)
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
    
}