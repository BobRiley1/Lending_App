//
//  BorrowingViewController.swift
//  Lending_App
//
//  Created by Danny Cazzaniga on 1/3/17.
//  Copyright © 2017 Danny Cazzaniga. All rights reserved.
//

import UIKit



class BorrowingViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var output = ["milk", "eggs"]
    var info = ["name", "email", "loan#"]
    
    
    @IBOutlet var myTable: UITableView!
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = output[indexPath.row]
        
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let otherURL = URL(string: "http://10.0.0.6/MyWebService/api/createteam.php")
        
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
                    let names = myJson["email"] as! Array<String>
                    
                    self.output = names
                    
                    print(self.output)
                }
                catch
                {
                    print("failed")
                }
            }
        })
        task.resume()
        
    }
    
    
    func tableView(_ myTable: UITableView, didSelectRowAt: IndexPath)
    {
        here = didSelectRowAt.row
        
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
