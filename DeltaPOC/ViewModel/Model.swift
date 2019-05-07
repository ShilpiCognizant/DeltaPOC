//
//  Model.swift
//  DeltaPOC
//
//  Created by shilpi gupta on 07/05/19.
//  Copyright © 2019 shilpi gupta. All rights reserved.
//

import UIKit

struct CountryDetails: Decodable {
    var worldpopulation: [CountryData]?
}

struct CountryData: Decodable {
    var rank: Int?
    var country: String?
    var population: String?
    var flag: String?
}
