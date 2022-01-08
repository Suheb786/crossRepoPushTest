import Flutter
import UIKit
import InfobipRTC
import WebRTC
import AFNetworking
import Foundation

protocol EventListener {
    func handleEvent(event: String) -> ()
}

public class SwiftInfobipPlugin: NSObject, FlutterPlugin, CallDelegate, FlutterStreamHandler {
    
    var identity: String? = ""
    var displayName: String? = ""
    var applicationId: String? = ""
//    var authorizationToken = "26b9894709b15ac31ff40161e599a955-30ec6c16-04da-4f20-8dc6-9a35f1067eb2"
    var appKey: String? = ""
    var baseUrl: String? = ""
    var callToken: String? = nil
    var callExpirationTime: String? = nil
    var resString: String? = nil
    var callStatus = "None"
    var isMute = false
    var isOnSpeaker = false
    var callDuration = 0
    var callStartTime: Date? = nil
    var callEstablishTime: Date? = nil
    var callEndTime: Date? = nil
    var outgoingCall: OutgoingCall? = nil
    var isApicall = false
    var gettoken = String()
    var eventSink:FlutterEventSink?
    
    let RandomNumberStreamHandle = SwiftStreamHandler()
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "infobip_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftInfobipPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        print(object.EVENT_CHANNEL)
        let evenChannel = FlutterEventChannel(name:"infobip_plugin_event", binaryMessenger: registrar.messenger())
        evenChannel.setStreamHandler(instance)
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("On Listen Start")
        eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        print("OnCancel")
        eventSink = nil
        return nil
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print(call.method);
        switch call.method {
        case object.INITIALISATION:
            print(call.arguments ?? "")
            let dicData = call.arguments as? [String : Any]
            baseUrl = dicData?["app_base_url"] as? String
            appKey = dicData?["app_key"] as? String
            applicationId = dicData?["application_id"] as? String

            UserDefaults.standard.set(baseUrl, forKey: "baseUrl")
            UserDefaults.standard.set(appKey, forKey: "appKey")
            UserDefaults.standard.set(applicationId, forKey: "applicationId")
            print("app_base_url", baseUrl!)
            result(true)

        case object.FETCH_TOKEN:
            print("Arguments ",call.arguments ?? "")

            let dicData = call.arguments as? [String : Any]
            displayName = dicData?["displayName"] as? String
            identity = dicData?["identity"] as? String
            outgoingCall?.delegate = self
            let manager = AFHTTPSessionManager()
            let serializer = AFJSONRequestSerializer()
            serializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
            serializer.setValue("App " + appKey!, forHTTPHeaderField: "Authorization")
            manager.requestSerializer = serializer

            let paraamDic = ["identity":identity,
                             "applicationId":applicationId,
                             "displayName":displayName]

            manager.post(baseUrl! + "/webrtc/1/token", parameters: paraamDic, headers: [:], progress: nil) { (Operation, Response) in


                let data = Response as? [String : String]
                let token = data?["token"]
                self.gettoken = token ?? ""
                let encoder = JSONEncoder()
                if let jsonData = try? encoder.encode(data) {
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        print(jsonString)
                        self.resString = jsonString
                        result(jsonString)
                    }
                }


            } failure: { (Operation, Error) in
                print(Error.localizedDescription)
            }

        case object.DIAL_CALL:
            print(call.arguments ?? "")
            dialCall(token: gettoken)

        case object.FINAL_CALL_STATUS:
            print("FINAL_CALL_STATUS")

        case object.MUTE_CALL:
            let muteUnmuteCall = outgoingCall?.muted()
            outgoingCall?.mute(!muteUnmuteCall!)
            print(!muteUnmuteCall! as Any)
            result(outgoingCall?.muted())

        case object.CALL_SPEAKER_PHONE:
            callSpeakerPhone()
            result(outgoingCall?.speakerphone())

        case object.CALL_DURATION:
            getCallDuration()
            result(callDuration)

        case object.CALL_START_TIME:
            callStartTime = outgoingCall?.startTime()
            result("\(callStartTime ?? Date())")

        case object.CALL_ESTABLISH_TIME:
            callEstablishTime = outgoingCall?.establishTime()
            result("\(callEstablishTime ?? Date())")

        case object.CALL_END_TIME:
            callEndTime = outgoingCall?.endTime()
            result("\(callEndTime ?? Date())")

        case object.CALL_HANG_UP:
            callHangUp()
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    /* func obtainToken(identity: String, displayName: String, result: FlutterResult)
     {
     //        print(object.APP_KEY)
     let manager = AFHTTPSessionManager()
     let serializer = AFJSONRequestSerializer()
     serializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
     serializer.setValue("App " + authorizationToken, forHTTPHeaderField: "Authorization")
     manager.requestSerializer = serializer

     let paraamDic = ["identity":identity,
     "applicationId":applicationId,
     "displayName":displayName]

     manager.post(baseUrl! + "/webrtc/1/token", parameters: paraamDic, headers: [:], progress: nil) { (Operation, Response) in


     let data = Response as? [String : String]
     let encoder = JSONEncoder()
     if let jsonData = try? encoder.encode(data) {
     if let jsonString = String(data: jsonData, encoding: .utf8) {
     print(jsonString)
     self.resString = jsonString
     result(jsonString)
     //self.isApicall = true
     }
     }


     } failure: { (Operation, Error) in
     print(Error.localizedDescription)
     }
     }*/

