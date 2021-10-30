import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Controllers/InvoiceController.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Utilities/Sharei.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:url_launcher/url_launcher.dart';

class SendCartController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController controller1 = TextEditingController();

  TextEditingController controller2 = TextEditingController();

  TextEditingController controller3 = TextEditingController();

  TextEditingController controller4 = TextEditingController();

  TextEditingController controllerplate1 = TextEditingController();
  TextEditingController controllerplate2 = TextEditingController();
  TextEditingController controllerplate3 = TextEditingController();
  TextEditingController controllerplate4 = TextEditingController();
  bool isLoading = false;
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
            try {
              await launch(Uri.parse(_url).toString());
            } on Exception catch (e) {
              Snacki().GETSnackBar(false, e.toString());
            } finally {
              isLoading = false;
              update();
            }
          }
        }
      } on Exception catch (e) {
        Snacki().GETSnackBar(false, e.toString());
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
    InvoiceController invoiceController = Get.find();

    ResponseModel res;
    if (invoiceController.orderId == null) {
      res = (await CartServiceV2().payment(1))!;
    } else {
      res =
          (await OrderServiceV2().zarrinPayOrder(invoiceController.orderId!))!;
    }
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
