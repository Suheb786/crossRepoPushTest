
import Foundation
import Flutter

//class RandomNumberStreamHandler: NSObject, FlutterStreamHandler{
//    var sink: FlutterEventSink?
//    var timer: Timer?
//
//    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
//        sink = events
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendNewRandomNumber), userInfo: nil, repeats: true)
//        return nil
//    }
//
//    @objc func sendNewRandomNumber() {
//        guard let sink = sink else { return }
//
//        let randomNumber = Int.random(in: 1..<10)
//        sink(randomNumber)
//    }
//
//    func onCancel(withArguments arguments: Any?) -> FlutterError? {
//        sink = nil
//        timer?.invalidate()
//        return nil
//    }
//}
open class SwiftStreamHandler: NSObject, FlutterStreamHandler {
    

    open func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        events(true) // any generic type or more compex dictionary of [String:Any]
        events(FlutterError(code: "ERROR_CODE",
                             message: "Detailed message",
                             details: nil)) // in case of errors
        events(FlutterEndOfEventStream) // when stream is over
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}
