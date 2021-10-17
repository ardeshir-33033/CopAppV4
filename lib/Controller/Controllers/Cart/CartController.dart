import 'package:copapp/Controller/Controllers/General/PointController.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Controller/Service/InquiryService.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    if (CartServiceV2.myCart == null) {
      CartServiceV2().GetCart().then((value) {
        isLoading = false;
        update();
        if(value.isSuccess == false){
          Snacki().GETSnackBar(value.isSuccess, value.message);
        }
      });
    }
  }
}
