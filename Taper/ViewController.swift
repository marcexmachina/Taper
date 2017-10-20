//
//  ViewController.swift
//  Taper
//
//  Created by Marc O'Neill on 20/10/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

  // MARK: - Outlets

  @IBOutlet var sceneView: ARSCNView!
  @IBOutlet weak var distanceLabel: UILabel!



  // MARK: - Private properties

  private let maxNumberOfSpheres = 2
  private var numberOfSpheres = 0
  private var sphereNodes: [SCNNode] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    // Set the view's delegate
    sceneView.delegate = self

    // Show statistics such as fps and timing information
    sceneView.showsStatistics = false

    let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
    tapRecogniser.numberOfTapsRequired = 1
    sceneView.addGestureRecognizer(tapRecogniser)
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

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }

  // MARK: - Private methods

  @objc private func handleTap(sender: UITapGestureRecognizer) {
    if let closestResult = sceneView.hitTest(sender.location(in: sceneView), types: .featurePoint).first {
      if numberOfSpheres < maxNumberOfSpheres {
        sceneView.session.add(anchor: ARAnchor(transform: closestResult.worldTransform))
        numberOfSpheres += 1
      }
    }
  }

  // MARK: - ARSCNViewDelegate

  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    let sphere = SCNSphere(radius: 0.01)
    sphere.firstMaterial?.diffuse.contents = UIColor.red
    node.geometry = sphere
    let lastNode = sphereNodes.last
    sphereNodes.append(node)
    if lastNode != nil {
      DispatchQueue.main.async {
        self.distanceLabel.text = "Distance:: \(lastNode!.distance(to: node)) metres"
      }
    }
  }

  func session(_ session: ARSession, didFailWithError error: Error) {
    // Present an error message to the user

  }

  func sessionWasInterrupted(_ session: ARSession) {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay

  }

  func sessionInterruptionEnded(_ session: ARSession) {
    // Reset tracking and/or remove existing anchors if consistent tracking is required

  }
}
