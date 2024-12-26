//
//  HomeViewController.swift
//  Books
//
//  Created by Edgar Adamyan on 23.12.24.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
  
  let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: nil, action: #selector(searchBook))
  let book: [Book] = []
  let notificationButton = UIBarButtonItem(image: UIImage(named: "notification"), style: .plain, target: nil, action: #selector(pushNotification))
  let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
  
  @IBOutlet weak var topCollectionView: UICollectionView!
  @IBOutlet weak var bottomCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Home"
    setNavigationItem()
    configureTableVIew()
  }
  
  func configureTableVIew(){
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
  
  @IBAction func addBook(_ sender: UIButton) {
    
  }
  
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == topCollectionView{
      return 5
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
        cell.priceOfBook.text = "$5"
        return cell
      }
    }else if collectionView == bottomCollectionView{
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
    vc.modalPresentationStyle = .popover
    present(vc, animated: true)
  }
}
