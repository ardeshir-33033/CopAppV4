import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppBrowser extends InAppBrowser {
  static MyInAppBrowser myInAppBrowser1 = MyInAppBrowser();

  setBrowser(MyInAppBrowser browser) {
    myInAppBrowser1 = browser;
  }

  @override
  Future onBrowserCreated() async {
    print("\n\nBrowser Created!\n\n");
  }

  @override
  void onLoadStart(Uri? url) async {
    if (url!.query == "returning=1") {
      myInAppBrowser1.close();
    }
  }

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