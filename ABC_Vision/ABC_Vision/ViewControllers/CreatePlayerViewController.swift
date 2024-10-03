//
//  CreatePlayerViewController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/2/24.
//

import UIKit

class CreatePlayerViewController: UIViewController {

    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
       }
    
    private let userDefaultsController = PlayerUserDefaultsController()
    
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - Outlets
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var hButton: UIButton!
    @IBOutlet weak var iButton: UIButton!
    @IBOutlet weak var jButton: UIButton!
    @IBOutlet weak var kButton: UIButton!
    @IBOutlet weak var lButton: UIButton!
    @IBOutlet weak var mButton: UIButton!
    @IBOutlet weak var nButton: UIButton!
    @IBOutlet weak var oButton: UIButton!
    @IBOutlet weak var pButton: UIButton!
    @IBOutlet weak var qButton: UIButton!
    @IBOutlet weak var rButton: UIButton!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var tButton: UIButton!
    @IBOutlet weak var uButton: UIButton!
    @IBOutlet weak var vButton: UIButton!
    @IBOutlet weak var wButton: UIButton!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var yButton: UIButton!
    @IBOutlet weak var zButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    

       @IBAction func aButtonTapped(_ sender: Any) {
           keyTapped(letter: "A")
       }
       @IBAction func bButtonTapped(_ sender: Any) {
           keyTapped(letter: "B")
       }
       @IBAction func cButtonTapped(_ sender: Any) {
           keyTapped(letter: "C")
       }
     
    @IBAction func dButtonTapped(_ sender: Any) {
           keyTapped(letter: "D")
       }
       @IBAction func eButtonTapped(_ sender: Any) {
           keyTapped(letter: "E")
       }
       @IBAction func fButtonTapped(_ sender: Any) {
           keyTapped(letter: "F")
       }
       @IBAction func gButtonTapped(_ sender: Any) {
           keyTapped(letter: "G")
       }
       @IBAction func hButtonTapped(_ sender: Any) {
           keyTapped(letter: "H")
       }
       @IBAction func iButtonTapped(_ sender: Any) {
           keyTapped(letter: "I")
       }
       @IBAction func jButtonTapped(_ sender: Any) {
           keyTapped(letter: "J")
       }
       @IBAction func kButtonTapped(_ sender: Any) {
           keyTapped(letter: "K")
       }
       @IBAction func lButtonTapped(_ sender: Any) {
           keyTapped(letter: "L")
       }
       @IBAction func mButtonTapped(_ sender: Any) {
           keyTapped(letter: "M")
       }
       @IBAction func nButtonTapped(_ sender: Any) {
           keyTapped(letter: "N")
       }
       @IBAction func oButtonTapped(_ sender: Any) {
           keyTapped(letter: "O")
       }
       @IBAction func pButtonTapped(_ sender: Any) {
           keyTapped(letter: "P")
       }
       @IBAction func qButtonTapped(_ sender: Any) {
           keyTapped(letter: "Q")
       }
       @IBAction func rButtonTapped(_ sender: Any) {
           keyTapped(letter: "R")
       }
       @IBAction func sButtonTapped(_ sender: Any) {
           keyTapped(letter: "S")
       }
       @IBAction func tButtonTapped(_ sender: Any) {
           keyTapped(letter: "T")
       }
       @IBAction func uButtonTapped(_ sender: Any) {
           keyTapped(letter: "U")
       }
       @IBAction func vButtonTapped(_ sender: Any) {
           keyTapped(letter: "V")
       }
       @IBAction func wButtonTapped(_ sender: Any) {
           keyTapped(letter: "W")
       }
       @IBAction func xButtonTapped(_ sender: Any) {
           keyTapped(letter: "X")
       }
       @IBAction func yButtonTapped(_ sender: Any) {
           keyTapped(letter: "Y")
       }
       @IBAction func zButtonTapped(_ sender: Any) {
           keyTapped(letter: "Z")
       }
       @IBAction func deleteButtonTapped(_ sender: Any) {
           deleteTapped()
       }

        //Haptic
    let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    let successFeedback = UINotificationFeedbackGenerator()

       private func keyTapped(letter: String) {
           mediumImpact.impactOccurred()
           changeButtonStateToReady()
           if textLabel.text?.count == 7 {
               return
           }
           if self.textLabel.text == "Nick Name"{
               textLabel.text = letter
               return
           }
           DispatchQueue.main.async {
                   self.textLabel.text = (self.textLabel.text ?? "") + letter
               }
       }

       private func deleteTapped() {
           heavyImpact.impactOccurred()
           guard var text = textLabel.text else { return }
           if !text.isEmpty {
               text.removeLast()
               textLabel.text = text
               if text.isEmpty {
                   changeButtonStateToNotReady()
               }
           } else {
               changeButtonStateToNotReady()
           }
       }
    
    private func changeButtonStateToReady(){
        
        if isReady == false {
            DispatchQueue.main.async {
                self.startButton.tintColor = .clear
                self.startButton.setImage(UIImage(named: "StartButton"), for: .normal)
                self.startButton.setTitle("", for: .normal)
                self.startButton.titleLabel?.textColor = .black
                self.isReady = true
                return
            }
        }
    }
    
    private func changeButtonStateToNotReady(){
        isReady = false
            DispatchQueue.main.async {
                self.startButton.tintColor = .clear
                self.startButton.setImage(UIImage(named: "StartLockedButton"), for: .normal)
                self.startButton.setTitle("", for: .normal)
                self.startButton.titleLabel?.textColor = .black
                return
        }
    }
    
    var isReady: Bool = false
    
    @IBAction func startButtonTapped(_ sender: Any) {
        successFeedback.notificationOccurred(.success)
        if isReady {
            if let name = textLabel?.text {
                let player = Player(nickname: name, wordStacks: [])
                GameController.shared.addPlayer(player)
                transitionToHome(withPlayer: player)
            }
        }
    }
    
    
    func transitionToHome(withPlayer: Player) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            homeViewController.currentPlayer = withPlayer
            window.rootViewController = homeViewController
            UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionFlipFromRight],
                              animations: nil,
                              completion: nil)
        }
    }
    
   }
