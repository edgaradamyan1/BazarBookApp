  //
  //  ViewController.swift
  //  Books
  //
  //  Created by Edgar Adamyan on 20.12.24.
  //

  import UIKit

  class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var timer = Timer()
    
    let titleText: [String] = ["Now reading books will be easier", "Your Bookish Soulmate Awaits", "Start Your Adventure"]
    let textDescription: [String] = [
      " Discover new worlds, join a vibrant reading community. Start your reading adventure effortlessly with us.",
      "Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.",
      "Ready to embark on a quest for inspiration and knowledge? Your adventure begins now. Let's go!"]
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      collectionView.register(UINib(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
      collectionView.delegate = self
      collectionView.dataSource = self
      
    }
    
    func startTimer(){
      Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeCount), userInfo: nil, repeats: true)
      
    }

    @objc func timeCount(){
      
    }
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
      let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
      navigationController?.pushViewController(vc, animated: true)
    }
    
  }


  extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      titleText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath)
      if let cell = cell as? CarouselCell{
        cell.titleText.text = titleText[indexPath.row]
        cell.descriptionText.text = textDescription[indexPath.row]
        
      }
      return cell
    }
    
    
  }
  extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      .init(width: collectionView.frame.width  , height: collectionView.frame.height )
    }
   
  }
