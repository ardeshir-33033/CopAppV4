import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'General/ScoreService.dart';

class AccessPointController extends GetxController {
  int type = 4;

  ScoreService scoreServiceController = Get.find();
  TextEditingController textEditingController1 = new TextEditingController(),
      textEditingController2 = new TextEditingController(),
      textEditingController3 = new TextEditingController(),
      textEditingController4 = new TextEditingController();
  bool isLoading = false;

  Future checkPass() async {
    ResponseModel model = await ProfileServiceV2().checkSecondPassword("xxxx");
    if (model.statusCode == "listEmpty") {
      ////هیچ رمزی نیس
      type = 3;
    } else if (model.statusCode == "notFound") {
      ////رمز غلط
      type = 2;
    } else if (model.statusCode == "500") {
      Snacki().GETSnackBar(false, model.message);
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkPass().then((value) {
      update();
    });
  }

  void enter(int i) {
    if (textEditingController1.text.isEmpty)
      textEditingController1.text = i.toString();
    else if (textEditingController2.text.isEmpty)
      textEditingController2.text = i.toString();
    else if (textEditingController3.text.isEmpty)
      textEditingController3.text = i.toString();
    else if (textEditingController4.text.isEmpty)
      textEditingController4.text = i.toString();
    update();
  }

  void clearAll() {
    textEditingController1.text = '';
    textEditingController2.text = '';
    textEditingController3.text = '';
    textEditingController4.text = '';
    update();
  }

  void submit() async {
    if (!isLoading) {
      if (textEditingController1.text.isEmpty ||
          textEditingController2.text.isEmpty ||
          textEditingController3.text.isEmpty ||
          textEditingController4.text.isEmpty) {
        Snacki().GETSnackBar(false, 'رمزعبور باید 4 رقمی باشد.');
      } else {
        isLoading = true;
        update();
        if (type == 2) {
          ResponseModel res = await ProfileServiceV2().checkSecondPassword(
              "${textEditingController1.text + textEditingController2.text + textEditingController3.text + textEditingController4.text}");
          if (res.isSuccess == true) {
            scoreServiceController
                .setShowScore(!scoreServiceController.getShowScore());

            isLoading = false;
            update();
            Snacki().GETSnackBar(
                true,
                scoreServiceController.getShowScore()
                    ? 'امتیازات قابل مشاهده شدند.'
                    : 'امتیازات غیرقابل مشاهده شدند.');

            Future.delayed(Duration(seconds: 2), () {
              Get.back();
            });
          } else {
            isLoading = false;
            update();
            Snacki().GETSnackBar(false, res.message);
          }
        }
        if (type == 3) {
          ResponseModel res = await ProfileServiceV2().setSecondPassword(
              "${textEditingController1.text + textEditingController2.text + textEditingController3.text + textEditingController4.text}");
          if (res.isSuccess == true) {
            scoreServiceController
                .setShowScore(!scoreServiceController.getShowScore());

            isLoading = false;
            update();
            Snacki().GETSnackBar(true, 'عملیات موفقیت آمیز بود');
            Future.delayed(Duration(seconds: 2), () {
              Get.back();
            });
          } else {
            isLoading = false;
            update();
            res.showMessage();

            // res.ShowMessage(scaffoldKey);
          }
        }
        if (type == 1) {
          ResponseModel res = await ProfileServiceV2().setSecondPassword(
              "${textEditingController1.text + textEditingController2.text + textEditingController3.text + textEditingController4.text}");
          if (res.isSuccess == true) {
            scoreServiceController
                .setShowScore(!scoreServiceController.getShowScore());

            isLoading = false;
            update();
            Snacki().GETSnackBar(true, 'عملیات موفقیت آمیز بود');
            Future.delayed(Duration(seconds: 2), () {
              Get.back();
            });
          } else {
            isLoading = false;
            update();
            res.showMessage();
          }
        }
      }
    }
  }

  void newPass(int res) async {
    if (res == 1) {
      type = 1;
      clearAll();
      update();
    }
  }
}
