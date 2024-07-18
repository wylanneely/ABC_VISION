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
    
    var writtenWord = ""
    var fileName = ""
    let wordConverter = WrittenWordConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
                  sceneView.autoenablesDefaultLighting = true
        
        fileName = wordConverter.getFileNameFrom(writtenWord)

    }
    
    func startSceneWith(word:String){
        
        let fileLocation = createSceneFileName(fileName)
        
        guard let scene = SCNScene(named: fileLocation) else {
            //call spelling error function
            return
        }
          sceneView.scene = scene

    }
    
      func createSceneFileName(_ word:String)-> String {
          return "art.scnassets/\(word.capitalized).scn"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //MARK: - Outlets
    
    @IBAction func launchButton(_ sender: Any) {
        startSceneWith(word: self.writtenWord)
        
    }
    

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
//    override func captureTextFromCamera(_ sender: Any?) {
//
//    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
