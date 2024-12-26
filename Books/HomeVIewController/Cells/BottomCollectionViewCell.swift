//
//  BottomCollectionViewCell.swift
//  Books
//
//  Created by Edgar Adamyan on 24.12.24.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var authorImage: UIImageView!
  @IBOutlet weak var authorName: UILabel!
  @IBOutlet weak var typeOfPerson: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
