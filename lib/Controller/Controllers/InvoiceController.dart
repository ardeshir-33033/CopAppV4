import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Model/CartDetail.dart';
import 'package:copapp/Model/CartHeader.dart';
import 'package:copapp/Utilities/Sharei.dart';
import 'package:copapp/View/Pages/SendCartPages/SendingCart.dart';
import 'package:easy_localization/easy_localization.dart';
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
    if (CartServiceV2().getMyCart()!.cart != null &&
        CartServiceV2().getMyCart()!.cart!.cartDetails != null)
      cart = CartServiceV2().getMyCart()!.cart!.cartDetails!;
    isLoading = false;
    update();
  }

  void confirm() {
    Sharei().TakeScreenshot(screenshotController, 1);
    if (scrollController.position.pixels !=
        scrollController.position.maxScrollExtent) {
      scrollController
          .animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500), curve: Curves.linear)
          .then((value) {
        Sharei().TakeScreenshot(screenshotController, 2);
      });
      Sharei().setMultiPic(true);
    }
    Future.delayed(Duration(milliseconds: 600)).then((value) {
      Get.to(() => SendCart());
    });
  }

  double getCartSumPrice() {
    double sumPrice = 0.0;
    cart.forEach((element) {
      sumPrice += element.finalPrice!;
    });
    return sumPrice;
  }
}
