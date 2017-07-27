//
//  ViewController.swift
//  DataStorage
//
//  Created by nxtgen on 7/27/17.
//  Copyright © 2017 nxtgen. All rights reserved.
//

import UIKit

import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var userinput: UITextField!
    
    @IBOutlet weak var dataQuery: UITextField!
    
    @IBOutlet weak var dataName: UITextField!
    
    @IBAction func getData(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let name = dataQuery.text {
                        
                        if name == result.value(forKey: "name") as? String {
                            
                            storedData.text = result.value(forKey: "text") as? String
                            
                            print("\(name) was retrieved")
                        }
                        
                    }
                    
                }
                
            } else {
                
                print("No results")
            }
            
        } catch {
            
            print("Couldn't fetch results")
            
        }
        
    @IBAction func storeinput(_ sender: Any) {
        if let text = userinput.text {
            if let name = dataName.text {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let newData = NSEntityDescription.insertNewObject(forEntityName: "Data", into: context)
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
                request.returnsObjectsAsFaults = false
                
                newData.setValue(name, forKey: "name")
                newData.setValue(text, forKey: "text")
                
                do {
                    
                    try context.save()
                    
                    print("Saved")
                    
                } catch {
                    
                    print("There was an error")
                }
                
                
            }
            }
    @IBOutlet weak var storedData: UILabel!
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
}
