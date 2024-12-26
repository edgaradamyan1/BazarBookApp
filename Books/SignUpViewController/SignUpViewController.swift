//
//  SignUpViewController.swift
//  Books
//
//  Created by Edgar Adamyan on 20.12.24.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {
  var users: [User] = []
  var timer = Timer()
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var registerButtonOutlet: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameTextField.delegate = self
    emailTextField.delegate = self
    passwordTextField.delegate = self
    registerButtonOutlet.isEnabled = false
    activityIndicator.isHidden = true
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
   
    guard let name = nameTextField.text, !name.isEmpty,
          let password = passwordTextField.text, !password.isEmpty,
          let email = emailTextField.text, !email.isEmpty else{
      return
    }
    
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
    timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { timer in
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
    })
    
    let newUser = User(name: name, email: email, password: password)
    saveUsersToUserDefaults(newUser)
         
  }
  
  private func saveUsersToUserDefaults(_ user: User){
    var users = fetchUsersFromUserDefault()
    users.append(user)
    if let enodedData = try? JSONEncoder().encode(users){
      UserDefaults.standard.set(enodedData, forKey: "users")
    }
    print("Saved users: \(users)")
  }
  
  
  func fetchUsersFromUserDefault() -> [User]{
    guard let data = UserDefaults.standard.data(forKey: "users"),
          let users = try? JSONDecoder().decode([User].self, from: data) else{
      
      return []
    }
    return users
  }
  
  @IBAction func signInButton(_ sender: UIButton) {
    let vc = SignInViewController(nibName: "SignInViewController", bundle: nil)
    navigationController?.pushViewController(vc, animated: true)
  }
}
