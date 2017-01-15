//
//  NewUserViewController.swift
//  Lending_App
//
//  Created by Danny Cazzaniga on 12/31/16.
//  Copyright © 2016 Danny Cazzaniga. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {

    @IBOutlet var theLabel: UILabel!
    
    @IBOutlet var theEmail: UITextField!
    @IBOutlet var thePassword: UITextField!
    @IBOutlet var theName: UITextField!
    @IBOutlet var theAddress: UITextField!
    @IBOutlet var theExpMo: UITextField!
    @IBOutlet var theExpYa: UITextField!
    @IBOutlet var theCard: UITextField!
    @IBOutlet var theCCV: UITextField!
    
    var stuff: URLSessionDataTask!;
    var task: URLSessionDataTask!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func create(_ sender: Any) {
        let e = self.theEmail.text
        let p = self.thePassword.text
        let n = self.theName.text
        let a = self.theAddress.text
        let m = self.theExpMo.text
        let y = self.theExpYa.text
        let c = self.theCard.text
        let ccv = self.theCCV.text
        
        var add = false

        theLabel.text = "Adding you..."
        if e != "" && p != "" && n != "" && a != "" && m != "" && y != "" && c != "" && ccv != ""
        {
            let otherURL = URL(string: "http://10.0.0.6/MyWebService/api/createteam.php?op=8&email=" + e! + "&password=" + p!)
            
            stuff = URLSession.shared.dataTask(with: otherURL!, completionHandler: { (data, response, error) in
                if error != nil{
                    print("ERROR")
                }
                else{
                    let content = data
                    self.theLabel.text = "Adding you..."
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        
                        if myJson["id"] as! Int > 0
                        {
                            
                            
                            self.theLabel.text = "Already in Database"
                        }
                        else
                        {
                            add = true
                        }
                        
                        print(add)
                        
                        //ADDING TO DATABASE
                        if add
                        {
                            let requestURL = URL(string: "http://10.0.0.6/MyWebService/api/createteam.php")
                            var request = URLRequest(url: requestURL!)
                            request.httpMethod = "POST"
                            
                            
                            let first = "email="+e!+"&password="+p!
                            
                            let second = "&name="+n!+"&address="+a!
                            
                            let third = "&cardNumber="+m!+"&ExpMo="+y!
                            
                            let fourth = "&ExpYa="+c!+"&ccv="+ccv!
                            
                            let postParameters = first + second + third + fourth
                            
                            request.httpBody = postParameters.data(using: String.Encoding.utf8, allowLossyConversion: false)
                            
                            self.task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                                if error != nil
                                {
                                    print("ERROR")
                                }
                                else
                                {
                                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {  // check for http errors
                                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                                        print("response = \(response)")
                                        self.theLabel.text = "Error adding you"
                                    }
                                    else
                                    {
                                        print("Successfully added")
                                        self.theLabel.text = "Successfully added"
                                        
                                        //self.moveOn()
                                    }
                                    let responseString = String(data: data!, encoding: .utf8)
                                    print("responseString = \(responseString)")
                                }
                            })
                                self.task.resume()
                            
                        }
                        //FINISHED ADDING TO DATABASE

                        
                    }
                    catch
                    {
                        print("failed")
                    }
                }
            })
                self.stuff.resume()
            usleep(100000)
            self.stuff.cancel()
        }
        else
        {
            self.theLabel.text = "Fill in all fields."
        }
        
        
    }
    
    func moveOn()
    {
        self.performSegue(withIdentifier: "fromCreate", sender: self)
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        //self.task.cancel();
        //self.stuff.cancel();
    }
    
    
}
