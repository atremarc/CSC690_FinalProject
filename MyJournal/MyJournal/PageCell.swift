//
//  PageCell.swift
//  MyJournal
//
//  Created by Adam Tremarche on 5/16/19.
//  Copyright © 2019 Adam Tremarche. All rights reserved.
//

import UIKit
import CoreData

class PageCell: UITableViewCell {
    
    var pages: [NSManagedObject]?
    var indexP: Int?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var EntryTitleOutlet: UIButton!
    @IBOutlet weak var EntryDateOutlet: UILabel!
    
    @IBAction func EntryTitleAction(_ sender: Any) {
    }
    
}
