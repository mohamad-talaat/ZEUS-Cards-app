import Flutter
import UIKit
import Firebase
import FirebaseCore
import FirebaseMessaging
// import firebase_core
// import firebase_messaging
 @UIApplicationMain

// class AppDelegate: UIResponder, UIApplicationDelegate {
//   func application(_ application: UIApplication,
//                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//     return true
//   }
// }


 @objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {     
    FirebaseApp.configure()
     // Add the code to prevent screenshots
//  if let window = self.window {
//  window.isSecure = true
//  }
  GeneratedPluginRegistrant.register(with: self)


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}