//
//  HotpepperAPI.swift
//  matchRestaurant
//
//  Created by Kazuki Omori on 2022/02/13.
//

import Foundation

final class HotpepperAPI {
    
    private var dataTask: URLSessionDataTask?
    
    func getShops(completion: @escaping (Result<Results, Error>) -> Void) {
        let requestUrl = URL(string: "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=7482a1925ba91a19&large_area=Z011&format=json")
        guard let url = requestUrl else {
            return
        }
        dataTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard let data = data else{
                return
            }
            do{
                let result = try JSONDecoder().decode(HotPepperResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result.results))
                }
            }catch let error{
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
