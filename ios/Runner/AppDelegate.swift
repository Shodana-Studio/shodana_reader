import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//    let controller = window?.rootViewController as! FlutterViewController
//
//    let channel = FlutterMethodChannel(name: "drop", binaryMessenger: controller)
//    channel.setMethodCallHandler({
//        (call: FlutterMethodCall, result: FlutterResult) -> Void in
//    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
