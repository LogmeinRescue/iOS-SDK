//
//  SampleHandler.swift
//  Rescue SDK Example Broadcast
//
//  Copyright © 2018. LogMeIn. All rights reserved.
//

import ReplayKit
import RescueBroadcast

class SampleHandler: RPBroadcastSampleHandler {
    
    var session: RescueBroadcastSession?
    
    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        // set app group (for normal and enterprise configuration use different app group)
        var groupIdentifier = "group.com.logmein.rescue"
        if let bundleIdentfier = Bundle.main.bundleIdentifier, bundleIdentfier.contains("enterprise") {
            groupIdentifier = "group.com.logmein.enterprise.rescue"
        }

        // Create the broadcast session object and set the app group identifier. Use the same app group identifier for the app and extension. Also enable app groups for the app and the extension on the target's setting's capabilities tab. It is important to use the same identifier in every place.
        session = RescueBroadcastSession(appGroup: groupIdentifier)

        // User has requested to start the broadcast. Connect the Rescue Session. You have to create a Rescue session prior this from the app.
        session?.connectSession()
    }
    
    override func broadcastPaused() {
        // User has requested to pause the broadcast. Samples will stop being delivered.
    }
    
    override func broadcastResumed() {
        // User has requested to resume the broadcast. Samples delivery will resume.
    }
    
    override func broadcastFinished() {
        session?.disconnectSession()
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        if sampleBufferType == .video {
            // Feed the Rescue broadcast SDK with the video frames from the system.
            session?.processVideoSampleBuffer(sampleBuffer)
        }
    }
}
