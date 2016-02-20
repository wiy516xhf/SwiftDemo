//
//  ViewController.swift
//  ReamlExample
//
//  Created by hongfei xie on 16/2/20.
//  Copyright © 2016年 hongfei xie. All rights reserved.
//

import UIKit
import RealmSwift

class Material : Object {
    dynamic var name = ""
    dynamic var number = 0
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addNameField: UITextField!
    @IBOutlet weak var addNumberField: UITextField!
    
    var nameArray = [String]()
    var numberArray = [Int]()
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadMaterial()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let nameLabel : UILabel = cell.viewWithTag(1) as! UILabel
        let numberLabel : UILabel = cell.viewWithTag(2) as! UILabel
        nameLabel.text = nameArray[indexPath.row]
        numberLabel.text = String(numberArray[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            let realm = try! Realm()
            try! realm.write({ () -> Void in
                realm.delete(realm.objects(Material).filter("name = '\(nameArray[indexPath.row])' AND number = \(numberArray[indexPath.row])"))
                
                nameArray.removeAtIndex(indexPath.row)
                numberArray.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                
            })
        }
    }
    
    // initial the table
    func loadMaterial(){
        let realm = try! Realm()
        
        //get objects using NSPredicate
        //        var material = realm.objects(Material).filter(NSPredicate(format: "number > %@", "0" ))
        
        //get objects with using Realm predication
        //        let material = realm.objects(Material).filter("number > 0")
        
        //get all objects of one class
        let material = realm.objects(Material)
        
        
        //        print(material)
        //        print(material.count)
        //        print(material[1])
        //        print(material[0])
        
        for i in 0..<material.count {
            nameArray.append(material[i].name)
            numberArray.append(material[i].number)
        }
        
        mainTableView.reloadData()
    }
    
    @IBAction func addTapped(sender: AnyObject) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.addView.alpha = 1.0
        }
        
    }
    
    @IBAction func searchTapped(sender: AnyObject) {
    }
    
    @IBAction func sureTapped(sender: AnyObject) {
        
        if let addName = addNameField.text, addNumber = addNumberField.text {
            
            if addName == "" || addNumber == "" || addNumber == "0" {
                
                return
            }
            
            let newMaterial = Material()
            newMaterial.name = addName
            newMaterial.number = Int(addNumber)!
            
            let realm = try! Realm()
            try! realm.write({ () -> Void in
                realm.add(newMaterial)
            })
            
            nameArray.append(newMaterial.name)
            numberArray.append(newMaterial.number)
            
            mainTableView.reloadData()
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.addView.alpha = 0
                }, completion: { (value : Bool) -> Void in
                    self.addNameField.text = ""
                    self.addNumberField.text = ""
            })
            
        }
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.addView.alpha = 0
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if addNumberField.editing{
            addNumberField.resignFirstResponder()
        }
        if addNameField.editing{
            addNameField.resignFirstResponder()
        }
    }
    
}

