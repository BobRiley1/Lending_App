//
//  LendingViewController.swift
//  Lending_App
//
//  Created by Danny Cazzaniga on 1/3/17.
//  Copyright © 2017 Danny Cazzaniga. All rights reserved.
//

import UIKit

var here = 0;
var info = "";

class LendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var list = [["as", "sd", "df"], ["Did", "Not", "Work"]]
    var list2 = [["as", "sd", "df"], ["Did", "Not", "Work"]]
    var list3 = [["as", "sd", "df"], ["Did", "Not", "Work"]]
    var list4: Array<Int> = [];
    var theID: Array<Int> = [];
    var nextPage: Array<String> = [];
    
    @IBOutlet var myTableView: UITableView!
    var iterator = 0;
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "BCell")
        
        if iterator < list.count
        {
            while list[iterator].isEmpty && iterator < list.count - 1
            {
                iterator += 1
            }
            if iterator < list.count && !list[iterator].isEmpty
            {
                let pr = list[iterator].removeFirst()
                let output = String(list4[iterator]) + ":  " + pr;
                var someString = pr + " @ " + list2[iterator].removeFirst();
                someString = someString + " for " + list3[iterator].removeFirst() + " months";
                cell.textLabel?.text = output
                theID.append(list4[iterator])
            }
        }
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let otherURL = URL(string: "http://10.0.0.6/MyWebService/api/createteam.php?op=7")
        
        let task = URLSession.shared.dataTask(with: otherURL!, completionHandler: { (data, response, error) in
            if error != nil
            {
                print("ERROR")
            }
            else
            {
                let content = data
                do
                {
                    let myJson = try JSONSerialization.jsonObject(with: content!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    print(myJson)
                    let princ = myJson["principal"] as AnyObject
                    let raat = myJson["rate"] as AnyObject
                    let nums = myJson["periods"] as AnyObject
                    let ids = myJson["id"] as! Array<Int>
                    print(princ)
                    
                    self.list = princ as! [Array<String>]
                    self.list2 = raat as! [Array<String>]
                    self.list3 = nums as! [Array<String>]
                    self.list4 = ids
                }
                catch
                {
                    print("failed")
                }
            }
        })
        task.resume()
        usleep(100000)
        task.cancel()
        
        
    }
    
    
    func tableView(_ myTableView: UITableView, didSelectRowAt: IndexPath)
    {
        here = didSelectRowAt.row
        print(theID)
        here = theID[here]
        
        self.performSegue(withIdentifier: "details", sender: self)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
