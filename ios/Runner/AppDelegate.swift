import UIKit
import Flutter
import GoogleMaps
import GooglePlaces




@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCMMH4Vzw-Rplb164RMVr8vXTNIULLGj4k")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  } 
}
