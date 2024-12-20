  //
  //  ViewController.swift
  //  Books
  //
  //  Created by Edgar Adamyan on 20.12.24.
  //

  import UIKit

  class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      collectionView.register(UINib(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
      collectionView.delegate = self
      collectionView.dataSource = self
      
    }

    @IBAction func signUpButton(_ sender: UIButton) {
      let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
      navigationController?.pushViewController(vc, animated: true)
    }
    
  }


  extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath)
      if let cell = cell as? CarouselCell{
        
      }
      return cell
    }
    
    
  }
  extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      .init(width: collectionView.frame.width  , height: collectionView.frame.height )
    }
   
  }
