import UIKit
import Flutter
import GoogleMaps
import UserNotifications
import MobileMessaging
import FirebaseCore
import AntelopSDK

@available(iOS 13.4, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, WalletProvisioningProtocol, WalletManagerProtocol, FlutterStreamHandler {
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
//        launchWallet(clientId: "000009", walletId: "9012566", settingsProfileId: "piraeus", phoneNumber: "+962123456789")
       // delegate?.onDeviceEligible(result: "onDeviceEligible is called")
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
        print("onConnectionError")
        let walletIdDic: [String: Any] = [
            "status": error.localizedDescription,
        ]
        callBackMethods(event: "onConnectionError", dic: walletIdDic)
    }
    
    func onProvisioningRequired() {
        print("onProvisioningRequired")
      //  provisioner.initialize()
        let provisioningDic: [String: Any] = [
            "status": "On Provisioning Required",
        ]
        callBackMethods(event: "onProvisioningRequired", dic: provisioningDic)
    }
    
    func onCredentialsRequired(reason: CustomerCredentialsRequiredReason) {
        print("onCredentialsRequired")
        print(reason)
        let walletIdDic: [String: Any] = [
            "status": "On Credentials Required",
        ]
        callBackMethods(event: "onProvisioningRequired", dic: walletIdDic)
       // provisioner.initialize()
        //you should not continue, dismiss this Controller and retry connection step
    }
    
    func onConnectionSuccess(wallet: Wallet) {
        print("onConnectionSuccess")
        print(wallet)
        self.wallet = wallet
        print(wallet.getId() ?? "")
       // getCards()
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
    
    public func getCards(){
        print("enter get cards method")
       var cards =  wallet?.getDigitalCards(includeNotProvisionedCards: true)
        print("card list \(cards) end")
        
        callBackMethods(event: "getCards", dic: cards)
    }
    
    func enrollmentDataCard(enrollmentData: String) {
        do {
            try wallet?.enrollDigitalCard(
                enrollmentData: enrollmentData,
                success: {
                    DispatchQueue.main .async {
                        print("Success create card")
                        let enrollCardDic: [String: Any] = [
                            "status": "Success create card",
                        ]
                        self.callBackMethods(event: "enrollCardSuccess", dic: enrollCardDic)
                    }
                }, error: { error in
                    DispatchQueue.main .async {
                        print("Error while create card : \(error)")
                        let enrollCardDic: [String: Any] = [
                            "status": "Error while create card : \(error)",
                        ]
                        self.callBackMethods(event: "enrollCardError", dic: enrollCardDic)
                    }
                })
        }
        catch  {
            print(false, error.localizedDescription)
            let enrollCardDic: [String: Any] = [
                "status": error.localizedDescription,
            ]
            self.callBackMethods(event: "enrollCardCatch", dic: enrollCardDic)
        }
    }
    
        public func getCheckStatus(){
            print("Enter into getStaus method")
            
            let cards = wallet?.getDigitalCards(includeNotProvisionedCards: true)
            print("card list \(cards!)")
            
            let issueIdList: [Int] = []
            
            
           
        
            
//            var cardsArray = [String: DigitalCard]()
//          //  cardsArray = wallet?.getDigitalCards(includeNotProvisionedCards: true)
//            var card = wallet?.getDigitalCard(cardId: "1234ByIssCrdId")
//            var service = card?.getApplePayService()
        //    card?.getStatus()
        }
    
    
    public func cardInApplePay(){
      
        
        let cards = wallet?.getDigitalCards(includeNotProvisionedCards: true)
//         print("card list \(cards)")
        
//            var cardsArray = [String: DigitalCard]()
//          //  cardsArray = wallet?.getDigitalCards(includeNotProvisionedCards: true)
//            var card = wallet?.getDigitalCard(cardId: "1234ByIssCrdId")
//            var service = card?.getApplePayService()
       // card?.getStatus()
    }
    
    
    private func callJavaScript(_ methodName: String, result text: String) {
           let dic: [String: String] = ["eventName": methodName, "response": text]
        eventSink!(dic)
       }
    
    
    private func callBackMethods(event eventName: String, dic: [String: Any]?, strData: String = "") {
           let strData = strData.isEmpty ? (dic == nil ? "" : convertDictionaryToString(dicData: dic!)) : strData
          printData(event: eventName, data: strData)
           //CallBack
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
    var batteryChannel = FlutterMethodChannel()
    
    var provisioner: WalletProvisioning!
    var walletManager: WalletManager!
    var wallet: Wallet?
    var digicalCard: DigitalCardServiceStatus!
    var eventSink: FlutterEventSink?
    
   // FlutterMethodChannel(name: "com.capital.cbt",
    //                                          binaryMessenger: controller.binaryMessenger)
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        provisioner = WalletProvisioning(self)
         walletManager = WalletManager(self)
        
        controller = window?.rootViewController as! FlutterViewController
        batteryChannel = FlutterMethodChannel(name: "com.capital.cbt", binaryMessenger: controller.binaryMessenger)
        
        let instance = AppDelegate()

        let evenChannel = FlutterEventChannel(name: "continueListining", binaryMessenger: controller.binaryMessenger)
        evenChannel.setStreamHandler(self)

            self.registerForFirebaseNotification(application: application)
                
        // ========== Code to implement ==========
       
      //  var walletProvisioningView = WalletProvisioningView()
        
        batteryChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
                   case "initialize":
                       self?.callInitialize()
                
                   case "getWalletLaunch":
                        let dicData = call.arguments as? [String : Any]
                       // print(dicData["clientId"] as? String)
                self?.launchWallet(clientId: dicData!["clientId"] as? String,
                                   walletId: dicData!["walletId"] as! String,
                                   settingsProfileId: dicData?["settingsProfileId"] as? String,
                                   phoneNumber: dicData!["phoneNumber"] as? String)
                
                   case "walletConnect":
                       self?.walletConnect()
                
                   case "checkEligibility":
                       self?.callCheckEligibility()
                
                   case "enrollCard":
                      let dicData = call.arguments as! [String : Any]
                      print("enter in enrollment section \(dicData["enrollmentData"] as! String)")
                      self?.enrollmentDataCard(enrollmentData:dicData["enrollmentData"] as! String)
                
                   case "getAllCards":
                       self?.getCards()
                
                   case "getStatusApplePay":
                       self?.getCheckStatus()
                
                   default:
                       result("iOS " + UIDevice.current.systemVersion)
            }
        })
        AntelopAppDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyCuEgnAmuXOuVXT0lF2_NtqUEelRbH4F_k")
        MobileMessagingPluginApplicationDelegate.install()
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
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

