import Flutter
import UIKit
import InfobipRTC
import WebRTC
import Foundation
protocol EventListener {
    func handleEvent(event: String) -> ()
}

public class InfobippluginPlugin:  NSObject, FlutterPlugin,  FlutterStreamHandler {


    var identity: String? = ""
    var displayName: String? = ""
    var applicationId: String? = ""
    var appKey: String? = ""
    var baseUrl: String? = ""
    var appIdToken: String? = ""
    var appKeyToken: String? = ""
    var baseUrlToken: String? = ""
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
    var outgoingCall: WebrtcCall? = nil
    var isApicall = false
    var gettoken = String()
    var eventSink:FlutterEventSink?

    //let Rand0omNumberStreamHandle = SwiftStreamHandler()


    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "infobip_plugin", binaryMessenger: registrar.messenger())
        let instance = InfobippluginPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
      
        print(object.EVENT_CHANNEL)
        let evenChannel = FlutterEventChannel(name:"infobip_plugin_event", binaryMessenger: registrar.messenger())
        evenChannel.setStreamHandler(instance)
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("On Listen Start")
      print(events)
        eventSink = events
        UserDefaults.standard.set(callStatus, forKey: "eventSink")
        events(callStatus)
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
            print("app_base_url", baseUrl)
            result(true)

        case object.FETCH_TOKEN:
            print("Arguments ",call.arguments ?? "")

            let dicData = call.arguments as? [String : Any]
            displayName = dicData?["displayName"] as? String
            identity = dicData?["identity"] as? String
            appIdToken = dicData?["applicationId"] as? String
            baseUrlToken = dicData?["baseUrl"] as? String
            appKeyToken = dicData?["appKey"] as? String
            let parameters = ["identity": identity,
                          "applicationId": appIdToken,
                          "displayName": displayName,
                          "capabilities":"",
                          "timeToLive":""]


                let session = URLSession.shared
                let url = URL(string:(baseUrlToken ?? "") + "/webrtc/1/token")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
                request.setValue("App " + (appKeyToken ?? ""), forHTTPHeaderField: "Authorization")

            if let param = parameters as? [String : Any] {
                        let jsonData = try! JSONSerialization.data(withJSONObject: param, options:JSONSerialization.WritingOptions.prettyPrinted)

                        let json = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                        if let json = json {
                            print(json)
                        }
                        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
                    }



                let task = session.dataTask(with: request) { data, response, error in
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {

                        print(dataString)
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print(json)

                            let value = json as? [String:Any]
                            let token = (value?["token"] as? String) ?? ""
                            self.gettoken = token
                            result(token);
                        } catch {
                            print("JSON error: \(error.localizedDescription)")
                            result("Error -- \(error)")
                        }
                    }

                    if error != nil || data == nil {
                        NotificationCenter.default.post(name: Notification.Name("presentError"), object: nil, userInfo: ["message":"Check your internet connection."])

                        result("Error -- \(error)")
                        return
                    }

                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                        NotificationCenter.default.post(name: Notification.Name("presentError"), object: nil, userInfo: ["message":"Server error"])

                        result("Error -- \(error)")
                        return
                    }

                    guard let mime = response.mimeType, mime == "application/json" else {
                        print("Wrong MIME type!")
                        result("Error -- \(error)")
                        return
                    }


                }

                task.resume()

        case object.DIAL_CALL:
            print(call.arguments ?? "")
            let dicData = call.arguments as? [String : Any]
           let tokenCall = dicData?["token"] as? String
                       let audioSession = AVAudioSession.sharedInstance()
                       switch audioSession.recordPermission {
                       case .granted:
                           dialCall(token: tokenCall ?? "")
                           result(true)
                       case .denied:
                           audioSession.requestRecordPermission { granted in
                               if granted {
                                   self.dialCall(token: tokenCall ?? "")
                                   
                                   result(true)
                               } else {
                                   result(false)
                               }
                           }
                       case .undetermined:
                           audioSession.requestRecordPermission { granted in
                               if granted {
                                   self.dialCall(token: tokenCall ?? "")
                                   result(true)
                               } else {
                                   result(false)
                               }
                           }
                       @unknown default:
                           // Handle any future cases here.
                           break
                       }
            
        case object.FINAL_CALL_STATUS:
