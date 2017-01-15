//
//  ViewOfferViewController.swift
//  Lending_App
//
//  Created by Danny Cazzaniga on 1/3/17.
//  Copyright © 2017 Danny Cazzaniga. All rights reserved.
//

import UIKit

class ViewOfferViewController: UIViewController {

    
    @IBOutlet var theName: UILabel!
    @IBOutlet var theLoan: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let otherURL = URL(string: "http://10.0.0.6/MyWebService/api/createteam.php?op=9&id=" + String(here))
        
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
                    let names = myJson["name"] as! String
                    
                    self.theName.text = names
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
