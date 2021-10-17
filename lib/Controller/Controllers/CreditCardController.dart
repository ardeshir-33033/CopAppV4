import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Model/CardModel.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditCardController extends GetxController {
  bool isLoading = true, isSubmiting = false;
  TextEditingController cardNumberController = new TextEditingController();

  TextEditingController nameController = new TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ProfileServiceV2().getPersonalInformation().then((value) {
      if (!value.isSuccess) {
        value.showMessage();
      } else {
        cardNumberController.text = ProfileServiceV2.profile.bankCarNo ?? '';
        isLoading = false;
        update();
      }
    });
  }

  void submit() async {
    if (nameController.text.isNotEmpty &&
        cardNumberController.text.isNotEmpty &&
        cardNumberController.text.length == 19) {
      isSubmiting = true;
      update();
      CardModel card = CardModel(
        cartNo: cardNumberController.text,
      );

      await ProfileServiceV2().setBankCardNumber(card).then((value) {
        isSubmiting = false;
        update();
        value.showMessage();
        if (value.isSuccess) {
          Future.delayed(Duration(seconds: 2), () {
            Get.back();
          });
        }
      });
    } else {
      Snacki().GETSnackBar(false, 'لطفا فیلد ها را کامل کنید');
    }
  }
}
