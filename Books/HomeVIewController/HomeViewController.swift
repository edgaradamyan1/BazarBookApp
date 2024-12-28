//
//  HomeViewController.swift
//  Books
//
//  Created by Edgar Adamyan on 23.12.24.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
  
  private let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: nil, action: #selector(searchBook))
  private let notificationButton = UIBarButtonItem(image: UIImage(named: "notification"), style: .plain, target: nil, action: #selector(pushNotification))
  var books: [Book] = []
  
  @IBOutlet weak var topCollectionView: UICollectionView!
  @IBOutlet weak var bottomCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Home"
 
    setNavigationItem()
    configurCollectionView()
    books = CoreDataManager.shared.fetchBooks()
    topCollectionView.reloadData()
  }
  
  func configurCollectionView() {
    topCollectionView.register(UINib(nibName: "TopCollectionVIewCell", bundle: nil), forCellWithReuseIdentifier: "TopCollectionVIewCell")
    bottomCollectionView.register(UINib(nibName: "BottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BottomCollectionViewCell")
    topCollectionView.delegate = self
    topCollectionView.dataSource = self
    bottomCollectionView.dataSource = self
    bottomCollectionView.delegate = self
  }
  
  func setNavigationItem() {
    navigationItem.leftBarButtonItem = searchButton
    navigationItem.rightBarButtonItem = notificationButton
    navigationItem.leftBarButtonItem?.tintColor = .black
    navigationItem.rightBarButtonItem?.tintColor = .black
  }
  
  @objc func searchBook() {
    
  }
  
  @objc func pushNotification() {
    
  }
  
  @objc func deleteCell(_ gesture: UISwipeGestureRecognizer) {
    guard let cell = gesture.view as? UICollectionViewCell,
          let indexPath = topCollectionView.indexPath(for: cell) else { return }
    let bookToRemove = books[indexPath.item]
    CoreDataManager.shared.deleteBooks(book: bookToRemove)
    books.remove(at: indexPath.item)
    
    topCollectionView.performBatchUpdates {
      topCollectionView.deleteItems(at: [indexPath])
    }
  }

  
  @IBAction func addBook(_ sender: UIButton) {
    let alert = UIAlertController(title: "Add Your Book", message: nil, preferredStyle: .alert)
    alert.addTextField { textField in
      textField.placeholder = "Title"
    }
    alert.addTextField { textField in
      textField.placeholder = "Author"
    }
    alert.addTextField { textField in
      textField.placeholder = "Image"
    }
    alert.addTextField { textField in
      textField.placeholder = "Price"
    }
    alert.addTextField { textField in
      textField.placeholder = "Rating"
    }
    
    alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
      guard let self = self else { return }
      guard let title = alert.textFields?[0].text,
            let author = alert.textFields?[1].text,
            let image = alert.textFields?[2].text,
            let price = alert.textFields?[3].text,
            let rating = alert.textFields?[4].text else { return }
      
      let book = CoreDataManager.shared.addBook(title: title, author: author, price: price, image: image, rating: rating)
      self.books.append(book)
      self.topCollectionView.reloadData()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    present(alert, animated: true)
    
  }
  
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == topCollectionView{
      return books.count
    }else if collectionView == bottomCollectionView{
      return 5
    }else{
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == topCollectionView{
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionVIewCell", for: indexPath)
      if let cell = cell as? TopCollectionVIewCell{
        let book = books[indexPath.item]
        cell.configure(book: book)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(deleteCell(_:)))
        swipeGesture.direction = .up
        cell.addGestureRecognizer(swipeGesture)
        return cell
      }
    } else if collectionView == bottomCollectionView {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCell", for: indexPath)
      if let cell = cell as? BottomCollectionViewCell{
        cell.authorName.text = "Name"
        return cell
      }
    }
    
    return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == topCollectionView{
      let width = collectionView.frame.width / 3
      let height = collectionView.frame.height
      return CGSize(width: width, height: height)
    } else if collectionView == bottomCollectionView {
      let width = collectionView.frame.width / 3
      let height = collectionView.frame.height 
      return CGSize(width: width, height: height)
     
    }
    return CGSize(width: 0, height: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
    vc.selectedBook = books[indexPath.item]
    vc.modalPresentationStyle = .popover
    present(vc, animated: true)
  }
}
