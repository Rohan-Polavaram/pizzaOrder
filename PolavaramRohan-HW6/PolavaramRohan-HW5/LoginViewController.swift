//
//  LoginViewController.swift
//  PolavaramRohan-HW5
//
//  Created by Rohan Polavaram on 10/20/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginSegmentedController: UISegmentedControl!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmPasswordTextField.isHidden = true
        confirmPasswordLabel.isHidden = true
        statusLabel.text = ""
        signButton.setTitle("Sign In", for: .normal)
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        Auth.auth().addStateDidChangeListener() {
            (auth,user) in
            if user != nil {
                //self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                self.userIDTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
    }
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        statusLabel.text = ""
        if sender.selectedSegmentIndex == 0 {
            confirmPasswordTextField.isHidden = true
            confirmPasswordLabel.isHidden = true
            signButton.setTitle("Sign In", for: .normal)
        } else {
            confirmPasswordTextField.isHidden = false
            confirmPasswordLabel.isHidden = false
            signButton.setTitle("Sign Up", for: .normal)
        }
    }
    @IBAction func signButtonPressed(_ sender: Any) {
        statusLabel.text = ""
        if signButton.titleLabel?.text == "Sign In"{
            Auth.auth().signIn(withEmail: userIDTextField.text!, password: passwordTextField.text!) {
             (authResult,error) in
                if let error = error as NSError? {
                    self.statusLabel.text = "\(error.localizedDescription)"
                } else {
                    self.statusLabel.text = ""
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                }
            }
        }else if passwordTextField.text == confirmPasswordTextField.text{
            Auth.auth().createUser(withEmail: userIDTextField.text!, password: passwordTextField.text!) {
                (authResult,error) in
                if let error = error as NSError? {
                    self.statusLabel.text = "\(error.localizedDescription)"
                } else {
                    self.statusLabel.text = ""
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                }
            }
        }else {
            self.statusLabel.text = "Your confirm password does not match your password field"
        }
    }
    
}
