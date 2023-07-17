import UIKit
import Flutter
import UserNotifications
import MobileMessaging
import FirebaseCore
import AntelopSDK
import IDWise

@available(iOS 13.4, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, WalletProvisioningProtocol, WalletManagerProtocol, FlutterStreamHandler {
    
    var cardsArr = [String: DigitalCard]()
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("onListen")
        eventSink = events
        // eventSink!("This is antelop request")
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        print("OnCancel")
        eventSink = nil
        return nil
    }
    
    func onInitializationSuccess() {
        print("onInitializationSuccess callback IOS side")
        let initiliazeDic: [String: Any] = [
            "status": "onProvisioningSuccess",
        ]
        callBackMethods(event: "onInitializationSuccess", dic: initiliazeDic)
        // provisioner.checkEligibility(forbidJailBrokenDevices: false)
    }
    
    func onInitializationError(error: AntelopError) {
        print("onInitializationError : \(error.localizedDescription)")
        let initiliazeDic: [String: Any] = [
            "status": error.localizedDescription,
        ]
        callBackMethods(event: "onInitializationError", dic: initiliazeDic)
    }
    
    func onDeviceEligible(fingerprintAllowed: Bool, eligibleProducts: [Product]) {
        print("onDeviceEligible is called")
        let deviceEligibilityDic: [String: Any] = [
            "status": "onDeviceEligible is called",
        ]
        callBackMethods(event: "onDeviceEligible", dic: deviceEligibilityDic)
    }
    
    func onCheckEligibilityError(error: AntelopError) {
        print("Error while check eligibility of this device : \(error.localizedDescription)")
        let deviceEligibilityDic: [String: Any] = [
            "status": error.localizedDescription,
        ]
        callBackMethods(event: "onCheckEligibilityError", dic: deviceEligibilityDic)
    }
    
    func onDeviceNotEligible(reason: EligibilityDenialReason?, denialReference: String?) {
        print("This device is not eligible to Antelop Services : \(reason != nil ? String(describing: reason) : "unknown")\(denialReference != nil ? String(format:" (reference : %@)", String(describing:denialReference)) : "")")
        
        let deviceEligibilityDic: [String: Any] = [
            "status": "This device is not eligible to Antelop Services",
        ]
        callBackMethods(event: "onDeviceNotEligible", dic: deviceEligibilityDic)
    }
    
    func onProvisioningSuccess() {
        print("onProvisioningSuccess is called")
        let provisioningDic: [String: Any] = [
            "status": "onProvisioningSuccess",
        ]
        callBackMethods(event: "onProvisioningSuccess", dic: provisioningDic)
    }
    
    func onProvisioningError(error: AntelopError) {
        print("Provisioning error : \(error.localizedDescription)")
        let provisioningDic: [String: Any] = [
            "status": error.localizedDescription,
        ]
        callBackMethods(event: "onProvisioningError", dic: provisioningDic)
    }
    
    func onConnectionError(error: AntelopError) {
        print("-------onConnectionError--------------")
        let walletIdDic: [String: Any] = [
            "status": error.localizedDescription,
        ]
        callBackMethods(event: "onConnectionError", dic: walletIdDic)
    }
    
    func onProvisioningRequired() {
        print("----------------onProvisioningRequired-------------------")
        let provisioningDic: [String: Any] = [
            "status": "On Provisioning Required",
        ]
        callBackMethods(event: "onProvisioningRequired", dic: provisioningDic)
    }
    
    func onCredentialsRequired(reason: CustomerCredentialsRequiredReason) {
        print("--------------onCredentialsRequired-----------------")
        print(reason)
        print("--------------onCredentialsRequired-----------------")
        let walletIdDic: [String: Any] = [
            "status": "On Credentials Required",
        ]
        callBackMethods(event: "onProvisioningRequired", dic: walletIdDic)
    }
    
    func onConnectionSuccess(wallet: Wallet) {
        print("-----------onConnectionSuccess-------------")
        print(wallet)
        print("-----------onConnectionSuccess-------------")
        self.wallet = wallet
        print(wallet.getId() ?? "")
        let walletIdDic: [String: Any] = [
            "walletId": wallet.getId(),
            "getIssuerWalletId": wallet.getIssuerWalletId(),
            "getIssuerClientId":wallet.getIssuerClientId()
        ]
        callBackMethods(event: "onConnectionSuccess", dic: walletIdDic)
    }
    
    func onAsyncRequestError(asyncRequestCode: WalletManagerAsyncRequestEnum, error: AntelopError) {
        print("onAsyncRequestError")
        let walletIdDic: [String: Any] = [
            "status": error.localizedDescription,
        ]
        callBackMethods(event: "onAsyncRequestError", dic: walletIdDic)
    }
    
    func onAsyncRequestError(asyncRequestType: AsyncRequestType, error: AntelopError) {
        print("onAsyncRequestError")
        let walletIdDic: [String: Any] = [
            "status": error.localizedDescription,
        ]
        callBackMethods(event: "onAsyncRequestError", dic: walletIdDic)
    }
    
    func onAsyncRequestSuccess(asyncRequestCode: WalletManagerAsyncRequestEnum) {
        print("onAsyncRequestSuccess")
        let walletIdDic: [String: Any] = [
            "status": "On Async Request Success",
        ]
        callBackMethods(event: "onAsyncRequestSuccess", dic: walletIdDic)
    }
    
    func onAsyncRequestSuccess(asyncRequestType: AsyncRequestType) {
        print("onAsyncRequestSuccess")
        walletManager = WalletManager(self)
        let walletIdDic: [String: Any] = [
            "status": "On Async Request Success",
        ]
        callBackMethods(event: "onAsyncRequestSuccess", dic: walletIdDic)
    }
    
    public func launchWallet(clientId: String?, walletId: String?, settingsProfileId: String?, phoneNumber: String?)
    {
        do {
            try provisioner.launch(clientId: clientId, walletId: walletId, settingsProfileId: settingsProfileId, phoneNumber: phoneNumber)
        } catch WalletValidationError.mandatory(let domain) where domain == .settingsProfileId {
            print("You have to provide a Wallet Settings Profile in 'Profile Identifier' field")
        }
        catch {
            print("An error occurs while provisioning your wallet with wallet settings profile '\(settingsProfileId ?? "nil")' : \(error.localizedDescription)")
            
        }
    }
    
    public func callInitialize(){
        print("Enter in initialize method")
        provisioner.initialize()
    }
    
    public func callCheckEligibility(){
        print("Enter in checkEligibility method")
        provisioner.checkEligibility(forbidJailBrokenDevices: false)
    }
    
    public func walletConnect(){
        print("wallet connect method called")
        walletManager.connect()
    }
    
    public func walletLogout(){
        print("wallet logout method called")
        
        do { try
            walletManager.delete()
        } catch {
            print(error)
        }
    }
    
    public func walletDisconnect(){
        print("-----wallet disconnect method called------")
        
        do { try
            walletManager.disconnect()
        } catch {
            print("-----wallet disconnect error------")
            print(error)
            print("-----wallet disconnect error------")
        }
    }
    
    public func getCards(){
        print("enter get cards method")
        var cards =  wallet?.getDigitalCards(includeNotProvisionedCards: false)
        print("card list \(cards) end")
        if (cards?.values.count ?? 0) == 0 {
            self.callBackMethodsCardDetails(event: "emptyGetCards", dic: [[:]])
            print("Don't have any cards")
            return
        }
        let card = cards?.values.map({$0})[0]
        
        guard let cardsDits = cards else { return }
        cardsArr = cardsDits
        
        var allCardsDetail = [[String: Any]]()
        var cardtempDict =  [String:Any]()
        for (index, CARD)  in cardsArr.enumerated()  {
            let card = cardsArr.values.map({$0})[index]
            
            let cardStatus = (card.getStatus()?.description ?? "").lowercased()
            print("card status ---> ", cardStatus)
            
            var isActiveCard = false
            if cardStatus == "active" {
                isActiveCard = true
            }
            do { try  card.getApplePayService().isCardInApplePayOffline { status in
                
                cardtempDict = ["getIssuerCardId": card.getIssuerCardId() ?? "",
                                "getStatus": isActiveCard,
                                "isCardInApplePay": status,
                ] as [String : Any]
                
                allCardsDetail.append(cardtempDict)
                if  index == self.cardsArr.count - 1 {
                    print("loopEnded: ", allCardsDetail)
                    
                    self.callBackMethodsCardDetails(event: "getCards", dic: allCardsDetail)
                }
            } errorHandler: { Error in
                print(Error)
            }
            } catch {
                print(error)
            }
        }
        print(allCardsDetail)
    }
    
    //push card to apple pay
    
    func pushToCard(cardId:String) {
        print("ios side card id ", cardId)
        for (index, CARD)  in cardsArr.enumerated()  {
            let card = cardsArr.values.map({$0})[index]
            print("ios side getIssuerCardId id ", card.getIssuerCardId())
            if card.getIssuerCardId()?.trimmingCharacters(in: .whitespacesAndNewlines) == cardId {
                print("Match Found --------------", cardId)
                do { try  card.getApplePayService().pushCard({ result in
                    switch result {
                        
                    case .success(let status ) :
                        print ("status_getApplePayService: -- ", status)
                        let pushCardDic: [String: Any] = [
                            "status": status,
                        ]
                        self.callBackMethods(event: "pushCardSuccess", dic: pushCardDic)
                    case .failure(let error):
                        print( "status_getApplePayService_Failure,\(error)")
                        let pushCardDic: [String: Any] = [
                            "status": error,
                        ]
                        self.callBackMethods(event: "pushCardError", dic: pushCardDic)
                    }
                })
                    break
                } catch {
                    print(error)
                }
            }
        }
    }
    
    public func getAntelopCards(){
        print("enter Antelop get cards method")
        var newCards =  wallet?.getDigitalCards(includeNotProvisionedCards: false)
        print("antelopCardsList card list \(newCards) end")
        if (newCards?.values.count ?? 0) == 0 {
            self.callBackMethodsCardDetails(event: "antelopEmptyCardsList", dic: [[:]])
            print("Don't have any cards")
            return
        }
        let card = newCards?.values.map({$0})[0]
        
        guard let cardsDits = newCards else { return }
        cardsArr = cardsDits
        
        var allCardsDetail = [[String: Any]]()
        var cardtempDict =  [String:Any]()
        for (index, CARD)  in cardsArr.enumerated()  {
            let card = cardsArr.values.map({$0})[index]
            
            let cardStatus = (card.getStatus()?.description ?? "").lowercased()
            print("card status ---> ", cardStatus)
            
            var isActiveCard = false
            if cardStatus == "active" {
                isActiveCard = true
            }
            do { try  card.getApplePayService().isCardInApplePayOffline { status in
                
                cardtempDict = ["getIssuerCardId": card.getIssuerCardId() ?? "",
                                "getStatus": isActiveCard,
                                "isCardInApplePay": status,
                ] as [String : Any]
                
                allCardsDetail.append(cardtempDict)
                if  index == self.cardsArr.count - 1 {
                    print("loopEnded: ", allCardsDetail)
                    self.callBackMethodsCardDetails(event: "antelopCardsList", dic: allCardsDetail)
                }
            } errorHandler: { Error in
                print(Error)
            }
            } catch {
                print(error)
            }
        }
        print(allCardsDetail)
    }
    
    
    func enrollmentDataCard(enrollmentData: [[String:Any]]) {
        print("Before loop card array count :--- " , enrollmentData.count)
        let myGroup = DispatchGroup()
        var cardsREsponceArr = [[String:Any]]()
        for (index, enrolmentObject) in enrollmentData.enumerated() {
            do {
                myGroup.enter()
                try wallet?.enrollDigitalCard(enrollmentData: enrolmentObject["enrollmentData"] as? String ?? "", completion: { result in
                    switch result {
                    case .success(let status ) :
                        let cardTemp =  ["cardId": enrolmentObject["cardId"] as? String ?? "",
                                         "enrollmentData": enrolmentObject["enrollmentData"] as? String ?? "",
                                         "isEnrolled":true] as! [String:Any]
                        cardsREsponceArr.append(cardTemp)
                        myGroup.leave()
                        print ("enrollDigitalCard: - Successs", status)
                    case .failure(let error):
                        print( "status_getApplePayService_Failure,\(error)")
                        let cardTemp =  ["cardId": enrolmentObject["cardId"] as? String ?? "",
                                         "enrollmentData": enrolmentObject["enrollmentData"] as? String ?? "",
                                         "isEnrolled":false] as! [String:Any]
                        cardsREsponceArr.append(cardTemp)
                        myGroup.leave()
                    }
                })
            }  catch  {
                print(false, error.localizedDescription)
                myGroup.leave()
                let enrollCardDic: [String: Any] = [
                    "status": error.localizedDescription,
                ]
                //  self.callBackMethods(event: "enrollCardCatch", dic: enrollCardDic)
            }
        }
        myGroup.notify(queue: .main) {
            print("Finished all requests.")
            print("cards array coiunt:--- " , cardsREsponceArr.count)
            self.callBackMethodsCardDetails(event: "enrollCardSuccess", dic: cardsREsponceArr)
        }
    }
    
    private func callJavaScript(_ methodName: String, result text: String) {
        let dic: [String: String] = ["eventName": methodName, "response": text]
        eventSink?(dic)
    }
    
    
    private func callBackMethods(event eventName: String, dic: [String: Any]?, strData: String = "") {
        let strData = strData.isEmpty ? (dic == nil ? "" : convertDictionaryToString(dicData: dic!)) : strData
        printData(event: eventName, data: strData)
        callJavaScript(eventName, result: strData)
    }
    
    
    private func callBackMethodsCardDetails(event eventName: String, dic: [[String: Any]], strData: String = "") {
        let strData = strData.isEmpty ?  dic.toJSONString() : strData
        printData(event: eventName, data: strData)
        callJavaScript(eventName, result: strData)
    }
    
    func convertDictionaryToString(dicData: [String: Any]) -> String {
        var text = ""
        do {
            text = try dicData.stringify()
        } catch {
            print("Error: ", error)
        }
        return text
    }
    
    func printData(event: String, data: String) {
        print("\n\n**********************************")
        print("Event Name: ", event)
        print("**************************************")
        print(data)
        print("**************************************")
        print("**********************************\n\n")
    }
    
    var controller = FlutterViewController()
    var blinkMethodChannel = FlutterMethodChannel()
    
    var provisioner: WalletProvisioning!
    var walletManager: WalletManager!
    var wallet: Wallet?
    var digicalCard: DigitalCardServiceStatus!
    var eventSink: FlutterEventSink?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        provisioner = WalletProvisioning(self)
        walletManager = WalletManager(self)
        
        controller = window?.rootViewController as! FlutterViewController
        blinkMethodChannel = FlutterMethodChannel(name: "com.capital.cbt", binaryMessenger: controller.binaryMessenger)
        
        let instance = AppDelegate()
        
        let evenChannel = FlutterEventChannel(name: "continueListining", binaryMessenger: controller.binaryMessenger)
        evenChannel.setStreamHandler(self)
        
        self.registerForFirebaseNotification(application: application)
        
        // ========== Code to implement ==========
        
        //  var walletProvisioningView = WalletProvisioningView()
        
        blinkMethodChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "initialize":
                self?.callInitialize()
                
            case "getWalletLaunch":
                let dicData = call.arguments as? [String : Any]
                self?.launchWallet(clientId: dicData!["clientId"] as? String,
                                   walletId: dicData!["walletId"] as! String,
                                   settingsProfileId: dicData?["settingsProfileId"] as? String,
                                   phoneNumber: dicData!["phoneNumber"] as? String)
                
            case "walletConnect":
                self?.walletConnect()
                
            case "walletLogout":
                self?.walletLogout()
                
            case "walletDisconnect":
                self?.walletDisconnect()
                
            case "checkEligibility":
                self?.callCheckEligibility()
                
            case "enrollCard":
                let dicData = call.arguments as! [[String : Any]]
                print("enter in enrollment section \(dicData)")
                self?.enrollmentDataCard(enrollmentData: dicData)
                
            case "pushCard":
                let dicData = call.arguments as! [String : Any]
                print("enter in enrollment section \(dicData["cardId"] as! String)")
                self?.pushToCard(cardId: (dicData["cardId"] as! String))
                
            case "getAllCards":
                self?.getCards()
                
            case "getAntelopCards":
                self?.getAntelopCards()
                
            default:
                result("iOS " + UIDevice.current.systemVersion)
            }
        })
        
        
        let methodChannelName = "com.idwise.fluttersampleproject/idwise"
        var idWiseChannel: FlutterMethodChannel? = nil

        let idWiseController : FlutterViewController = window?.rootViewController as! FlutterViewController
            let idWisechannel = FlutterMethodChannel(name: methodChannelName,
                                                      binaryMessenger: idWiseController.binaryMessenger)
        
        
        self.idWiseChannel = channel
        
        idWiseChannel.setMethodCallHandler({ [self]
                  (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                  
                  switch call.method {
                  case "initialize":
                      // receiving arguments from Dart side and consuming here
                      
                      var clientKey: String = "" // should not be empty
                      var sdkTheme: IDWiseSDKTheme = IDWiseSDKTheme.systemDefault
                      if let parameteres = call.arguments as? [String:Any] {
                          if let clientkey = parameteres["clientKey"] as? String {
                              clientKey = clientkey
                          }
                          if let theme = parameteres["theme"] as? String {
                              if theme == "LIGHT" {
                                  sdkTheme = IDWiseSDKTheme.light
                              } else if theme == "DARK" {
                                  sdkTheme = IDWiseSDKTheme.dark
                              } else  {
                                  sdkTheme = IDWiseSDKTheme.systemDefault
                              }
                          }
                        
                      }
                      IDWise.initialize(clientKey: clientKey,theme: sdkTheme) { error in
                          result("got some error")
                          if let err = error {
                              channel.invokeMethod(
                                "onError",
                                arguments: ["errorCode": err.code,"message": err.message] as [String : Any])
                          }
                      }

                  case "startJourney":
                      // receiving arguments from Dart side and consuming here

                      var referenceNo: String = "" // optional parameter
                      var locale: String = "en"
                      var journeyDefinitionId = ""
                      if let parameteres = call.arguments as? [String:Any] {
                          if let refNo = parameteres["referenceNo"] as? String {
                              referenceNo = refNo
                          }
                          if let loc = parameteres["locale"] as? String {
                              locale = loc
                          }
                          if let journeyDefId = parameteres["journeyDefinitionId"] as? String {
                              journeyDefinitionId = journeyDefId
                          }
                      }
                      IDWise.startJourney(journeyDefinitionId: journeyDefinitionId,referenceNumber: referenceNo,locale: locale, journeyDelegate: self)
                      result("successfully started journey")
                  default:
                      result(FlutterMethodNotImplemented)
                  }
                  
              })
        
        
        AntelopAppDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        MobileMessagingPluginApplicationDelegate.install()
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    //    func checkPassRequest(){
    //        guard let configuration = PKAddPaymentPassRequestConfiguration(encryptionScheme: .ECC_V2) else {
    //                    // error
    //                    return
    //                }
    //
    //            // you need at least one of the 2, cardholderName or lastDigits
    //                configuration.cardholderName = "Test name"
    //                configuration.primaryAccountSuffix = lastDigits
    //
    //        guard let viewController = PKAddPaymentPassViewController(requestConfiguration: configuration, delegate: self) else {
    //    // if PKAddPaymentPassViewController is nil there, most probably an entitlement issue, check the logs
    //            return
    //        }
    //    }
    
    func registerForFirebaseNotification(application : UIApplication){
        //    Messaging.messaging().delegate     = self;
        if #available(iOS 10.0, *) {
            //UNUserNotificationCenter.current().delegate = self ;
            let authOpt : UNAuthorizationOptions = [.alert, .badge, .sound];
            UNUserNotificationCenter.current().requestAuthorization(options: authOpt, completionHandler: {_, _ in})
            UNUserNotificationCenter.current().delegate = self ;
        }else{
            let settings : UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings);
        }
        application.registerForRemoteNotifications();
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        AntelopAppDelegate.shared.applicationDidBecomeActive(application)
    }
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
        AntelopAppDelegate.shared.applicationDidEnterBackground(application)
    }
    
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("Fail to register to Remote Notification : \(error)")
    }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        AntelopAppDelegate.shared.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        guard !AntelopAppDelegate.shared.didReceiveRemoteNotification(userInfo, fetchCompletionHandler: { result in
            NSLog("AppDelegate.didReceiveRemoteNotification - will call didReceiveRemoteNotification completionHandler")
            completionHandler(result)
        }) else {
            NSLog("AppDelegate.didReceiveRemoteNotification - Notification handled by the Antelop SDK")
            return
        }
        NSLog("AppDelegate.didReceiveRemoteNotification - Notification NOT handled by the Antelop SDK")
        completionHandler(.noData)
    }
    
    override func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AntelopAppDelegate.shared.application(application, performFetchWithCompletionHandler: completionHandler)
    }
    
}

extension Collection where Iterator.Element == [String: Any] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String: Any]],
           let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
           let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}

extension AppDelegate:IDWiseSDKJourneyDelegate {
    func onJourneyResumed(journeyID: String) {
        channel?.invokeMethod(
                    "onJourneyResumed",
                    arguments: journeyID)
    }
    
    
    func onError(error : IDWiseSDKError) {
        channel?.invokeMethod(
                    "onError",
                    arguments: ["errorCode": error.code,"message": error.message] as [String : Any])
    }
    
    func JourneyStarted(journeyID: String) {
        channel?.invokeMethod(
                    "onJourneyStarted",
                    arguments: journeyID)
    }
    
    func JourneyFinished() {
        channel?.invokeMethod(
                    "onJourneyFinished",
                    arguments: nil)
    }
    
    func JourneyCancelled() {
        channel?.invokeMethod(
                    "onJourneyCancelled",
                    arguments: nil)
    }
   
}
