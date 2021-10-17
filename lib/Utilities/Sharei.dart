import 'dart:io';
import 'dart:typed_data';

import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Model/OrderHeader.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class Sharei {
  static String? imagePath;
  static bool multiPic = false;

  TakeScreenshot(ScreenshotController screenshotController, int index) async {
    try {
      Uint8List? result = await screenshotController.capture(
          delay: Duration(milliseconds: 10), pixelRatio: 2.0);
      imagePath = (await getApplicationDocumentsDirectory()).path;
      File file = File('$imagePath/screenshot$index.png');

      file.writeAsBytes(result!);
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
    }
  }

  File getScreenShot(int index) {
    return File('$imagePath/screenshot$index.png');
  }

  setMultiPic(bool val) {
    multiPic = val;
  }

  getMultiPic() {
    return multiPic;
  }

  ShareScreenShot(String userName) async {
    await Share.shareFiles(['$imagePath/screenshot.png'],
        subject: "اپلیکیشن کوپ اپ",
        text: "برای کاربر:" +
            userName +
            "\n" +
            "فروشگاه اینترنتی قطعات یدکی ایسوزو https://copapp.dinavision.org");
  }

  sharePartScreenshot(
      ScreenshotController screenshotController, Part part) async {
    try {
      var result = await screenshotController.capture(
          delay: Duration(milliseconds: 10), pixelRatio: 2.0);

      final directory = (await getApplicationDocumentsDirectory()).path;

      File file = File('$directory/screenshot.png');

      file.writeAsBytes(result!);

      String content = "*برند های کالا:*\n";

      part.products!.forEach((element) {
        if (element.productInfosPrice! > 0.0)
          content +=
              '*•* ${element.productsName} - ${element.brandsName} - ${element.country} - ${element.productInfosPrice} تومان\n\n';
      });

      await Share.shareFiles(['$directory/screenshot.png'],
          subject: '${part.name} ${part.partNumber}', text: content);
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
    }
  }

  shareOrderScreenshot(
      ScreenshotController screenshotController, OrderHeader order) async {
    try {
      var result = await screenshotController.capture(
          delay: Duration(milliseconds: 10), pixelRatio: 2.0);

      final directory = (await getApplicationDocumentsDirectory()).path;

      File file = File('$directory/screenshot.png');

      file.writeAsBytes(result!);

      String content = "جزئیات فاکتور \n";
      content += "وضعیت : ${order.orderStatus?.description} \n";
      content += "مبلغ کل : ${order.finalPrice} \n";

      order.orderDetails!.forEach((element) {
        content +=
            '${element.product?.productsName} - ${element.quantity} ${element.product!.unitsName} - مبلغ کل : ${element.finalPrice}\n';
      });

      await Share.shareFiles(['$directory/screenshot.png'],
          subject: '${order.code} ${order.orderStatus?.description}',
          text: content);
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
    }
  }
}
