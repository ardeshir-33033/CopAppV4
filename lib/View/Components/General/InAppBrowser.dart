import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppBrowser extends InAppBrowser {
  static MyInAppBrowser MyInAppBrowser1 = MyInAppBrowser();

  setbrowser(MyInAppBrowser browser) {
    MyInAppBrowser1 = browser;
  }

  @override
  Future onBrowserCreated() async {
    print("\n\nBrowser Created!\n\n");
  }

  @override
  void onLoadStart(Uri? url) async {
    if (url!.query == "returning=1") {
      MyInAppBrowser1.close();
      // Navigator.pop( context);
      // return true;
    }
  }

  // @override
  // Future onLoadStop(Uri? url) async {
  //   print("\n\nStopped $url\n\n");
  // }

  // @override
  // void onLoadError(Uri? url, int code, String message) {
  //   print("Can't load $url.. Error: $message");
  // }

  // @override
  // void onProgressChanged(int progress) {
  //   print("Progress: $progress");
  // }

  // @override
  // void onExit() {
  //   print("\n\nBrowser closed!\n\n");
  // }

  // @override
  // Future<ShouldOverrideUrlLoadingAction> shouldOverrideUrlLoading(
  //     ShouldOverrideUrlLoadingRequest shouldOverrideUrlLoadingRequest) async {
  //   print("\n\nOverride ${shouldOverrideUrlLoadingRequest.url}\n\n");
  //   return ShouldOverrideUrlLoadingAction.ALLOW;
  // }

  @override
  void onLoadResource(LoadedResource response) {
    print("Started at: " +
        response.startTime.toString() +
        "ms ---> duration: " +
        response.duration.toString() +
        "ms " +
        response.url!.path);
  }

  @override
  void onConsoleMessage(ConsoleMessage consoleMessage) {
    print("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }
}