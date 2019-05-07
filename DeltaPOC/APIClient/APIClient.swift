//
//  APIClient.swift
//  DeltaPOC
//
//  Created by shilpi gupta on 06/05/19.
//  Copyright © 2019 shilpi gupta. All rights reserved.
//

import UIKit
import Alamofire

class APIClient: NSObject {

    func fetchTestAPIData(completion : @escaping (Result<CountryDetails>) -> Void)
{
        guard let URL = URL(string: "https://my-json-server.typicode.com/iosdevtest19/devtest2/db") else {
            let error = NSError(domain: "Error", code: 400, userInfo: nil)
            return completion(.failure(error))
        }
        //Alamofire request to get data
        let request = Alamofire.request(URL,
                                        method: Alamofire.HTTPMethod.get,
                                        parameters: nil,
                                        encoding: JSONEncoding.default,
                                        headers: nil)
        //Response from the request
        request.responseData(completionHandler: {(response) in
            switch response.result {
            case .success:
                if let responseData = response.result.value {
                    let responseString = String(data: responseData, encoding: String.Encoding.isoLatin1)
                    guard let resultValue = responseString?.data(using: String.Encoding.utf8) else {
                        let error = NSError(domain: "Error", code: 400, userInfo: nil)
                        return completion(.failure(error))
                    }
                    do {//Codable code to decode the data
                        let jsonDecoder = JSONDecoder()
                        var decoded = CountryDetails()
                        decoded = try jsonDecoder.decode(CountryDetails.self, from: resultValue)
                        completion(.success(decoded))
                    } catch let error as NSError {
                     
                        completion(.failure(error))
                    }
                }
            case .failure(let error as NSError):
                completion(.failure(error))
            }
        })
  }
}
