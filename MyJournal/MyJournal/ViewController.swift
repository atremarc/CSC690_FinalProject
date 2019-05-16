//
//  ViewController.swift
//  MyJournal
//
//  Created by Adam Tremarche on 5/15/19.
//  Copyright © 2019 Adam Tremarche. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, postEntry {
    
    
    //array for storing CoreData objects
    var storedPagesArray: [NSManagedObject] = []
    
    //stores index of current cell clicked on
    var cellIndex: Int = 0
    
    //this is the instance of the prompt object used by the view controller
    var thePrompt: PromptGenerator = PromptGenerator.init(prompt: "Default Prompt")

    //viewDidLoad displays the first prompt
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thePrompt.prompt = thePrompt.promptCreate()
        PromptOutlet.text = thePrompt.prompt
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedPagesArray.count
    }
    
    //handles the tableview and instances of cells in that tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pageCell", for: indexPath) as! PageCell
        
        
        //writes preview of entry into the title of the button for that specific entry
        cell.EntryTitleOutlet.setTitle(storedPagesArray[indexPath.row].value(forKeyPath: "preview") as? String, for: UIControl.State.normal)
        
        
        //formats the current date to Month, Day, Year
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        //stores the date in the page CoreData object
        let formattedDate: String = dateFormatter.string(from: storedPagesArray[indexPath.row].value(forKeyPath: "date") as! Date)
        
        //writes the date to the label for that specific entry
        cell.EntryDateOutlet.text = formattedDate
        
        cellIndex = indexPath.row
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "main", bundle: nil)
        let DvC = Storyboard.instantiateViewController(withIdentifier: "DisplayScreenSB") as! DisplayScreen
        
        DvC.getPage = storedPagesArray[cellIndex]
        
        self.navigationController?.pushViewController(DvC, animated: true)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if EntryButtonOutlet.isTouchInside {
            let vc = segue.destination as! WriteScreen
            vc.delegate = self
        } else {
            let vc = segue.destination as! DisplayScreen
            vc.getPage = storedPagesArray[cellIndex]
            
        }
        
    }
 
    
    //outlets
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var PromptOutlet: UILabel!
    @IBOutlet weak var EntryButtonOutlet: UIButton!

    
    //refreshes the prompt
    @IBAction func RefreshPromptAction(_ sender: Any) {
        thePrompt.prompt = thePrompt.promptCreate()
        PromptOutlet.text = thePrompt.prompt
    }
    
    //takes the text from the write screen and stores it in a pageObject of pagesArray
    func postEntry (text: String) {
        
        let previewSub: Substring = text.prefix(15)
        let storedPreview = String(previewSub) + "..."
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Page", in: managedContext)!
        let page = NSManagedObject(entity: entity, insertInto: managedContext)
        
        page.setValue(text, forKey: "text")
        page.setValue(Date(), forKey: "date")
        page.setValue(storedPreview, forKey: "preview")
        
        do {
            try managedContext.save()
            storedPagesArray.append(page)
            print("saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        TableView.reloadData()
    }
    
    //fetching coreData
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Page")
        
        do {
            storedPagesArray = try managedContext.fetch(fetchRequest)
            print("loaded")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

class PageObject {
    
    //variables
    var text: String = ""
    var preview: String = ""
    var date: Date = Date()
    
    
    //initializer
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}

class PromptGenerator {
    
    //variables
    var prompt: String = ""
    var word1: String = ""
    var word2: String = ""
    
    //initializer
    convenience init(prompt: String) {
        self.init()
        self.prompt = "Default Prompt"
    }
    
    //prompt generator function
    func promptCreate () -> String{
        
        var newPrompt:String = ""
        let word1Num = Int.random(in: 0 ... 10)
        let word2Num = Int.random(in: 0 ... 10)
        
        if word1Num == 0 {
            word1 = "dream"
        } else if word1Num == 1 {
            word1 = "loved one"
        } else if word1Num == 2 {
            word1 = "co-worker"
        } else if word1Num == 3 {
            word1 = "opportunity"
        } else if word1Num == 4 {
            word1 = "current event"
        } else if word1Num == 5 {
            word1 = "old romance"
        } else if word1Num == 6 {
            word1 = "new crush"
        } else if word1Num == 7 {
            word1 = "secret"
        } else if word1Num == 8 {
            word1 = "parent"
        } else if word1Num == 9 {
            word1 = "place"
        } else {
            word1 = "book/TV show/movie"
        }
        
        if word2Num == 0 {
            word2 = "uneasy"
        } else if word2Num == 1 {
            word2 = "excited"
        } else if word2Num == 2 {
            word2 = "angry"
        } else if word2Num == 3 {
            word2 = "joyous"
        } else if word2Num == 4 {
            word2 = "disappointed"
        } else if word2Num == 5 {
            word2 = "pride"
        } else if word2Num == 6 {
            word2 = "afraid"
        } else if word2Num == 7 {
            word2 = "courageous"
        } else if word2Num == 8 {
            word2 = "surprised"
        } else if word2Num == 9 {
            word2 = "jealous"
        } else {
            word2 = "generous"
        }
        
        newPrompt = "Write about a " + word1 + ", that made you feel " + word2 + "."
        print(newPrompt)
        
        return newPrompt
    }
}

