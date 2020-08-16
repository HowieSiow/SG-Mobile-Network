//
//  PriviteResources.swift
//  SG Mobile Network
//
//  Created by Howie Siow on 13/8/20.
//  Copyright © 2020 Chang. All rights reserved.
//

import UIKit

class PriviteResources: NSObject {
    private let url = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f";
    
    func getUrl() -> String{
        return url
    }
}
