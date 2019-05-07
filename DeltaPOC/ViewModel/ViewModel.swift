//
//  ViewModel.swift
//  DeltaPOC
//
//  Created by shilpi gupta on 06/05/19.
//  Copyright © 2019 shilpi gupta. All rights reserved.
//

import UIKit

class ViewModel: NSObject {

    @IBOutlet var apiclient : APIClient?
    
    var arrCountryDetails : NSArray?
    
    func fetchData(completion : @escaping () -> ()){
        
        apiclient?.fetchAPI{ apidata in
            self.arrCountryDetails = apidata as? NSArray
            completion()
        }
    }
    
    func numberOfRowsInSection(section : Int) -> Int {
        return self.arrCountryDetails?.count ?? 0
    }
    
    func cellForRowData(index: IndexPath) -> String {
        let rowData = self.arrCountryDetails?[index.row] as? [String : Any]
        return rowData?["country"] as? String ?? ""
    }
    
    func cellRowImage(index: IndexPath) -> String {
        let rowImage = self.arrCountryDetails?[index.row] as? [String : Any]
        return rowImage?["flag"] as? String ?? ""
    }
    
}
