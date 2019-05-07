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
    var modelCountry = CountryDetails()
    
    func fetchData(completion : @escaping () -> ()){
        
        apiclient?.fetchTestAPIData{ resultValue in
            
            if resultValue.isSuccess {
                guard let parsedData = resultValue.value else {
                    return completion()
                }
                self.parseDataToModel(value: parsedData)
                if self.modelCountry.worldpopulation != nil {
                    completion()
                } else {
                    completion()
                }
            }
        }
    }
    
    // Storing data in model
    func parseDataToModel(value: CountryDetails) {
        ///Filter the data : remove nil values from dictionaries
        if let worldpopulation = value.worldpopulation {
            let filterData = worldpopulation.filter {($0.rank != nil) ||
                ($0.country != nil) ||
                ($0.population != nil) || ($0.flag != nil)}
            modelCountry.worldpopulation = filterData
        } else {
            modelCountry.worldpopulation = nil
            
        }
    }
    
    func numberOfRowsInSection(section : Int) -> Int {
        return modelCountry.worldpopulation?.count ?? 0
    }
    
    func cellForRowData(indexPath: IndexPath) -> String {
      
        let rowData = modelCountry.worldpopulation?[indexPath.row]
        return rowData?.country ?? ""
    }
    
    func cellRowImage(indexPath: IndexPath) -> String {
        let rowImage = modelCountry.worldpopulation?[indexPath.row]
        return rowImage?.flag ?? ""
    }
    
}

