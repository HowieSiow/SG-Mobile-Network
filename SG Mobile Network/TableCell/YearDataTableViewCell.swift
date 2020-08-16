//
//  YearDataTableViewCell.swift
//  SG Mobile Network
//
//  Created by Howie Siow on 15/8/20.
//  Copyright © 2020 Chang. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func showMessageAtImageClick(message:String)
}


class YearDataTableViewCell: UITableViewCell {

    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var dataVolume: UILabel!
    @IBOutlet weak var imageButton: UIImageView!
    var delegate: CustomCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellContent(dataRecordItems:[DataRecordItem], atIndex:Int){
            self.year.text = dataRecordItems[atIndex].quarter
            self.dataVolume.text = dataRecordItems[atIndex].volume_of_mobile_data
        if(dataRecordItems[atIndex].hasDecrease == true){
            self.imageButton.isHidden = false
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))
            tapGesture.delegate = self
            self.imageButton.addGestureRecognizer(tapGesture)
        }
        else{
            self.imageButton.isHidden = true
        }
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
            if let delegate = self.delegate {
                delegate.showMessageAtImageClick(message: "This year has decreasing usage!")
            }
    }
}
