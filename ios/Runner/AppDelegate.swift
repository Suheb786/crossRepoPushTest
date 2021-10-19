import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCPizDLZPZ1Q1aAj4noRQyrdXZyE2ZS6FI")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