//            print("FINAL_CALL_STATUS  ==> " )
            print(callStatus)
            result(callStatus)
            

        case object.MUTE_CALL:
            //print(outgoingCall?.muted())
            let muteUnmuteCall = outgoingCall?.muted()
            do {
               // code that can throw an error
               try outgoingCall?.mute(!muteUnmuteCall!)
            } catch {
               // Handle the error here
            }
            
            if(muteUnmuteCall != nil){
                print(!muteUnmuteCall! as Any)
                result(outgoingCall?.muted())
            }
            else
            {
                result("Error")
            }
            
           

        case object.CALL_SPEAKER_PHONE:
            
        
                     guard  let callOnSpeaker = outgoingCall?.speakerphone() else {return}
                     print(callOnSpeaker)
                     outgoingCall?.speakerphone(!callOnSpeaker, { error in
                         print(error.debugDescription)
                         
                     })
            result(!(outgoingCall!.speakerphone()))

        case object.CALL_DURATION:
           print(outgoingCall?.duration())
           callDuration = (outgoingCall?.duration()) ?? 2
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



    //MARK: - *** Function for Dial Call ***
    func dialCall(token: String)
    {
        print(token)
        let infobipRTC: InfobipRTC = getInfobipRTCInstance();
        do {
            let callWebrtcRequest = CallWebrtcRequest(token, destination: "conversations", webrtcCallEventListener: self)
            try outgoingCall = infobipRTC.callWebrtc(callWebrtcRequest)
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
        outgoingCall?.speakerphone(true, { Error in
            
        })
    }

    /*** call mute event*/
    func muteCall() {

    }

    //MARK: - *** call clear method ***
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




    //MARK: - *** Function for toString() ***
    func toString(date : Date) -> String
    {
        let dateFormatter = DateFormatter()
        print(dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }


}
//MARK:  - *** struct for Object Variables ***
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
//MARK: - *** call listeners for call event ***

extension InfobippluginPlugin : WebrtcCallEventListener {
   
    
    public func onScreenShareRemoved(_ screenShareRemovedEvent: ScreenShareRemovedEvent) {
        print("onScreenShareRemoved")
    }

    public func onRinging(_ callRingingEvent: CallRingingEvent) {
        print("onRinging")
        callStatus = object.ON_RINGING
        print(callStatus)
        print(eventSink);
            // Use optionalValue safely here
            eventSink!(callStatus)
       

    }

    public  func onEarlyMedia(_ callEarlyMediaEvent: CallEarlyMediaEvent) {
        print("onEarlyMedia")
        callStatus = object.ON_EARLY_MEDIA
      
            // Use optionalValue safely here
            eventSink!(callStatus)
       
        

    }

    public func onEstablished(_ callEstablishedEvent: CallEstablishedEvent) {
        print("onEstablished")
        callStatus = object.ON_ESTABLISHED
        
            // Use optionalValue safely here
            eventSink!(callStatus)
       

    }

    public func onCameraVideoAdded(_ cameraVideoAddedEvent: CameraVideoAddedEvent) {
        print("onCameraVideoAdded")

    }

    public func onCameraVideoUpdated(_ cameraVideoUpdatedEvent: CameraVideoUpdatedEvent) {
        print("onCameraVideoUpdated")

    }

    public  func onCameraVideoRemoved() {
        print("onCameraVideoRemoved")

    }

    public  func onScreenShareAdded(_ screenShareAddedEvent: ScreenShareAddedEvent) {
        print("onScreenShareAdded")

    }

    public func onScreenShareRemoved() {
        print("onScreenShareRemoved")

    }

    public  func onRemoteCameraVideoAdded(_ cameraVideoAddedEvent: CameraVideoAddedEvent) {
        print("onRemoteCameraVideoAdded")

    }

    public  func onRemoteCameraVideoRemoved() {
        print("onRemoteCameraVideoRemoved")

    }

    public func onRemoteScreenShareAdded(_ screenShareAddedEvent: ScreenShareAddedEvent) {
        print("onRemoteScreenShareAdded")

    }

    public  func onRemoteScreenShareRemoved() {
        print("onRemoteScreenShareRemoved")

    }

    public func onRemoteMuted() {
        print("onRemoteMuted")

    }

    public  func onRemoteUnmuted() {
        print("onRemoteUnmuted")

    }

    public  func onHangup(_ callHangupEvent: CallHangupEvent) {
        print("onHangup")
        callStatus = object.ON_HANGUP + "-" + callHangupEvent.errorCode.name

        
            // Use optionalValue safely here
            eventSink!(callStatus)
      


    }

    public func onError(_ errorEvent: ErrorEvent) {
        print("onError")
        callStatus = object.ON_ERROR
            // Use optionalValue safely here
            eventSink!(callStatus)
    

    }
}
