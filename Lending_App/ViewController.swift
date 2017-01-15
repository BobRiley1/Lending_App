//
//  ViewController.swift
//  Lending_App
//
//  Created by Danny Cazzaniga on 12/31/16.
//  Copyright © 2016 Danny Cazzaniga. All rights reserved.
//

import UIKit

var place = 0;

class ViewController: UIViewController {

    @IBOutlet var theEmail: UITextField!
    @IBOutlet var thePassword: UITextField!
    
    @IBOutlet var theLabel: UILabel!
    
    
    @IBAction func Login(_ sender: Any) {
        theLabel.text = " "
        
        var moveOn = false

        if theEmail.text != "" && thePassword.text != ""
        {
            let url = "http://10.0.0.6/MyWebService/api/createteam.php?op=8&email=" + theEmail.text! + "&password=" + thePassword.text!;
            
            let otherURL = URL(string: url)
            
            
            let task = URLSession.shared.dataTask(with: otherURL!, completionHandler: { (data, response, error) in
                if error != nil
                {
                    print("ERROR")
                }
                else
                {
                    let content = data
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        let exists = myJson["id"] as! Int;
                        
                        if exists > 0
                        {
                            place = exists
                            moveOn = true
                        }
                        else
                        {
                            self.theLabel.text = "Not in database"
                        }
                        
                    }
                    catch {
                        print("failed")
                    }
                }
            })
            task.resume()
            usleep(200000)
            task.cancel()
        }
        else
        {
            self.theLabel.text = "Fill in Email & Password"
        }
        
        if moveOn
        {
            performSegue(withIdentifier: "logIN", sender: self)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

