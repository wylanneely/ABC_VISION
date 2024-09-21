//
//  HomeViewController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/1/24.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var currentPlayer: Player?
    
    var testWordStackController = WordStackController()
    var wordsCatagory: String?

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
        animateCartoonCat()
        animateCartoonDog()
        animateCartoonDuck()
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
            cell.imageView.image = testWordStackController.planetCompleteImage
            cell.titleLabel.text = testWordStackController.planetsName
            cell.contentView.backgroundColor = UIColor.opaqueABCBlue
            return cell
        case 1:
            //animals
            cell.imageView.image = testWordStackController.animalsCompleteImage
            cell.titleLabel.text = testWordStackController.animalsName
            cell.contentView.backgroundColor = UIColor.opaqueABCBlue

            return cell
        case 2:
            //foods
            cell.imageView.image = testWordStackController.foodsCompleteImage
            cell.titleLabel.text = testWordStackController.foodsName
           cell.contentView.backgroundColor = UIColor.opaqueABCBlue
 //TODO: - update to make real tap feature with color tmrw
            return cell
        default:
            cell.contentView.backgroundColor = UIColor.opaqueABCBlue
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? WordStackCollectionCell {
            selectedCell.isSelected = true
            // Additional logic can be handled here if needed
            wordsCatagory =  selectedCell.titleLabel.text
        }
    }
    
    //MARK: - Animcations
    
    @IBOutlet weak var cartoonDogImageView: UIImageView!
    @IBOutlet weak var cartoonCatImageView: UIImageView!
    @IBOutlet weak var cartoonDuckImageView: UIImageView!
    
    func animateCartoonDuck(){
        let originalPosition = cartoonDuckImageView.frame.origin
         
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        let topLeft = CGPoint(x: 0, y: 0)
        let topRight = CGPoint(x: viewWidth - cartoonDuckImageView.frame.width, y: 0)
        let bottomLeft = CGPoint(x: 0, y: viewHeight - cartoonDuckImageView.frame.height)
        let middleRight = CGPoint(x: viewWidth - cartoonDuckImageView.frame.width, y: viewHeight / 2 - cartoonDuckImageView.frame.height / 2)
        let bottomRight = CGPoint(x: viewWidth - cartoonDuckImageView.frame.width, y: viewHeight - cartoonDuckImageView.frame.height)
        
        let duration = 11.0
        
        // Step 1: Move to top right
        UIView.animate(withDuration: duration, animations: {
            self.cartoonDuckImageView.frame.origin = middleRight
        }) { _ in
            // Step 2: Move to bottom left
            UIView.animate(withDuration: duration, animations: {
                self.cartoonDuckImageView.frame.origin = topLeft
            }) { _ in
                // Step 3: Move to middle right
                UIView.animate(withDuration: duration, animations: {
                    self.cartoonDuckImageView.frame.origin = bottomRight
                }) { _ in
                    // Step 4: Move back to original position
                    UIView.animate(withDuration: duration, animations: {
                        self.cartoonDuckImageView.frame.origin = originalPosition
                    }) { _ in
                        self.animateCartoonDuck()
                    }
                }
            }
        }
    }
    
    func animateCartoonDog(){
        let originalPosition = cartoonDogImageView.frame.origin
        
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        let topLeft = CGPoint(x: 0, y: 0)
        let topRight = CGPoint(x: viewWidth - cartoonDogImageView.frame.width, y: 0)
        let bottomLeft = CGPoint(x: 0, y: viewHeight - cartoonDogImageView.frame.height)
        let middleLeft = CGPoint(x: 0, y: viewHeight / 2 - cartoonDogImageView.frame.height / 2)
        let bottomRight = CGPoint(x: viewWidth - cartoonDogImageView.frame.width, y: viewHeight - cartoonDogImageView.frame.height)
        
        let duration = 13.0
        
        UIView.animate(withDuration: duration, animations: {
            self.cartoonDogImageView.frame.origin = bottomRight
        }) { _ in
            UIView.animate(withDuration: duration, animations: {
                self.cartoonDogImageView.frame.origin = middleLeft
            }) { _ in
                UIView.animate(withDuration: duration, animations: {
                    self.cartoonDogImageView.frame.origin = topRight
                }) { _ in
                    UIView.animate(withDuration: duration, animations: {
                        self.cartoonDogImageView.frame.origin = bottomLeft
                    }) { _ in
                        UIView.animate(withDuration: duration, animations: {
                            self.cartoonDogImageView.frame.origin = originalPosition
                        }) { _ in
                            self.animateCartoonDog()
                        }
                    }
                }
            }
        }
    }
    
    
    func animateCartoonCat() {
        let originalPosition = cartoonCatImageView.frame.origin
        
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        let topRight = CGPoint(x: viewWidth - cartoonCatImageView.frame.width, y: 0)
        let bottomLeft = CGPoint(x: 0, y: viewHeight - cartoonCatImageView.frame.height)
        let middleRight = CGPoint(x: viewWidth - cartoonCatImageView.frame.width, y: viewHeight / 2 - cartoonCatImageView.frame.height / 2)
        
        let duration = 10.0
        
        // Step 1: Move to top right
        UIView.animate(withDuration: duration, animations: {
            self.cartoonCatImageView.frame.origin = topRight
        }) { _ in
            // Step 2: Move to bottom left
            UIView.animate(withDuration: duration, animations: {
                self.cartoonCatImageView.frame.origin = bottomLeft
            }) { _ in
                // Step 3: Move to middle right
                UIView.animate(withDuration: duration, animations: {
                    self.cartoonCatImageView.frame.origin = middleRight
                }) { _ in
                    // Step 4: Move back to original position
                    UIView.animate(withDuration: duration, animations: {
                        self.cartoonCatImageView.frame.origin = originalPosition
                    }) { _ in
                        self.animateCartoonCat()
                    }
                }
            }
        }
    }

    // MARK: - Navigation
    
    @IBAction func startButtonTapped(_ sender: Any) {
        checkCameraAccess { hasAccess in
                if hasAccess {
                    // Camera access is granted, perform the segue
                    self.performSegue(withIdentifier: "toTextRead", sender: self)
                } else {
                    // Show an alert or handle the case where the camera is not accessible
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
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTextRead" {
               if let destinationVC = segue.destination as? TextCaptureViewController {
                   destinationVC.testWordCategory = wordsCatagory // Replace with your actual string variable
               }
           }
    }
    

}
