//
//  ViewController.swift
//  Rescue SDK Example Camera
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

import UIKit

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
        RescueSession.sharedInstance().apiKey = NSUserDefaults.standardUserDefaults().objectForKey("apiKey") as! String

        // Set self as delegate for the Rescue Session object
        RescueSession.sharedInstance().delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // start rendering the local stream to the rende view
        RescueCamera.sharedInstance().startLocalStreamRenderingInView(cameraRenderView)
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
    }

    /// Set default values for session start parameters.
    private func setDefaultValues() {
        // set default value for channel ID
        if NSUserDefaults.standardUserDefaults().objectForKey("channelID") == nil {
            NSUserDefaults.standardUserDefaults().setObject("", forKey: "channelID")
        }
        
        // set default value for channel name
        if NSUserDefaults.standardUserDefaults().objectForKey("channelName") == nil {
            NSUserDefaults.standardUserDefaults().setObject("", forKey: "channelName")
        }
        
        // set default value for company ID
        if NSUserDefaults.standardUserDefaults().objectForKey("companyID") == nil {
            NSUserDefaults.standardUserDefaults().setObject("", forKey: "companyID")
        }
        
        // set default value for API key
        if NSUserDefaults.standardUserDefaults().objectForKey("apiKey") == nil {
            NSUserDefaults.standardUserDefaults().setObject("", forKey: "apiKey")
        }
    }
    
    // MARK: RescueSessionDelegate

    func rescueSessionStatusDidChange(status: RescueSessionStatus) {
        print("status \(status.rawValue)")
        
        // set the title for the status label based of the session status
        switch status {
        case .Connected:
            statusLabel.text = "Connected"
            connectButton.setTitle("Disconnect", forState: .Normal)
        case .Connecting:
            statusLabel.text = "Connecting"
            connectButton.setTitle("Disconnect", forState: .Normal)
        case .ConnectionLost:
            statusLabel.text = "Connection lost"
            connectButton.setTitle("Disconnect", forState: .Normal)
        case .Disconnected:
            statusLabel.text = "Disconnected"
            connectButton.setTitle("Connect", forState: .Normal)
        case .Disconnecting:
            statusLabel.text = "Disconnecting"
            connectButton.setTitle("Disconnect", forState: .Normal)
        case .OnHold:
            statusLabel.text = "On hold"
            connectButton.setTitle("Disconnect", forState: .Normal)
        case .Transferred:
            statusLabel.text = "Transfering"
            connectButton.setTitle("Disconnect", forState: .Normal)
        case .WaitingForTechnician:
            statusLabel.text = "Waiting for technician"
            connectButton.setTitle("Disconnect", forState: .Normal)
        default:
            statusLabel.text = "Idle"
            connectButton.setTitle("Connect", forState: .Normal)
        }
    }
    
    func rescueSessionError(errorCode: RescueError, withUserInfo userInfo: [NSObject : AnyObject]!) {
        print("error \(errorCode.rawValue) \(userInfo)")
    }
    
    // MARK: Target actions
    
    @IBAction func flashlightButtonPressed()
    {
        if RescueCamera.sharedInstance().flashState == .Off
        {
            RescueCamera.sharedInstance().turnOnFlash()
        }
        else
        {
            RescueCamera.sharedInstance().turnOffFlash()
        }
    }
    
    @IBAction func pauseButtonPressed()
    {
        if RescueCamera.sharedInstance().isPaused == false
        {
            RescueCamera.sharedInstance().pauseStreaming()
        }
        else
        {
            RescueCamera.sharedInstance().resumeStreaming()
        }
    }

    @IBAction func connectButtonPressed()
    {
        if RescueSession.sharedInstance().sessionStatus == .Disconnected ||
           RescueSession.sharedInstance().sessionStatus == .Idle
        {
            // create an alert controller
            let alertController = UIAlertController(title: "Connect", message: nil, preferredStyle: .Alert)

            // create actions (buttons) for the alert:
            // private session button
            let pinAction = UIAlertAction(title: "Private Session", style: .Default) { _ in self.privateSession() }
            // channel id session button
            let channelIDAction = UIAlertAction(title: "Channel ID Session", style: .Default) { _ in self.channelIDSession() }
            // channel name session button
            let channelNameAction = UIAlertAction(title: "Channel name Session", style: .Default) { _ in self.channelNameSession() }
            
            // add the actions to the controller
            alertController.addAction(pinAction)
            alertController.addAction(channelIDAction)
            alertController.addAction(channelNameAction)
            alertController.addAction(cancelAction())
            
            // present the alert
            presentViewController(alertController, animated: true) {}
        } else {
            RescueSession.sharedInstance().endSession()
        }
    }
    
    @IBAction func apiKeyButtonPressed()
    {
        let alertController = UIAlertController(title: "API key", message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { _ in
            if let apiKey = alertController.textFields![0].text {
                RescueSession.sharedInstance().apiKey = apiKey
                NSUserDefaults.standardUserDefaults().setObject(apiKey, forKey: "apiKey")
            }
        })
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "API key"
            if let apiKey = NSUserDefaults.standardUserDefaults().objectForKey("apiKey") as? String {
                textField.text = apiKey
                textField.keyboardAppearance = .Dark
            }
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction())
        
        presentViewController(alertController, animated: true) {}
    }
    
    func cancelAction() -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .Cancel) { _ in }
    }
    
    // MARK: Start session
    
    func privateSession() {
        
        let alertController = UIAlertController(title: "Private session", message: nil, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Connect", style: .Default, handler: { _ in
            if let pin = alertController.textFields![0].text {
                RescueSession.sharedInstance().sessionStartParameters.startWithPinCode(pin)
                RescueSession.sharedInstance().startSession()
            }
        })
        action.enabled = false
        
        alertController.addAction(action)
        alertController.addAction(cancelAction())

        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "PIN code"
            textField.keyboardType = .NumberPad
            textField.keyboardAppearance = .Dark

            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
                action.enabled = textField.text?.characters.count == 6
            }
        }

        presentViewController(alertController, animated: true) {}
    }
    
    func channelIDSession() {
        
        let alertController = UIAlertController(title: "Channel ID session", message: nil, preferredStyle: .Alert)
        
        let connectAction = UIAlertAction(title: "Connect", style: .Default, handler: { _ in
            if let channel = alertController.textFields![0].text {
                NSUserDefaults.standardUserDefaults().setObject(channel, forKey: "channelID")
                RescueSession.sharedInstance().sessionStartParameters.startWithChannelId(channel)
                RescueSession.sharedInstance().startSession()
            }
        })
        
        alertController.addAction(connectAction)
        alertController.addAction(cancelAction())

        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Channel ID"
            if let channel = NSUserDefaults.standardUserDefaults().objectForKey("channelID") as? String {
                textField.text = channel
                textField.keyboardType = .NumberPad
                textField.keyboardAppearance = .Dark
            }
        }
        
        presentViewController(alertController, animated: true) {}
    }

    func channelNameSession() {
        
        let alertController = UIAlertController(title: "Channel name session", message: nil, preferredStyle: .Alert)
        
        let connectAction = UIAlertAction(title: "Connect", style: .Default, handler: { _ in
            if let channel = alertController.textFields![0].text, let company = alertController.textFields![1].text {
                NSUserDefaults.standardUserDefaults().setObject(channel, forKey: "channelName")
                NSUserDefaults.standardUserDefaults().setObject(company, forKey: "companyID")
                RescueSession.sharedInstance().sessionStartParameters.startWithCompanyId(company, andChannelName: channel)
                RescueSession.sharedInstance().startSession()
            }
        })
        
        alertController.addAction(connectAction)
        alertController.addAction(cancelAction())
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Channel name"
            if let channel = NSUserDefaults.standardUserDefaults().objectForKey("channelName") as? String {
                textField.text = channel
                textField.keyboardAppearance = .Dark
            }
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Company ID"
            if let company = NSUserDefaults.standardUserDefaults().objectForKey("companyID") as? String {
                textField.text = company
                textField.keyboardType = .NumberPad
                textField.keyboardAppearance = .Dark
            }
        }
        
        presentViewController(alertController, animated: true) {}
    }

}

