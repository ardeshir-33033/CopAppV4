import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Controllers/ChooseAddController.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Model/Address.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/Utilities/Sharei.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:copapp/View/Pages/OrderPages/PendingOrders/SendingOrder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderInfoController extends GetxController {
  bool isLoading = true;
  OrderHeader? order;
  TextEditingController controller1 = TextEditingController();

  TextEditingController controller2 = TextEditingController();

  TextEditingController controller3 = TextEditingController();

  TextEditingController controller4 = TextEditingController();

  TextEditingController controllerplate1 = TextEditingController();
  TextEditingController controllerplate2 = TextEditingController();
  TextEditingController controllerplate3 = TextEditingController();
  TextEditingController controllerplate4 = TextEditingController();
  TabController? controller;
  int selectedIndex = 0;
  List<Widget> list = [
    Tab(
      child: Container(
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(3, 3),
                  blurRadius: 6)
            ]),
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'پرداخت',
          ),
        ),
      ),
    ),
    Tab(
      child: Container(
        margin: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(3, 3),
                  blurRadius: 6)
            ]),
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'ارسال به مشتری',
          ),
        ),
      ),
    ),
  ];

  ScreenshotController screenshotController = ScreenshotController();
  ScrollController scrollController = ScrollController();
  getOrder(orderId) async {
    try {
      isLoading = true;
      update(['loading']);
      await OrderServiceV2().getOrderInfo(orderId).then((value) {
        if (value.isSuccess)
          order = value.data;
        else
          value.showMessage();
      });
    } catch (e) {
      Snacki().GETSnackBar(false, 'مشکلی در ارتباط با سرور بوجود آمده است');
    } finally {
      isLoading = false;
      update(['loading']);
    }
  }

  void confirmFactor() {
    Sharei().takeScreenshot(screenshotController, 1);
    if (scrollController.position.pixels !=
        scrollController.position.maxScrollExtent) {
      scrollController
          .animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500), curve: Curves.linear)
          .then((value) {
        Sharei().takeScreenshot(screenshotController, 2);
      });
      Sharei().setMultiPic(true);
    }
    Future.delayed(Duration(milliseconds: 600)).then((value) {
      Get.to(() => SendOrder());
    });
  }

  double getCartFinalPrice() {
    double finalPrice = 0.0;
    order!.orderDetails!
        .forEach((element) => finalPrice += element.finalPrice!);
    return finalPrice;
  }

  void confirmSend() async {
    if (controller1.text != "" && controller2.text != "") {
      isLoading = true;
      update();
      try {
        ResponseModel paymentRes = await _payment();

        if (paymentRes.isSuccess) {
          List screenShot = await _uploadScreenShot();
          String num = controller2.text.substring(1).toEnglishDigit();

          if (await canLaunch(
              "https://wa.me/98$num/?text=test-${screenShot.first}")) {
            String _url;
            if (screenShot.length > 1) {
              _url =
                  "https://wa.me/98$num/?text=copapp.ir\nفروشگاه آنلاین قطعات ایسوزو - مشتری گرامی ${controller1.text} \n *•* برای مشاهده فاکتور خود بر روی لینک کلیک کنید:\n ${screenShot[0]}  \n ادامه: \n ${screenShot[1]} \n *•* برای پرداخت فاکتور خود بر روی لینک کلیک کنید: \n ${paymentRes.data ?? ""}";
            } else {
              _url =
                  "https://wa.me/98$num/?text=copapp.ir\nفروشگاه آنلاین قطعات ایسوزو - مشتری گرامی ${controller1.text} \n *•* برای مشاهده فاکتور خود بر روی لینک کلیک کنید:\n ${screenShot[0]}  \n *•* برای پرداخت فاکتور خود بر روی لینک کلیک کنید: \n ${paymentRes.data ?? ""}";
              // _url = "https://wa.me/98${num}/?text=${Uri.parse("copapp.ir\nفروشگاه")}";
            }
            await launch(Uri.parse(_url).toString());

            // try {
            //   await launch(Uri.parse(_url).toString());
            // } on Exception catch (e) {
            //   Snacki().GETSnackBar(false, e.toString());
            // } finally {
            //   isLoading = false;
            //   update();
            // }
          } else {
            isLoading = false;
            update();
            Snacki().GETSnackBar(false, "امکان ارسال به مشتری وجود ندارد.");
          }
        }
      } catch (e) {
        Snacki().GETSnackBar(false,
            "در ارسال به مشتری با مشکل مواجه شد. لطفا دوباره تلاش کنید.");
      } finally {
        isLoading = false;
        update();
      }
    } else {
      Snacki().GETSnackBar(false, "لطفا فیلد های ضروری را پر کنید");
    }

    isLoading = false;
    update();
  }

  Future<ResponseModel> _payment() async {
    ChooseAddressController addressController = Get.find();
    int addressId;
    if (addressController.getSelectedAddress() == null) {
      addressId = -10;
    } else {
      addressId = addressController.getSelectedAddress()!.id!;
    }
    ResponseModel res = (await OrderServiceV2()
        .zarrinPayOrder(order!.id!, addressId: addressId));

    if (!res.isSuccess) {
      res.showMessage();
    }

    return res;
  }

  Future<List> _uploadScreenShot() async {
    List returnedList = [];
    ResponseModel? response = await ProfileServiceV2().uploadScreenShot(1);

    ResponseModel? response2;
    if (Sharei().getMultiPic()) {
      response2 = (await ProfileServiceV2().uploadScreenShot(2))!;
    }

    if (!response!.isSuccess) {
      response.showMessage();
      returnedList.add("خطا در آپلود فاکتور");
    } else {
      returnedList.add(response.data);
    }

    if (Sharei().getMultiPic()) {
      if (!response2!.isSuccess) {
        response2.showMessage();
        returnedList.add(null);
      } else {
        returnedList.add(response2.data);
      }
    }

    return returnedList;
  }
}
