import 'package:copapp/AppModel/Cart/CartDetail.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Utilities/Sharei.dart';
import 'package:copapp/View/Pages/SendCartPages/SendingCart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class InvoiceController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<CartDetail> cart = [];
  ScreenshotController screenshotController = ScreenshotController();
  ScrollController scrollController = ScrollController();
  List<CartDetail> cartSec = [];
  bool isLoading = true;
  int? orderId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (CartServiceV2().getMyCart() != null &&
        CartServiceV2().getMyCart()!.details != null)
      cart = CartServiceV2().getMyCart()!.details!;
    isLoading = false;
    update();
  }

  void confirm() {
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
      Get.to(() => SendCart());
    });
  }

  double getCartSumPrice() {
    return CartServiceV2.myCart!.orderFinalPrice??0;
  }
}
