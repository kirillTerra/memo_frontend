import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  var audioRecorder = AudioRecorder()

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    let controller = mainFlutterWindow?.contentViewController as! FlutterViewController
    let audioChannel = FlutterMethodChannel(name: "com.example.audio/record",
                                            binaryMessenger: controller.engine.binaryMessenger)
    audioChannel.setMethodCallHandler { [self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      switch call.method {
      case "startRecording":
        audioRecorder.startRecording()
        result(nil)
      case "stopRecording":
        audioRecorder.stopRecording()
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    super.applicationDidFinishLaunching(aNotification)
  }
}
