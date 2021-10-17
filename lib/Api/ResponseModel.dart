import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponseModel<T> {
  bool isSuccess;
  String? statusCode;
  String message;
  dynamic data;

  ResponseModel({
    this.isSuccess = false,
    this.statusCode,
    this.message = "",
    this.data,
  });

  ResponseModel fromJson<T>(dynamic jsn) {
    this.statusCode = jsn["statusCode"].toString();
    this.data = jsn["data"];
    this.isSuccess = jsn["isSuccess"];
    this.message = jsn["message"].toString();

    return this;
  }

  ShowMessage(){
    Get.showSnackbar(GetBar(
      titleText: Text(
        this.isSuccess ? "عملیات موفق" : "عملیات ناموفق",
        style: TextStyle(
          fontSize: CBase().getTextfontSizeByScreen(),
          fontWeight: FontWeight.bold,
          color: this.isSuccess ? CBase().successColor : CBase().basePrimaryColor,
        ),
      ),
      messageText: Text(
        this.message,
        style: TextStyle(
          color: Colors.white,
          fontSize: CBase().getTextfontSizeByScreen(),
        ),
      ),
      duration: Duration(seconds: 2),
      snackStyle: SnackStyle.GROUNDED,
    ));
  }
}
