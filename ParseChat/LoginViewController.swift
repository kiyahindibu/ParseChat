//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Trustin Harris on 3/6/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LoggingIn(_ sender: Any) {
        
                
        if (usernameLabel.text?.isEmpty)! || (passwordLabel.text?.isEmpty)! {
            AlertControllers(title: "Warning!", message: "username or password cannot be empty")
        }
 
        
        PFUser.logInWithUsername(inBackground: usernameLabel.text! , password: passwordLabel.text!) { (user: PFUser? , error: Error?) in
            
            if user != nil {
                print("You're logged in")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
        
    }
        
    
    

    @IBAction func SigningUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameLabel.text
        newUser.password = passwordLabel.text
        
        if (usernameLabel.text?.isEmpty)! || (passwordLabel.text?.isEmpty)! {
            AlertControllers(title: "Warning", message: "username or password cannot be empty")
        }
        
        
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Success!")
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func AlertControllers(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
               alert.dismiss(animated: true, completion: nil)
        }
        // add the OK action to the alert controller
        alert.addAction(OKAction)
        
        self.present(alert, animated: true, completion: nil)

        
        
        

    }
    
}
