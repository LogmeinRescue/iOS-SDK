//
//  ViewController.swift
//  Rescue SDK Example Broadcast
//
//  Copyright © 2018. LogMeIn. All rights reserved.
//

import UIKit
import RescueCore
import UserNotifications
import ReplayKit

class ViewController: UIViewController {

    /// Button to connect/disconnect the support session
    @IBOutlet weak var connectButton: UIButton!

    /// Session status label
    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var broadcastPicker: RPSystemBroadcastPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert]){ (granted, error) in }

        // You can use this function to set default values for session start parameters
        setDefaultValues()
        
        // Set the unique identifier for the app
        RescueSession.sharedInstance.apiKey = UserDefaults.standard.object(forKey: "apiKey") as! String
        
        // Set self as delegate for the Rescue Session object
        RescueSession.sharedInstance.delegate = self
        
        // Do not conect to the session automatically, we want to connect later from the extension
        RescueSession.sharedInstance.connectToSessionAutomatically = false
        
        // Set the app group identifier. Use the same app group identifier for the app and extension. Also enable app groups for the app and the extension in the target's setting's capabilities tab. It is important to use the same identifier in every place.
        RescueSession.sharedInstance.appGroup = "group.com.logmein.rescue"
        
        broadcastPicker.isHidden = true
        broadcastPicker.preferredExtension = "com.logmein.rescue.example.broadcast.RescueBroadcastExampleExtension"
        
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
            
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main) { (notification) in
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
}


extension ViewController: RescueSessionDelegate {
    
    func rescueSessionStatusDidChange(_ status: RescueSessionStatus) {
        print("status \(status.rawValue)")

        // Hide the system screen share button
        broadcastPicker.isHidden = true

        // set the title for the status label based of the session status
        switch status {
        case .connected:
            statusLabel.text = "Connected"
            connectButton.setTitle("Disconnect", for: UIControl.State())
        case .connecting:
            statusLabel.text = "Connecting"
            connectButton.setTitle("Disconnect", for: UIControl.State())
        case .connectionLost:
            statusLabel.text = "Connection lost"
            connectButton.setTitle("Disconnect", for: UIControl.State())
        case .disconnected:
            statusLabel.text = "Disconnected"
            connectButton.setTitle("Connect", for: UIControl.State())
        case .disconnecting:
            statusLabel.text = "Disconnecting"
            connectButton.setTitle("Disconnect", for: UIControl.State())
        case .onHold:
            statusLabel.text = "On hold"
            connectButton.setTitle("Disconnect", for: UIControl.State())
        case .transferred:
            statusLabel.text = "Transfering"
            connectButton.setTitle("Disconnect", for: UIControl.State())
        case .waitingForTechnician:
            statusLabel.text = "Waiting for technician"
            connectButton.setTitle("Disconnect", for: UIControl.State())
        default:
            statusLabel.text = "Idle"
            connectButton.setTitle("Connect", for: UIControl.State())
        }
    }
    
    func rescueSessionError(_ error: RescueError, withUserInfo userInfo: [String : AnyObject]?) {
        print("error \(error.rawValue) \(String(describing: userInfo))")
    }
    
    // Get notification from the SDK about the session
    func rescueSessionReady() {
        statusLabel.text = "Session Ready"
        connectButton.setTitle("Disconnect", for: UIControl.State())
        // Tell the SDK that the app will not conect to the session, we want to connect later from the extension
        RescueSession.sharedInstance.broadcastSession()
        // Show the system screen share button
        broadcastPicker.isHidden = false
    }


}

