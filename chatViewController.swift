//
//  chatViewController.swift
//  ParseChat
//
//  Created by Madel Asistio on 2/23/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import Parse

class chatViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var messageTextField: UITextField!
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(chatViewController.onTimer), userInfo: nil, repeats: true)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func sendPressed(_ sender: Any) {
        var message = PFObject(className: "Message")
        message["user"] = PFUser.current()
        message["text"] = messageTextField.text

        message.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                print ("message saved")
                // The object has been saved.
                
                self.messages.append(message)
                self.tableView.reloadData()
                
            } else {
                print (error?.localizedDescription)
                // There was a problem, check error.description
            }
        }
        
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessagesTableViewCell
        cell.messageLabel.text = messages[indexPath.row]["text"] as? String
        cell.userLabel.text = messages[indexPath.row]["user"] as? String
        return cell
        
    }
    
    func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className:"Message")
 
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.messages = objects
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
               // print("Error: \(error!) \(error!.userInfo)")
            }
        }
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
