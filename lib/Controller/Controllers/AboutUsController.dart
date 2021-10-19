import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsController extends GetxController {
  bool startAnimation = false;
  ScrollController? scrollController;
  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    Future.delayed(
        Duration(
          milliseconds: 1000,
        ), () {
      startAnimation = true;
      update();
    }).then((value) {
      Future.delayed(Duration(milliseconds: 4000), () {
        scrollController!.animateTo(scrollController!.position.maxScrollExtent,
            duration: Duration(seconds: 80), curve: Curves.linear);
      });
    });
  }
}
