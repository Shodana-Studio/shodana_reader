import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let channel = FlutterMethodChannel(name: "app.shodana.shodanaReader/Reader", binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        // Note: this method is invoked on the UI thread.
        guard call.method == "getBooks" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self.receiveBooks(result: result)
    })
    
    GeneratedPluginRegistrant.register(with: self)
    
    weak var registrar = self.registrar(forPlugin: "plugin-name")
    
    let factory = FLNativeViewFactory(messenger: registrar!.messenger())
    self.registrar(forPlugin: "<plugin-name>")!.register(
        factory,
        withId: "<platform-view-type>"
    )
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
  private func receiveBooks(result: FlutterResult) {
    // TODO: Figure out how to return the books from Drag and Drop
//    let receivedBooks: [UIDragItem] = FLNativeView.getBooks()
    
    
  }
}
