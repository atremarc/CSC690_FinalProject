//
//  WriteScreen.swift
//  MyJournal
//
//  Created by Adam Tremarche on 5/16/19.
//  Copyright © 2019 Adam Tremarche. All rights reserved.
//

import UIKit

protocol postEntry {
    func postEntry(text: String)
}

class WriteScreen: UIViewController {
    
    var delegate: postEntry?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var TextBoxOutlet: UITextView!
    
    
    @IBAction func PostEntryAction(_ sender: Any) {
        
        //handles creating a page object to house the current journal entry
        if TextBoxOutlet.text != "" {
            
            let currentText: String = TextBoxOutlet.text
            delegate?.postEntry(text: currentText)

            navigationController?.popViewController(animated: true)
        }
    }
    
}
