//
//  TopCollectionVIewCell.swift
//  Books
//
//  Created by Edgar Adamyan on 23.12.24.
//

import UIKit

class TopCollectionVIewCell: UICollectionViewCell {
  
  @IBOutlet weak var titleofBook: UILabel!
  @IBOutlet weak var priceOfBook: UILabel!
  @IBOutlet weak var bookImage: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func configure(book: Book) {
    titleofBook.text = book.title ?? ""
    if let price = book.price, !price.isEmpty {
          priceOfBook.text = "$\(price)"
        } else {
          priceOfBook.text = "Price Unavailable"
        }
    
    if let bookImageName = book.image, !bookImageName.isEmpty{
      bookImage.image = UIImage(named: bookImageName) ?? UIImage(named: "defaultImage")
    }else{
      bookImage.image = UIImage(named: "defaultImage")
    }
  }

}
