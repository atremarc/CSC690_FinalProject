//
//  DisplayScreen.swift
//  MyJournal
//
//  Created by Adam Tremarche on 5/16/19.
//  Copyright © 2019 Adam Tremarche. All rights reserved.
//

import UIKit
import CoreData

class DisplayScreen: UIViewController {
    
    var getPage: NSManagedObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PreviousEntryOutlet.text = getPage!.value(forKey: "text") as? String
    }
  
    @IBOutlet weak var PreviousEntryOutlet: UILabel!
    
}
