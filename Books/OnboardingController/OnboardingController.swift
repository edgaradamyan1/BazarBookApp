  //
  //  ViewController.swift
  //  Books
  //
  //  Created by Edgar Adamyan on 20.12.24.
  //

  import UIKit

class OnboardingController: UIViewController {
  
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var collectionView: UICollectionView!
  
  private let titleText: [String] = ["Now reading books will be easier", "Your Bookish Soulmate Awaits", "Start Your Adventure"]
  private let textDescription: [String] = [
    " Discover new worlds, join a vibrant reading community. Start your reading adventure effortlessly with us.",
    "Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.",
    "Ready to embark on a quest for inspiration and knowledge? Your adventure begins now. Let's go!"]
  private let images: [String] = ["image1","image2","image3"]
  private var timer = Timer()
  private var currentIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
    //collectionView.isPagingEnabled = true
    
    startCarousel()
  }
  @IBAction func testButton(_ sender: UIButton) {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
    (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController = vc
  }
  
  @IBAction func SignInController(_ sender: UIButton) {
    let vc = SignInViewController(nibName: "SignInViewController", bundle: nil)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func signUpButton(_ sender: UIButton) {
    let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func pageControlChanged(_ sender: UIPageControl) {
    currentIndex = sender.currentPage
    let indexPath = IndexPath(row: currentIndex, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
  
  func startCarousel(){
    timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] timer in
      guard let self = self else { return }
      self.currentIndex += 1
      
      if self.currentIndex >= self.titleText.count {
        self.currentIndex = 0
      }
      
      let indexPath = IndexPath(row: self.currentIndex, section: 0)
      self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      
      self.pageControl.currentPage = self.currentIndex
      
    }
  }
  
  func stopCaroucel(){
    timer.invalidate()
  }
}

extension OnboardingController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    titleText.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath)
    if let cell = cell as? CarouselCell{
      cell.titleText.text = titleText[indexPath.row]
      cell.descriptionText.text = textDescription[indexPath.row]
      cell.onboardingImage.image = UIImage(named: images[indexPath.row])
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    .init(width: collectionView.frame.width, height: collectionView.frame.height)
  }
    
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    stopCaroucel()
    print("timer was Stopped")
  }
  
}
