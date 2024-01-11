import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Provide google maps API key to use google maps 
    GMServices.provideAPIKey("AIzaSyBP5JaLlEXfmSH6T9Fte51q7PVgum87qAI")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
