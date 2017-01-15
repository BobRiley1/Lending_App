//
//  NewLoanViewController.swift
//  Lending_App
//
//  Created by Danny Cazzaniga on 1/3/17.
//  Copyright © 2017 Danny Cazzaniga. All rights reserved.
//

import UIKit



class NewLoanViewController: UIViewController {

    
    @IBOutlet var principal: UITextField!
    @IBOutlet var rate: UITextField!
    @IBOutlet var theLabel: UILabel!
    @IBOutlet var letitle: UILabel!
    @IBOutlet var num: UILabel!
    @IBOutlet var months: UITextField!
    
    
    var princ: Double = 0.0;
    var interest: Double = 0.0;
    var periods: Double = 0.0;
    
    
    //FORMAT
    //{[#principal,#rate,#periods],[#principal,#rate,#periods]}
    //{[1,2,3]}
    
    @IBAction func upload(_ sender: Any) {
        let thing1 = principal.text;
        let thing2 = rate.text;
        let thing3 = months.text;
        
        
        princ = Double(thing1!)!;
        interest = Double(thing2!)!;
        periods = Double(thing3!)!;
        
        print(princ)
        print(interest)
        print(periods)
        print("place = " + String(place))
        
        if thing1 != nil && thing2 != nil && thing3 != nil
        {
            let otherURL = URL(string: "http://10.0.0.6/MyWebService/api/createteam.php?op=9&id=" + String(place))
            print(otherURL!)
            
            let stuff = URLSession.shared.dataTask(with: otherURL!, completionHandler: { (data, response, error) in
                if error != nil
                {
                    self.theLabel.text = "ERROR"
                    print(error!)
                }
                else
                {
                    let content = data
                    do
                    {
                        print("failed myJson")
                        let myJson = try JSONSerialization.jsonObject(with: content!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        let pArr = myJson["principal"] as! Array<String>
                        
                        if pArr.isEmpty
                        {
                            print("EMPTY")
                            
                            let theP = ",\"" + String(self.princ) + "\"]"
                            print(theP)
                            let theR = ",\"" + String(self.interest) + "\"]"
                            let theN = ",\"" + String(self.periods) + "\"]"
                            
                            let requestURL = URL(string: "http://10.0.0.6/MyWebService/api/createteam.php")
                            var request = URLRequest(url: requestURL!)
                            request.httpMethod = "POST"
                            
                            var postParameters = "op=6&principal=" + theP + "&rate=" + theR;
                            postParameters = postParameters + "&periods=" + theN + "&id=" + String(place);
                            
                            request.httpBody = postParameters.data(using: String.Encoding.utf8, allowLossyConversion: false)
                            
                            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                                if error != nil
                                {
                                    print("ERROR")
                                }
                                else
                                {
                                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {  // check for http errors
                                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                                        print("response = \(response)")
                                        self.theLabel.text = "Error adding loan"
                                    }
                                    else
                                    {
                                        print("Successfully added")
                                        self.theLabel.text = "Successfully added"
                                        print(response!)
                                    }
                                }
                            })
                            task.resume()
                        }
                        else
                        {
                            print("NOT EMPTY")
                            
                            
                            var IP = String(describing: myJson["principal"] as! Array<String>)
                            print(IP)
                            var IR = String(describing: myJson["rate"] as! Array<String>)
                            var IN = String(describing: myJson["periods"] as! Array<String>)
                            print(IP.isEmpty)
                            IP.characters.removeLast()
                            IR.characters.removeLast()
                            IN.characters.removeLast()
                            let theP = IP + ",\"" + String(self.princ) + "\"]"
                            print(theP)
                            let theR = IR + ",\"" + String(self.interest) + "\"]"
                            let theN = IN + ",\"" + String(self.periods) + "\"]"
                            
                            
                            let requestURL = URL(string: "http://10.0.0.6/MyWebService/api/createteam.php")
                            var request = URLRequest(url: requestURL!)
                            request.httpMethod = "POST"
                            
                            var postParameters = "op=6&principal=" + theP + "&rate=" + theR;
                            postParameters = postParameters + "&periods=" + theN + "&id=" + String(place);
                            
                            request.httpBody = postParameters.data(using: String.Encoding.utf8, allowLossyConversion: false)
                            
                            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                                if error != nil
                                {
                                    print("ERROR")
                                }
                                else
                                {
                                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {  // check for http errors
                                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                                        print("response = \(response)")
                                        self.theLabel.text = "Error adding loan"
                                    }
                                    else
                                    {
                                        print("Successfully added")
                                        self.theLabel.text = "Successfully added"
                                        //print(response!)
                                    }
                                }
                            })
                            task.resume()
                        }
                    }
                    catch
                    {
                        print(place)
                    }
                }
            })
            stuff.resume()
            usleep(20000)
            stuff.cancel()
            
            theLabel.text = "Successfully Added"
        }
        else
        {
            print("Numbers only")
        }
    }
    
    @IBAction func calc(_ sender: Any) {
        let testString = principal.text
        let testStrong = rate.text
        let gfldd = months.text
        
        
        let j =  Double((testString)!)
        let k =  Double(testStrong!)
        let l =  Double(gfldd!)
        
        
        if j != nil && k != nil
        {
            letitle.text = "Monthly Payments:"
            
            var rpv = j!*k!*0.01;
            var i = k! / 100 + 1;
            i = pow(i, 0-l!)
            
            rpv = rpv / (1 - i)
            
            let y = Double(round(100*rpv)/100)
            
            var answer = String(y);
            answer = "$ " + answer
            num.text = answer
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
