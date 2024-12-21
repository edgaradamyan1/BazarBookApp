//
//  SignUpViewController.swift
//  Books
//
//  Created by Edgar Adamyan on 20.12.24.
//

import UIKit

class SignUpViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  func checkPassword(){
    guard let password = passwordTextField.text else {return}

    let pattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[,.!&%$])[A-Za-z\\d,.!&%$]{8,20}"
    do{
      let regex = try NSRegularExpression(pattern: pattern)
      let range = NSRange(password.startIndex..<password.endIndex, in: password)
      if regex.firstMatch(in: password, range: range) != nil{
        
      }else{
        
      }
    }catch{
      error.localizedDescription
    }
  }
  
  
  func checkEmail(){
    guard let email = emailTextField.text else { return }
    let pattern = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    do{
      let regex = try NSRegularExpression(pattern: pattern)
      let range = NSRange(email.startIndex..<email.endIndex, in: email)
      if regex.firstMatch(in: email, range: range) != nil {
        print("email is valid")
        
        UserDefaults.standard.set(email, forKey: "userEmail")
        
      }else{
        print("invalid email")
        
      }
    }catch{
      error.localizedDescription
    }
    
    
  }
}
