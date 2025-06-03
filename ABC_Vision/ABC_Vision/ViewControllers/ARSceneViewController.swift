//
//  ViewController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 7/3/24.
//

import UIKit
import SceneKit
import ARKit

class ARSceneViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var writtenWord: String = ""
    var fileName: String = ""
    let wordConverter = WrittenWordConverter()
    
    let animationController = AnimationController()
    
     override func viewDidLoad() {
         super.viewDidLoad()
         
         sceneView.delegate = self
         sceneView.showsStatistics = false
         sceneView.autoenablesDefaultLighting = true
         fileName = wordConverter.getFileNameFrom(writtenWord)
         
         // Make sure the scene view fills the screen when view loads
         sceneView.frame = view.bounds
     }
    
    //This funcitons adds a parent node so we can do jump animations to the animal/food nodes
    func setupAnimatedNode(_ node: SCNNode) -> SCNNode {
        let parent = SCNNode()
        parent.position = node.position
        node.position = SCNVector3Zero
        parent.addChildNode(node)
        return parent
    }
    
    func loadingDelayForButton(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.2, delay: 0.6) {
                self.launchAirplaneButton.tintColor = UIColor.green
            }
        }
    }
     
     func startSceneWith(word: String) {
         let fileLocation = createSceneFileName(fileName)
         
         guard let scene = SCNScene(named: fileLocation) else {
             return
         }
         sceneView.scene = scene
         
         
         //FIX: allow only the food and animal nodes to do this as of now.
         if let node = scene.rootNode.childNodes.first {
             let wrappedNode = setupAnimatedNode(node)
             sceneView.scene.rootNode.addChildNode(wrappedNode)

             // Animate the original child node (not the parent)
             animationController.animateNodeInScene(node, sceneFileName: word)
         }
         //This will be the else for the fix. just trying to get it working rn
//         if let node = scene.rootNode.childNodes.first {
//             animationController.animateNodeInScene(node, sceneFileName: word)
//         }
        
     }

     
     func createSceneFileName(_ word: String) -> String {
         return "art.scnassets/\(word.capitalized).scn"
     }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
         let configuration = ARWorldTrackingConfiguration()
         sceneView.session.run(configuration)
         loadingDelayForButton()
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         
         sceneView.session.pause()
     }
     
     //MARK: - Outlets
    @IBOutlet weak var launchAirplaneButton: UIButton!
    
     @IBAction func launchButton(_ sender: Any) {
         MusicPlayerManager.shared.playSoundFileNamed(name: "Whoosh")
         startSceneWith(word: self.writtenWord)
     }
     
     // MARK: - ARSCNViewDelegate
     
     // No need to restrict orientation unless you want to lock it to portrait.
     // Remove or modify this override if you want the app to support landscape.
     override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
         return .all // Allows both portrait and landscape
     }
    
     
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
         let node = SCNNode()
         return node
     }

     func session(_ session: ARSession, didFailWithError error: Error) {
         // Present an error message to the user
     }
     
     func sessionWasInterrupted(_ session: ARSession) {
         // Handle interruption
     }

     func sessionInterruptionEnded(_ session: ARSession) {
         // Reset tracking and/or remove existing anchors if consistent tracking is required
     }

     // Adjust layout on orientation change
     override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
         
         // Ensure the ARSCNView fills the screen on layout changes
         sceneView.frame = view.bounds
     }
     
     // Handle rotation or screen orientation changes
     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         super.viewWillTransition(to: size, with: coordinator)
         
         // Adjust ARSCNView layout on device orientation change
         coordinator.animate(alongsideTransition: { _ in
             self.sceneView.frame = self.view.bounds
         })
     }
    //MARK: Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = self.sceneView,
              let touchLocation = touches.first?.location(in: sceneView),
              let hitNode = sceneView.hitTest(touchLocation, options: nil).first?.node else { return }

        if let parent = hitNode.parent {
            animationController.triggerJump(on: parent)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
 }
