//
//  ViewController.swift
//  Rescue SDK Example Camera
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

import UIKit
import RescueCore

class ViewController: UIViewController, RescueSessionDelegate {

    // MARK: Outlets

    /// This view will be used by the Camera Stream SDK to render the video from the camera
    @IBOutlet weak var cameraRenderView: UIView!

    /// Button to toggle flashlight
    @IBOutlet weak var flashlightButton: UIButton!
    
    /// Button to tiggle pause/resume
    @IBOutlet weak var pauseButton: UIButton!
    
    /// Button to connect/disconnect the support session
    @IBOutlet weak var connectButton: UIButton!
    
    /// Session status label
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // You can use this function to set default values for session start parameters
        setDefaultValues()
        
        // Set the unique identifier for the app
        RescueSession.sharedInstance.apiKey = UserDefaults.standard.object(forKey: "apiKey") as! String

        // Set self as delegate for the Rescue Session object
        RescueSession.sharedInstance.delegate = self
        
        // Enable camera streaming with audio
        RescueCamera.sharedInstance.enable(withAudio: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // start rendering the local stream to the rende view
        RescueCamera.sharedInstance.startLocalStreamRendering(in: cameraRenderView)
    }

    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }

    /// Set default values for session start parameters.
    fileprivate func setDefaultValues() {
        // set default value for channel ID
        if UserDefaults.standard.object(forKey: "channelID") == nil {
            UserDefaults.standard.set("", forKey: "channelID")
        }
        
        // set default value for channel name
        if UserDefaults.standard.object(forKey: "channelName") == nil {
            UserDefaults.standard.set("", forKey: "channelName")
        }
        
        // set default value for company ID
        if UserDefaults.standard.object(forKey: "companyID") == nil {
            UserDefaults.standard.set("", forKey: "companyID")
        }
        
        // set default value for API key
        if UserDefaults.standard.object(forKey: "apiKey") == nil {
            UserDefaults.standard.set("", forKey: "apiKey")
        }
    }
    
    // MARK: RescueSessionDelegate

    func rescueSessionStatusDidChange(_ status: RescueSessionStatus) {
        print("status \(status.rawValue)")
        
        // set the title for the status label based of the session status
        switch status {
        case .connected:
            statusLabel.text = "Connected"
            connectButton.setTitle("Disconnect", for: UIControlState())
        case .connecting:
            statusLabel.text = "Connecting"
            connectButton.setTitle("Disconnect", for: UIControlState())
        case .connectionLost:
            statusLabel.text = "Connection lost"
            connectButton.setTitle("Disconnect", for: UIControlState())
        case .disconnected:
            statusLabel.text = "Disconnected"
            connectButton.setTitle("Connect", for: UIControlState())
        case .disconnecting:
            statusLabel.text = "Disconnecting"
            connectButton.setTitle("Disconnect", for: UIControlState())
        case .onHold:
            statusLabel.text = "On hold"
            connectButton.setTitle("Disconnect", for: UIControlState())
        case .transferred:
            statusLabel.text = "Transfering"
            connectButton.setTitle("Disconnect", for: UIControlState())
        case .waitingForTechnician:
            statusLabel.text = "Waiting for technician"
            connectButton.setTitle("Disconnect", for: UIControlState())
        default:
            statusLabel.text = "Idle"
            connectButton.setTitle("Connect", for: UIControlState())
        }
    }
    
    func rescueSessionError(_ error: RescueError, withUserInfo userInfo: [String : AnyObject]?) {
        print("error \(error.rawValue) \(String(describing: userInfo))")
    }
    
    // MARK: Target actions
    
    @IBAction func flashlightButtonPressed()
    {
        if RescueCamera.sharedInstance.flashState == .off
        {
            RescueCamera.sharedInstance.turnOnFlash()
        }
        else
        {
            RescueCamera.sharedInstance.turnOffFlash()
        }
    }
    
    @IBAction func pauseButtonPressed()
    {
        if RescueCamera.sharedInstance.isPaused == false
        {
            RescueCamera.sharedInstance.pauseStreamingVideo()
        }
        else
        {
            RescueCamera.sharedInstance.resumeStreamingVideo()
        }
    }

    @IBAction func connectButtonPressed()
    {
        if RescueSession.sharedInstance.sessionStatus == .disconnected ||
           RescueSession.sharedInstance.sessionStatus == .idle
        {
            // create an alert controller
            let alertController = UIAlertController(title: "Connect", message: nil, preferredStyle: .alert)

            // create actions (buttons) for the alert:
            // private session button
            let pinAction = UIAlertAction(title: "Private Session", style: .default) { _ in self.privateSession() }
            // channel id session button
            let channelIDAction = UIAlertAction(title: "Channel ID Session", style: .default) { _ in self.channelIDSession() }
            // channel name session button
            let channelNameAction = UIAlertAction(title: "Channel name Session", style: .default) { _ in self.channelNameSession() }
            
            // add the actions to the controller
            alertController.addAction(pinAction)
            alertController.addAction(channelIDAction)
            alertController.addAction(channelNameAction)
            alertController.addAction(cancelAction())
            
            // present the alert
            present(alertController, animated: true) {}
        } else {
            RescueSession.sharedInstance.endSession()
        }
    }
    
    @IBAction func apiKeyButtonPressed()
    {
        let alertController = UIAlertController(title: "API key", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            if let apiKey = alertController.textFields![0].text {
                RescueSession.sharedInstance.apiKey = apiKey
                UserDefaults.standard.set(apiKey, forKey: "apiKey")
            }
        })
        
        alertController.addTextField { (textField) in
            textField.placeholder = "API key"
            if let apiKey = UserDefaults.standard.object(forKey: "apiKey") as? String {
                textField.text = apiKey
                textField.keyboardAppearance = .dark
            }
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction())
        
        present(alertController, animated: true) {}
    }
    
    func cancelAction() -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel) { _ in }
    }
    
    // MARK: Start session
    
    func privateSession() {
        
        let alertController = UIAlertController(title: "Private session", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Connect", style: .default, handler: { _ in
            if let pin = alertController.textFields![0].text {
                RescueSession.sharedInstance.sessionStartParameters.start(withPinCode: pin)
                RescueSession.sharedInstance.startSession()
            }
        })
        action.isEnabled = false
        
        alertController.addAction(action)
        alertController.addAction(cancelAction())

        alertController.addTextField { (textField) in
            textField.placeholder = "PIN code"
            textField.keyboardType = .numberPad
            textField.keyboardAppearance = .dark

            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { (notification) in
                action.isEnabled = textField.text?.count == 6
            }
        }

        present(alertController, animated: true) {}
    }
    
    func channelIDSession() {
        
        let alertController = UIAlertController(title: "Channel ID session", message: nil, preferredStyle: .alert)
        
        let connectAction = UIAlertAction(title: "Connect", style: .default, handler: { _ in
            if let channel = alertController.textFields![0].text {
                UserDefaults.standard.set(channel, forKey: "channelID")
                RescueSession.sharedInstance.sessionStartParameters.start(withChannelId: channel)
                RescueSession.sharedInstance.startSession()
            }
        })
        
        alertController.addAction(connectAction)
        alertController.addAction(cancelAction())

        alertController.addTextField { (textField) in
            textField.placeholder = "Channel ID"
            if let channel = UserDefaults.standard.object(forKey: "channelID") as? String {
                textField.text = channel
                textField.keyboardType = .numberPad
                textField.keyboardAppearance = .dark
            }
        }
        
        present(alertController, animated: true) {}
    }

    func channelNameSession() {
        
        let alertController = UIAlertController(title: "Channel name session", message: nil, preferredStyle: .alert)
        
        let connectAction = UIAlertAction(title: "Connect", style: .default, handler: { _ in
            if let channel = alertController.textFields![0].text, let company = alertController.textFields![1].text {
                UserDefaults.standard.set(channel, forKey: "channelName")
                UserDefaults.standard.set(company, forKey: "companyID")
                RescueSession.sharedInstance.sessionStartParameters.start(withCompanyId: company, andChannelName: channel)
                RescueSession.sharedInstance.startSession()
            }
        })
        
        alertController.addAction(connectAction)
        alertController.addAction(cancelAction())
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Channel name"
            if let channel = UserDefaults.standard.object(forKey: "channelName") as? String {
                textField.text = channel
                textField.keyboardAppearance = .dark
            }
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Company ID"
            if let company = UserDefaults.standard.object(forKey: "companyID") as? String {
                textField.text = company
                textField.keyboardType = .numberPad
                textField.keyboardAppearance = .dark
            }
        }
        
        present(alertController, animated: true) {}
    }

}

