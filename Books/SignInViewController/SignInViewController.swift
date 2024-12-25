//
//  SignInViewController.swift
//  Books
//
//  Created by Edgar Adamyan on 22.12.24.
//

import UIKit

class SignInViewController: UIViewController {
  var createdUsers: [User] = []
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var errorText: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createdUsers = fetchUsersFromUserDefault()
    
  }
  
  @IBAction func signUpButton(_ sender: UIButton) {
    let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func loginButton(_ sender: UIButton) {
    guard let email = emailTextField.text, !email.isEmpty,
          let password = passwordTextField.text, !password.isEmpty else{
      errorText.text = "Email or Password is empty"
      return
    }
    let users = fetchUsersFromUserDefault()
    if users.first(where: {$0.email == email && $0.password == password}) != nil{
      print("Login successful")
      errorText.text = ""
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(identifier: "TabBarController")
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController = vc
    }else{
      errorText.text = "False Login or Password"
    }
  }
  
  func fetchUsersFromUserDefault() -> [User]{
    guard let data = UserDefaults.standard.data(forKey: "users"),
          let users = try? JSONDecoder().decode([User].self, from: data) else{
      return []
    }
    return users
  }
}



