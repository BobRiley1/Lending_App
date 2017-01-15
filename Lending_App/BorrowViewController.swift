//
//  BorrowViewController.swift
//  Lending_App
//
//  Created by Danny Cazzaniga on 1/5/17.
//  Copyright © 2017 Danny Cazzaniga. All rights reserved.
//

import UIKit



class BorrowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var list = ["Did", "Not", "Work"]
    var list2 = ["Did", "Not", "Work"]
    var list3 = ["Did", "Not", "Work"]
    
    @IBOutlet var myTableView: UITableView!
    
    var ite = 0;
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "BCell")
        let output = "$ " + list[ite] + " @ " + list2[ite] + "%   for " + list3[ite] + " months"
        cell.textLabel?.text = output
        if ite < list.count - 1
        {
            ite += 1;
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "http://10.0.0.6/MyWebService/api/createteam.php?op=9&id=" + String(place)
        let otherURL = URL(string: url)
        
        
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
                    let princ = myJson["principal"] as! Array<String>
                    let raat = myJson["rate"] as! Array<String>
                    let nums = myJson["periods"] as! Array<String>
                    
                    
                    self.list = princ
                    self.list2 = raat
                    self.list3 = nums
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
