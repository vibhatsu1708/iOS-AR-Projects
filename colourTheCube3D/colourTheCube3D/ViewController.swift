//
//  ViewController.swift
//  colourTheCube3D
//
//  Created by Vedant Mistry on 30/01/24.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Cube Sides", bundle: Bundle.main) {
            configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 3
            print("Images successfully added!")
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            // Second method to reduce the opacity of the created plane.
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi/2
            // First method to reduce the opacity of the created plane.
//            planeNode.opacity = 0.5
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "mickey-image" {
                if let shipScene = SCNScene(named: "art.scnassets/pirate_ship_LowPoly.scn") {
                    if let shipNode = shipScene.rootNode.childNodes.first {
                        shipNode.eulerAngles.x = .pi/2
                        planeNode.addChildNode(shipNode)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "spiderman-image" {
                if let shipScene = SCNScene(named: "art.scnassets/Wicker_plastic_chair.scn") {
                    if let shipNode = shipScene.rootNode.childNodes.first {

                        planeNode.addChildNode(shipNode)
                    }
                }
            }
            if imageAnchor.referenceImage.name == "book-cover-1" {
                if let shipScene = SCNScene(named: "art.scnassets/ship.scn") {
                    if let shipNode = shipScene.rootNode.childNodes.first {
                        shipNode.eulerAngles.x = .pi/2
                        planeNode.addChildNode(shipNode)
                    }
                }
            }
        }
        
        return node
    }
}
