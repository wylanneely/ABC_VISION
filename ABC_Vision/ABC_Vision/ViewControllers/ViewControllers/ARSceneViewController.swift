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
    
     override func viewDidLoad() {
         super.viewDidLoad()
         
         sceneView.delegate = self
         sceneView.showsStatistics = false
         sceneView.autoenablesDefaultLighting = true
         fileName = wordConverter.getFileNameFrom(writtenWord)
         
         // Make sure the scene view fills the screen when view loads
         sceneView.frame = view.bounds
     }
     
     func startSceneWith(word: String) {
         let fileLocation = createSceneFileName(fileName)
         
         guard let scene = SCNScene(named: fileLocation) else {
             return
         }
         sceneView.scene = scene
     }
     
     func createSceneFileName(_ word: String) -> String {
         return "art.scnassets/\(word.capitalized).scn"
     }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
         let configuration = ARWorldTrackingConfiguration()
         sceneView.session.run(configuration)
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         
         sceneView.session.pause()
     }
     
     //MARK: - Outlets
     
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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
 }
