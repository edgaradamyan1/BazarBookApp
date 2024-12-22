//
//  SignUpViewController.swift
//  Books
//
//  Created by Edgar Adamyan on 20.12.24.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {
  var users: [User] = []
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var registerButtonOutlet: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameTextField.delegate = self
    emailTextField.delegate = self
    passwordTextField.delegate = self
    registerButtonOutlet.isEnabled = false
    
  
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let updatedText = (textField.text as? NSString)?.replacingCharacters(in: range, with: string)
    if textField == emailTextField{
      guard let isEmailValid = updatedText?.isValidEmail() else {return false}
      let isValidPassword = passwordTextField.text?.isValidPassword() ?? false
      let isNameFilled = !(nameTextField.text?.isEmpty ?? true )
      registerButtonOutlet.isEnabled = isEmailValid && isValidPassword && isNameFilled
      
    }else if textField == passwordTextField{
      guard let isValidPassword = updatedText?.isValidPassword() else {return false}
      let isEmailValid = emailTextField.text?.isValidEmail() ?? false
      let isNameFilled = !(nameTextField.text?.isEmpty ?? true )
      registerButtonOutlet.isEnabled = isEmailValid && isValidPassword && isNameFilled
      
    }else if textField == nameTextField{
      let isValidPassword = passwordTextField.text?.isValidPassword() ?? false
      let isEmailValid = emailTextField.text?.isValidEmail() ?? false
      let isNameFilled = !(updatedText?.isEmpty ?? true)
      registerButtonOutlet.isEnabled = isEmailValid && isValidPassword && isNameFilled
    }
    
    return true
  }

  @IBAction func registerButton(_ sender: UIButton) {
    let userDefault = UserDefaults.standard
    userDefault.set(nameTextField.text, forKey: "name")
    userDefault.set(emailTextField.text, forKey: "email")
    userDefault.set(passwordTextField.text, forKey: "password")
  }
  
  @IBAction func signInButton(_ sender: UIButton) {
    let vc = SignInViewController(nibName: "SignInViewController", bundle: nil)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  
  func createUser(){
      let userDefaults = UserDefaults.standard
      guard let userName = userDefaults.string(forKey: "name"),
            let email = userDefaults.string(forKey: "email"),
            let password = userDefaults.string(forKey: "password") else{
        return
      }
      
      let user = User(name: userName, email: email, password: password)
      users.append(user)
    }
  
  
}
