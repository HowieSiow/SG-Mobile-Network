//
//  DataRecordItem.swift
//  SG Mobile Network
//
//  Created by Howie Siow on 15/8/20.
//  Copyright © 2020 Chang. All rights reserved.
//

import UIKit

class DataRecordItem : Codable{
    var volume_of_mobile_data : String?
    var quarter : String?
    var _id : Int?
    var rank : Double?
    var _full_count : String?
    var hasDecrease : Bool?
    
    
//    init(volume_of_mobile_data:String?, quarter:String?, _id:Int?, rank:Double?, _full_count:String?) {
//        self.volume_of_mobile_data = volume_of_mobile_data
//        self.quarter = quarter
//        self._id = _id
//        self.rank = rank
//        self._full_count = _full_count
//    }
}
