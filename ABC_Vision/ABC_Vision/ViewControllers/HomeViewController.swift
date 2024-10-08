//
//  HomeViewController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/1/24.
//

import UIKit
import AVFoundation
import AVKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var currentPlayer: Player?
    
    var testWordStackController = WordStackController()
    var wordsCatagory: String? = "Animals"
    
    var isPlanetsUnlocked: Bool {
        if checkIfWordPackIsComplete(wordStackName: "Animals") {
            return true
        } else {
            return false
        }
    }
    
    var isFoodsUnlocked: Bool {
        if checkIfWordPackIsComplete(wordStackName: "Planets") {
            return true
        } else {
            return false
        }
    }
    
    var isFreestyleUnlocked: Bool {
        if checkIfWordPackIsComplete(wordStackName: "Foods") {
            return true
        } else {
            return false
        }
    }

    //haptics
    let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    let successFeedback = UINotificationFeedbackGenerator()
    
    //MARK: Video
    
    func launchHowTOVideo(){
        
        
        let hasSeenVideo = UserDefaults.standard.bool(forKey: "hasSeenIntroVideo")
        
        if hasSeenVideo != true {
            // Play the video
            playIntroVideo()
            
            // Mark the video as seen
            UserDefaults.standard.set(true, forKey: "hasSeenIntroVideo")
        }
    }
    
    func playIntroVideo() {
          // Get the video file URL from the app bundle
          if let videoPath = Bundle.main.path(forResource: "ABSeeHowTo", ofType: "mp4") {
              let videoURL = URL(fileURLWithPath: videoPath)
              
              let player = AVPlayer(url: videoURL)
              let playerViewController = AVPlayerViewController()
              playerViewController.player = player
              playerViewController.videoGravity = .resizeAspectFill
              // Present the video player
              self.present(playerViewController, animated: true) {
                  playerViewController.player?.play()
              }
          }
      }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setPlayerProperties()
        DispatchQueue.main.async {
            self.selectFirstItem()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        launchHowTOVideo()
        animateAnimalImages()
        MusicPlayerManager.shared.startBackgroundMusic()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MusicPlayerManager.shared.stopBackgroundMusic()
    }
    
    func setPlayerProperties(){
        if let player = currentPlayer {
            playerNameLabel.text = player.nickname
        }
    }
    
    func selectFirstItem() {
        let firstIndexPath = IndexPath(row: 0, section: 0)
        wordStackCollectionView.selectItem(at: firstIndexPath, animated: true, scrollPosition: .top)
        collectionView(wordStackCollectionView, didSelectItemAt: firstIndexPath)
    }
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    //MARK: - Collection View
    @IBOutlet weak var wordStackCollectionView: UICollectionView!
    
    func setUpCollectionView() {
        wordStackCollectionView.delegate = self
        wordStackCollectionView.dataSource = self
        
        // Register the cell nib
        let nib = UINib(nibName: "WordStackCollectionCell", bundle: nil)
        wordStackCollectionView.register(nib, forCellWithReuseIdentifier: "WordStackCollectionCell")
        
        // Customize the layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10 // Space between rows
        layout.minimumInteritemSpacing = 10 // Space between items (cells)
        
        // Set number of items per row (each cell will take 2 cells worth of space)
        let numberOfItemsPerRow: CGFloat = 2
        
        // Calculate item width by dividing screen width in half (for 2 cells across the width)
        let totalPadding = layout.minimumInteritemSpacing * (numberOfItemsPerRow - 1)
        let availableWidth = wordStackCollectionView.frame.width - totalPadding
        let itemWidth = availableWidth / numberOfItemsPerRow
        
        // Multiply by 2 to make each cell take 2 columns (the entire width)
        let fullWidthItemWidth = itemWidth * 2 + layout.minimumInteritemSpacing
        
        // Set the item height (you can adjust this as needed)
        let itemHeight = UIScreen.main.bounds.height / 3
        
        // Set the item size (full width cell)
        layout.itemSize = CGSize(width: fullWidthItemWidth, height: itemHeight)
        
        wordStackCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = wordStackCollectionView.dequeueReusableCell(withReuseIdentifier: "WordStackCollectionCell", for: indexPath) as? WordStackCollectionCell else {
            return UICollectionViewCell()
        }
        //TEST
        switch indexPath.row {
            //Planets
        case 0:
            //animals
            cell.isUnlocked = true
            cell.imageView.image = testWordStackController.animalsCompleteImage
            cell.titleLabel.text = testWordStackController.animalsName
            if checkIfWordCategorySelected(fromTitle: "Animals") {
                cell.contentView.backgroundColor = UIColor.opaqueABCGreen
                
            } else {
                cell.contentView.backgroundColor = UIColor.opaqueABCBlue
            }
//            if checkIfWordPackIsComplete(wordStackName: "Animals") {
//                cell.imageView.image = UIImage(named: "animalsComplete")
//            } else {
//                cell.imageView.image = UIImage(named: "animalNcomplete")
//            }
            return cell
        case 1:
            cell.imageView.image = testWordStackController.planetCompleteImage
            cell.titleLabel.text = testWordStackController.planetsName
            if checkIfWordCategorySelected(fromTitle: "Planets") {
                if isPlanetsUnlocked {
                    cell.contentView.backgroundColor = UIColor.opaqueABCGreen
                    cell.isUnlocked = true
                } else {
                    cell.contentView.backgroundColor = UIColor.opaqueABCRed
                    cell.isUnlocked = false
                }
            } else {
                if isPlanetsUnlocked {
                    cell.isUnlocked = true
                    cell.contentView.backgroundColor = UIColor.opaqueABCBlue
                } else {
                    cell.contentView.backgroundColor = UIColor.opaqueABCRed
                    cell.isUnlocked = false
                }
            }
            
//            if checkIfWordPackIsComplete(wordStackName: "Planets") {
//                cell.imageView.image = UIImage(named: "planetsComplete")
//            } else {
//                cell.imageView.image = UIImage(named: "planetsINcomplete")
//            }
            return cell
        case 2:
            //foods
            cell.imageView.image = testWordStackController.foodsCompleteImage
            cell.titleLabel.text = testWordStackController.foodsName
            if checkIfWordCategorySelected(fromTitle: "Foods") {
                if isFoodsUnlocked {
                    cell.contentView.backgroundColor = UIColor.opaqueABCGreen
                } else {
                    cell.contentView.backgroundColor = UIColor.opaqueABCRed
                    cell.isUnlocked = false
                }
            } else {
                if isFoodsUnlocked {
                    cell.contentView.backgroundColor = UIColor.opaqueABCBlue
                    cell.isUnlocked = true
                } else {
                    cell.contentView.backgroundColor = UIColor.opaqueABCRed
                    cell.isUnlocked = false
                }
            }
            
//            if checkIfWordPackIsComplete(wordStackName: "Foods") {
//                cell.imageView.image = UIImage(named: "foodComplete")
//                cell.contentView.backgroundColor = UIColor.opaqueABCBlue
//                cell.isUnlocked = true
//            } else {
//                cell.imageView.image = UIImage(named: "foodsINcomplete")
//                cell.contentView.backgroundColor = UIColor.opaqueABCRed
//                cell.isUnlocked = false
//            }
            return cell
        default:
            if checkIfWordCategorySelected(fromTitle: "Freestyle") {
                if isFreestyleUnlocked {
                    cell.contentView.backgroundColor = UIColor.opaqueABCGreen
                    cell.isUnlocked = true
                }else {
                    cell.contentView.backgroundColor = UIColor.opaqueABCRed
                    cell.isUnlocked = false
                }
            } else {
                if isFreestyleUnlocked {
                    cell.contentView.backgroundColor = UIColor.opaqueABCBlue
                    cell.isUnlocked = true
                } else {
                    cell.contentView.backgroundColor = UIColor.opaqueABCRed
                    cell.isUnlocked = false
                }
            }
            return cell
        }
        
    }
    
    func checkIfWordCategorySelected(fromTitle:String)->Bool{
        if wordsCatagory == fromTitle {
            return true
        } else {
            return false
        }
    }
    
    func checkIfWordPackIsComplete(wordStackName: String)-> Bool {
        if let player = currentPlayer {
            if GameController.shared.areAllWordsComplete(forPlayer: player, inStack: wordStackName) ?? false {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    var isComingFromLocked: Bool = false
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? WordStackCollectionCell {
            //add is unlocked State
            
            let row = indexPath.row
            
            switch row {
            case 0:
                if !isComingFromLocked {
                    playAnimalsSound()
                }
                mediumImpact.impactOccurred()
                selectedCell.isSelected = true
                self.isComingFromLocked = false
                wordsCatagory =  selectedCell.titleLabel.text
            case 1:
                if isPlanetsUnlocked {
                    playPlanetsSound()
                    mediumImpact.impactOccurred()
                    selectedCell.isSelected = true
                    self.isComingFromLocked = false
                    wordsCatagory =  selectedCell.titleLabel.text
                } else {
                    playLockedSound()
                    successFeedback.notificationOccurred(.error)
                    self.isComingFromLocked = true
                    DispatchQueue.main.async {
                        self.selectFirstItem()
                    }
                }
            case 2:
                if isFoodsUnlocked {
                    playFoodsSound()
                    mediumImpact.impactOccurred()
                    selectedCell.isSelected = true
                    self.isComingFromLocked = false
                    wordsCatagory =  selectedCell.titleLabel.text
                } else {
                    playLockedSound()
                    self.isComingFromLocked = true
                    successFeedback.notificationOccurred(.error)
                    DispatchQueue.main.async {
                        self.selectFirstItem()
                    }
                }
            default:
                if isFreestyleUnlocked {
                    playFreestyleSound()
                    mediumImpact.impactOccurred()
                    selectedCell.isSelected = true   
                    self.isComingFromLocked = false
                    wordsCatagory =  selectedCell.titleLabel.text
                } else {
                    playLockedSound()
                    self.isComingFromLocked = true
                    successFeedback.notificationOccurred(.error)
                    DispatchQueue.main.async {
                        self.selectFirstItem()
                    }
                }
            }
        }
    }
    
    //MARK: - Sound effects
    var audioPlayer: AVAudioPlayer?
    
    func playAnimalsSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category:", error)
        }
        if let soundURL = Bundle.main.url(forResource: "Animals", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error: Could not load sound file.")
            }
        } else {
            print("Error: Sound file not found.")
        }
    }
    
    func playFoodsSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category:", error)
        }
        if let soundURL = Bundle.main.url(forResource: "Foods", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error: Could not load sound file.")
            }
        } else {
            print("Error: Sound file not found.")
        }
    }
    
    func playPlanetsSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category:", error)
        }
        if let soundURL = Bundle.main.url(forResource: "Planets", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error: Could not load sound file.")
            }
        } else {
            print("Error: Sound file not found.")
        }
    }
    
    func playFreestyleSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category:", error)
        }
        if let soundURL = Bundle.main.url(forResource: "FreeStyle", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error: Could not load sound file.")
            }
        } else {
            print("Error: Sound file not found.")
        }
    }
    
    func playLockedSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category:", error)
        }
        if let soundURL = Bundle.main.url(forResource: "Locked", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error: Could not load sound file.")
            }
        } else {
            print("Error: Sound file not found.")
        }
    }
    
    //MARK: - Animcations
    
    @IBOutlet weak var cartoonDogImageView: UIImageView!
    @IBOutlet weak var cartoonCatImageView: UIImageView!
    @IBOutlet weak var cartoonDuckImageView: UIImageView!
    
    func animateCartoonDuck(){
        let duckOriginalPosition = cartoonDuckImageView.frame.origin
         
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        let duckTopLeft = CGPoint(x: 0, y: 0)
        let duckTopRight = CGPoint(x: viewWidth - cartoonDuckImageView.frame.width, y: 0)
        let duckBottomLeft = CGPoint(x: 0, y: viewHeight - cartoonDuckImageView.frame.height)
        let duckMiddleRight = CGPoint(x: viewWidth - cartoonDuckImageView.frame.width, y: viewHeight / 2 - cartoonDuckImageView.frame.height / 2)
        let duckBottomRight = CGPoint(x: viewWidth - cartoonDuckImageView.frame.width, y: viewHeight - cartoonDuckImageView.frame.height)
        
        let duration = 11.0
        
        // Step 1: Move to top right
        UIView.animate(withDuration: duration, animations: {
            self.cartoonDuckImageView.frame.origin = duckMiddleRight
        }) { _ in
            // Step 2: Move to bottom left
            UIView.animate(withDuration: duration, animations: {
                self.cartoonDuckImageView.frame.origin = duckTopLeft
            }) { _ in
                // Step 3: Move to middle right
                UIView.animate(withDuration: duration, animations: {
                    self.cartoonDuckImageView.frame.origin = duckBottomRight
                }) { _ in
                    // Step 4: Move back to original position
                    UIView.animate(withDuration: duration, animations: {
                        self.cartoonDuckImageView.frame.origin = duckOriginalPosition
                    }) { _ in
                        self.animateCartoonDuck()
                    }
                }
            }
        }
    }
    
    func animateCartoonDog(){
        let dogOriginalPosition = cartoonDogImageView.frame.origin
        
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        let dogTopRight = CGPoint(x: viewWidth - cartoonDogImageView.frame.width, y: 0)
        let dogBottomLeft = CGPoint(x: 0, y: viewHeight - cartoonDogImageView.frame.height)
        let dogMiddleLeft = CGPoint(x: 0, y: viewHeight / 2 - cartoonDogImageView.frame.height / 2)
        let dogBottomRight = CGPoint(x: viewWidth - cartoonDogImageView.frame.width, y: viewHeight - cartoonDogImageView.frame.height)
        
        let duration = 13.0
        
        UIView.animate(withDuration: duration, animations: {
            self.cartoonDogImageView.frame.origin = dogBottomRight
        }) { _ in
            UIView.animate(withDuration: duration, animations: {
                self.cartoonDogImageView.frame.origin = dogMiddleLeft
            }) { _ in
                UIView.animate(withDuration: duration, animations: {
                    self.cartoonDogImageView.frame.origin = dogTopRight
                }) { _ in
                    UIView.animate(withDuration: duration, animations: {
                        self.cartoonDogImageView.frame.origin = dogBottomLeft
                    }) { _ in
                        UIView.animate(withDuration: duration, animations: {
                            self.cartoonDogImageView.frame.origin = dogOriginalPosition
                        }) { _ in
                            self.animateCartoonDog()
                        }
                    }
                }
            }
        }
    }
    
    
    func animateCartoonCat() {
        let catOriginalPosition = cartoonCatImageView.frame.origin
        
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        let catTopRight = CGPoint(x: viewWidth - cartoonCatImageView.frame.width, y: 0)
        let catBottomLeft = CGPoint(x: 0, y: viewHeight - cartoonCatImageView.frame.height)
        let catMiddleRight = CGPoint(x: viewWidth - cartoonCatImageView.frame.width, y: viewHeight / 2 - cartoonCatImageView.frame.height / 2)
        
        let duration = 10.0
        
        // Step 1: Move to top right
        UIView.animate(withDuration: duration, animations: {
            self.cartoonCatImageView.frame.origin = catTopRight
        }) { _ in
            // Step 2: Move to bottom left
            UIView.animate(withDuration: duration, animations: {
                self.cartoonCatImageView.frame.origin = catBottomLeft
            }) { _ in
                // Step 3: Move to middle right
                UIView.animate(withDuration: duration, animations: {
                    self.cartoonCatImageView.frame.origin = catMiddleRight
                }) { _ in
                    // Step 4: Move back to original position
                    UIView.animate(withDuration: duration, animations: {
                        self.cartoonCatImageView.frame.origin = catOriginalPosition
                    }) { _ in
                        self.animateCartoonCat()
                    }
                }
            }
        }
    }
    
    func animateAnimalImages(){
        
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        let catOriginalPosition = cartoonCatImageView.frame.origin
            
        let catTopRight = CGPoint(x: viewWidth - cartoonCatImageView.frame.width, y: 0)
        let catBottomLeft = CGPoint(x: 0, y: viewHeight - cartoonCatImageView.frame.height)
        let catMiddleRight = CGPoint(x: viewWidth - cartoonCatImageView.frame.width, y: viewHeight / 2 - cartoonCatImageView.frame.height / 2)
        
        let dogOriginalPosition = cartoonDogImageView.frame.origin
            
        let dogTopRight = CGPoint(x: viewWidth - cartoonDogImageView.frame.width, y: 0)
        let dogBottomLeft = CGPoint(x: 0, y: viewHeight - cartoonDogImageView.frame.height)
        let dogMiddleLeft = CGPoint(x: 0, y: viewHeight / 2 - cartoonDogImageView.frame.height / 2)
        let dogBottomRight = CGPoint(x: viewWidth - cartoonDogImageView.frame.width, y: viewHeight - cartoonDogImageView.frame.height)
        
        let duckOriginalPosition = cartoonDuckImageView.frame.origin
    
        let duckTopLeft = CGPoint(x: 0, y: 0)
        let duckTopRight = CGPoint(x: viewWidth - cartoonDuckImageView.frame.width, y: 0)
        let duckBottomLeft = CGPoint(x: 0, y: viewHeight - cartoonDuckImageView.frame.height)
        let duckMiddleRight = CGPoint(x: viewWidth - cartoonDuckImageView.frame.width, y: viewHeight / 2 - cartoonDuckImageView.frame.height / 2)
        let duckBottomRight = CGPoint(x: viewWidth - cartoonDuckImageView.frame.width, y: viewHeight - cartoonDuckImageView.frame.height)
        
        let duration = 13.0
        
        UIView.animate(withDuration: duration, animations: {
            self.cartoonDogImageView.frame.origin = dogBottomRight
            self.cartoonCatImageView.frame.origin = catTopRight
            self.cartoonDuckImageView.frame.origin = duckMiddleRight

        }) { _ in
            UIView.animate(withDuration: duration, animations: {
                self.cartoonDogImageView.frame.origin = dogMiddleLeft
                self.cartoonCatImageView.frame.origin = catBottomLeft
                self.cartoonDuckImageView.frame.origin = duckTopLeft
            }) { _ in
                UIView.animate(withDuration: duration, animations: {
                    self.cartoonDogImageView.frame.origin = dogTopRight
                    self.cartoonCatImageView.frame.origin = catMiddleRight
                    self.cartoonDuckImageView.frame.origin = duckBottomRight
                }) { _ in
                    UIView.animate(withDuration: duration, animations: {
                        self.cartoonDogImageView.frame.origin = dogBottomLeft
                        self.cartoonCatImageView.frame.origin = catTopRight
                        self.cartoonDuckImageView.frame.origin = duckMiddleRight
                    }) { _ in
                        UIView.animate(withDuration: duration, animations: {
                            self.cartoonDogImageView.frame.origin = dogOriginalPosition
                            self.cartoonCatImageView.frame.origin = catOriginalPosition
                            self.cartoonDuckImageView.frame.origin = duckOriginalPosition
                        }) { _ in
                            self.animateAnimalImages()
                        }
                    }
                }
            }
        }
            
        
    }

    // MARK: - Navigation
    
    @IBAction func cancelOutButtonTapped(_ sender: Any) {
        heavyImpact.impactOccurred()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let SelectPlayerVC = storyboard.instantiateViewController(withIdentifier: "SelectPlayerVC") as? SelectPlayerViewController {
            window.rootViewController = SelectPlayerVC
            UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionFlipFromRight],
                              animations: nil,
                              completion: nil)
        }
    }
    
    @IBAction func editSettingButtonTapped(_ sender: Any) {
        mediumImpact.impactOccurred()
        let editPlayerVC = EditPlayerView(nibName: "EditPlayerView", bundle: nil)
        editPlayerVC.currentPlayer = currentPlayer
           // Present the view controller modally
           present(editPlayerVC, animated: true, completion: nil)
    }
    
    //MARK: StartGamePlay
    
    func transitionToGamePlay() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let textCaptureController = storyboard.instantiateViewController(withIdentifier: "TextCaptureVC") as? TextCaptureViewController {
             textCaptureController.currentPlayer = currentPlayer
            textCaptureController.testWordCategory = wordsCatagory
            window.rootViewController = textCaptureController
            UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionFlipFromRight],
                              animations: nil,
                              completion: nil)
        }
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        successFeedback.notificationOccurred(.success)
        checkCameraAccess { hasAccess in
                if hasAccess {
                    self.transitionToGamePlay()
                    MusicPlayerManager.shared.playSoundFileNamed(name: "Start")
                } else {
                    let alert = UIAlertController(title: "Camera Access Needed", message: "This app requires camera access to proceed. Please allow camera access in Settings.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
    }
    
    func checkCameraAccess(completion: @escaping (Bool) -> Void) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .authorized:
            // Camera access is already authorized
            completion(true)
            
        case .notDetermined:
            // Camera access has not been requested yet, ask for permission
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
            
        case .restricted, .denied:
            // Camera access is restricted or denied
            completion(false)
            
        @unknown default:
            completion(false)
        }
    }
    

    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTextRead" {
               if let destinationVC = segue.destination as? TextCaptureViewController {
                   destinationVC.testWordCategory = wordsCatagory // Replace with your actual string variable
                   destinationVC.currentPlayer = currentPlayer
               }
           }
    }
    

}
