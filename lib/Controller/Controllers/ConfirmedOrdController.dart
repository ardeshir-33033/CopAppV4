import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmedOrdController extends GetxController {
  ResponseModel<List<OrderHeader>> confirmedResponse =
      ResponseModel<List<OrderHeader>>();
  List<OrderHeader>? confirmedOrders;

  Future getPendingOrders() async {
    confirmedResponse = await OrderServiceV2().GetConfirmedPayOrders();
    if (!confirmedResponse.isSuccess) {
      confirmedResponse.ShowMessage();
      Future.delayed(Duration(seconds: 2), () {
          Get.back();
        });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPendingOrders().then((value) {
      confirmedOrders = [];

      if (confirmedResponse.data != null)
        confirmedOrders = confirmedResponse.data;
      update();
    });
  }
}