    //MARK:- *** Function for Dial Call ***
    func dialCall(token: String)
    {
        print(token)
        let callRequest = CallConversationsRequest(token, self)
        do {
            try outgoingCall =  InfobipRTC.callConversations(callRequest)
            print("Dial Call")
        } catch _ {
            print("Error")
        }
    }

    //MARK:- *** Call Event Methods ***
    /*** call end */
    func callHangUp() {
        outgoingCall?.hangup()
    }
    /*** call end time */
    func getCallEndTime() {
        callEndTime = outgoingCall?.endTime()
    }
    /*** call establish time */
    func getCallEstablishTime() {
        callEstablishTime = outgoingCall?.establishTime()
    }

    /*** call start time */
    func getCallStartTime() {
        callStartTime = outgoingCall?.startTime()
        print(callStartTime!)
    }

    /*** call duration */
    func getCallDuration() {
        callDuration = (outgoingCall?.duration()) ?? 0
    }

    /*** call on speaker event*/
    func callSpeakerPhone() {
        let callOnSpeaker = outgoingCall?.speakerphone()
        outgoingCall?.speakerphone(!callOnSpeaker!)
    }

    /*** call mute event*/
    func muteCall() {
        
    }

    //MARK:- *** call clear method ***
    func clearCallFinished()
    {
        if !callToken!.isEmpty{
            callToken = nil
        }
        if !callExpirationTime!.isEmpty {
            callExpirationTime = nil
        }
        if !identity!.isEmpty {
            identity = nil
        }
        if !displayName!.isEmpty {
            displayName = nil
        }
        if callStartTime != nil{
            callStartTime = nil
        }
        if callEstablishTime != nil{
            callEstablishTime = nil
        }
        if callEndTime != nil{
            callEndTime = nil
        }
        if outgoingCall != nil{
            outgoingCall = nil
        }
        isMute = false
        isOnSpeaker = false
        callDuration = 0
    }



    //MARK:- *** call listeners for call event ***
    public func onRinging(_ callRingingEvent: CallRingingEvent) {
        print("Call is ringing.")
        callStatus = object.ON_RINGING
        eventSink!(callStatus)

    }

    public func onEarlyMedia(_ callEarlyMediaEvent: CallEarlyMediaEvent) {
        print("Received early media.")
        callStatus = object.ON_EARLY_MEDIA
        eventSink!(callStatus)

    }

    public func onEstablished(_ callEstablishedEvent: CallEstablishedEvent) {
        print("Call established.")
        callStatus = object.ON_ESTABLISHED
        eventSink!(callStatus)

    }

    public func onUpdated(_ callUpdatedEvent: CallUpdatedEvent) {
        print("Call updated.")
        callStatus = object.ON_UPDATED
        eventSink!(callStatus)

    }

    public func onHangup(_ callHangupEvent: CallHangupEvent) {
        print("Call hangupEvent.")
        callStatus = object.ON_HANGUP

        eventSink!(callStatus)

        //strem.sink!(object.ON_HANGUP)

    }

    public func onError(_ callErrorEvent: CallErrorEvent) {
        print("Call ended with error.")
        callStatus = object.ON_ERROR
        eventSink!(callStatus)
    }

    //MARK:- *** Function for toString() ***
    func toString(date : Date) -> String
    {
        let dateFormatter = DateFormatter()
        print(dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }


}
//MARK:- *** struct for Object Variables ***
struct object {

    static var TAG = "InfobipPlugin"
    static var CHANNEL = "infobip_plugin"
    static var INITIALISATION = "initialisation"
    static var DIAL_CALL = "dial_call"
    static var FETCH_TOKEN = "fetch_token"
    static var FINAL_CALL_STATUS = "final_call_status"
    static var APPLICATION_ID = "application_id"
    static var APP_KEY = "app_key"
    static var BASE_URL = "app_base_url"
    static var MUTE_CALL = "mute_call"
    static var CALL_SPEAKER_PHONE = "call_speaker_phone"
    static var CALL_DURATION = "call_duration"
    static var CALL_START_TIME = "call_start_time"
    static var CALL_ESTABLISH_TIME = "call_establish_time"
    static var CALL_END_TIME = "call_end_time"
    static var CALL_HANG_UP = "call_hangup"
    static var ON_RINGING = "onRinging"
    static var ON_UPDATED = "onUpdated"
    static var ON_EARLY_MEDIA = "onEarlyMedia"
    static var ON_ESTABLISHED = "onEstablished"
    static var ON_HANGUP = "onHangup"
    static var ON_ERROR = "onError"
    static var EVENT_CHANNEL = "call_event"
}

