import UIKit
import Flutter
import GoogleMaps
import MobileMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCuEgnAmuXOuVXT0lF2_NtqUEelRbH4F_k")
    MobileMessagingPluginApplicationDelegate.install()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
