//
//  DetailsViewController.swift
//  Books
//
//  Created by Edgar Adamyan on 24.12.24.
//

import UIKit

class DetailsViewController: UIViewController {
  
  var selectedBook: Book?
  
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var titleOfBook: UILabel!
  @IBOutlet weak var author: UILabel!
  @IBOutlet weak var price: UILabel!
  @IBOutlet weak var imageOfBook: UIImageView!
  @IBOutlet var starImages: [UIImageView]!
  
  var bookCount = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    guard let rating = selectedBook?.rating else { return }
    guard let ratinginInt = Int(rating) else { return }
    setRating(rating: ratinginInt)
  }
  private func setRating(rating: Int){
    for (index, star) in starImages.enumerated(){
      if index < rating{
        star.image = UIImage(named: "star.filled")
      } else {
        star.image = UIImage(named: "star.empty")
      }
    }
  }
  
  private func configureUI(){
    titleOfBook.text = selectedBook?.title
    author.text = selectedBook?.author
    guard let priceofBook = selectedBook?.price else { return }
    price.text = "$ \(priceofBook)"
    guard let image = selectedBook?.image else { return }
    imageOfBook.image = UIImage(named: image)
    
  }
  
  @IBAction func subtractCount(_ sender: Any) {
    bookCount = bookCount > 0 ? bookCount - 1 : 0
    countLabel.text = String(bookCount)
  }
  
  @IBAction func addBook(_ sender: UIButton) {
    bookCount += 1
    countLabel.text = String(bookCount)
    
  }
  
  @IBAction func continueShoppingButton(_ sender: UIButton) {
    dismiss(animated: true)
  }
}
