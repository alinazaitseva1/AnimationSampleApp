//
//  ViewController.swift
//  AnimationSample
//
//  Created by Alina Zaitseva on 11/12/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var cloud1Image: UIImageView!
    @IBOutlet weak var cloud2Image: UIImageView!
    @IBOutlet weak var cloud3Image: UIImageView!
    @IBOutlet weak var cloud4Image: UIImageView!
    
    
    // MARK: Consts
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    // MARK: Vars
    
    var statusPosition = CGPoint.zero
    
    // MARK: Actions
    
    @IBAction func login() {
        view.endEditing(true)
        UIView.animate(withDuration: 1.5, delay: 0.0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.0,
                       options: [],
                       animations: {
                        self.loginButton.bounds.size.width += 80.0
                        
        }, completion: { _ in
            self.showMessage(index: 0)
        })
        UIView.animate(withDuration: 0.33, delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.0,
                       options: [],
                       animations: {
                        self.loginButton.center.y += 60.0
                        self.loginButton.backgroundColor = .yellow
                        self.spinner.center = CGPoint(
                            x: 40.0,
                            y: self.loginButton.frame.size.height/2
                        )
                        self.spinner.alpha = 1.0
        }, completion: nil)
    }
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.isHidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0) // TODO: - Make custom
        label.textAlignment = .center
        status.addSubview(label)
        statusPosition = status.center
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headingLabel.center.x  -= view.bounds.width
        userNameTextField.center.x -= view.bounds.width
        passwordTextField.center.x -= view.bounds.width
        
        cloud1Image.alpha = 0.0
        cloud2Image.alpha = 0.0
        cloud3Image.alpha = 0.0
        cloud4Image.alpha = 0.0
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.headingLabel.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.0,
                       options: [],
                       animations: {
                        self.userNameTextField.center.x += self.view.bounds.width },
                       completion: nil )
        
        
        
        UIView.animate(withDuration: 0.5, delay: 0.4,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.0,
                       options: [],
                       animations: {
                        self.passwordTextField.center.x += self.view.bounds.width },
                       completion: nil )
        
        UIView.animate(withDuration: 0.5, delay: 0.5,
                       options: [],
                       animations: {
                        self.cloud1Image.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.7,
                       options: [],
                       animations: {
                        self.cloud2Image.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.9,
                       options: [],
                       animations: {
                        self.cloud3Image.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.1,
                       options: [],
                       animations: {
                        self.cloud4Image.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1.0,
                       options: [],
                       animations: {
                        self.loginButton.center.y -= 30.0
                        self.loginButton.alpha = 1.0
        }, completion: nil)
        
    }
    
    func showMessage(index: Int) {
        label.text = messages[index]
        UIView.transition(with: status, duration: 0.33,
                          options: [.curveEaseOut, .transitionCurlDown],
                          animations: {
                            self.status.isHidden = false
        },
                          completion: {_ in
                            delay(2.0) {
                                if index < self.messages.count-1 {
                                    self.removeMessage(index: index)
                                } else {
                                    //reset form
                                } }
        } )
    }
    
    func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [],
                       animations: {
                        self.status.center.x += self.view.frame.size.width
        },
                       completion: { _ in
                        self.status.isHidden = true
                        self.status.center = self.statusPosition
                        self.showMessage(index: index+1)
        }
        ) }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === userNameTextField) ? passwordTextField : userNameTextField
        nextField?.becomeFirstResponder()
        return true
    }
    
}

