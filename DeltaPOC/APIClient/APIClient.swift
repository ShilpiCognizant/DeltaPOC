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

    func fetchAPI(completion : @escaping (Any?) -> ())
{
    guard let url = URL(string:"https://my-json-server.typicode.com/iosdevtest19/devtest2/db")
    else {
    completion(nil)
    return
    }
    Alamofire.request(url,
    method: .get)
    .validate()
    .responseJSON { response in
    guard response.result.isSuccess else {
    print("Error while fetching remote rooms")
    completion(nil)
    return
    }
    
    guard let value = response.result.value as? [String: Any],
        let rows = value["worldpopulation"] as Any?
    else {
    completion(nil)
    return
    }
        completion(rows)
        return
  }
    
 }
}
