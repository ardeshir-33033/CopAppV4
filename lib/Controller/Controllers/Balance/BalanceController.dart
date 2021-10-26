import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalanceController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoadingfilter = true;
  List<Widget> products = [];
  List<Part>? items;

  init(List<Part> part) {
    items = part;
    isLoadingfilter = false;
    update(["Load"]);
  }

  List<Part>? getItems() {
    return items;
  }

  balanceFilter(
      {required GlobalKey<ScaffoldState> scaffoldKey, int? filterId}) async {
    isLoadingfilter = true;
    update([2]);
    update(["Load"]);

    items =
        (await BalanceServiceV2().getBalanceData(
        BalanceServiceV2().getSelectedCategory()?.id,
        // 233,
        BalanceExtensions().getSelectedCar()?.id, //7
        // BalanceServiceV2().getSelectedCar()?.id,
        filterId: filterId)).data;
    List<Part> temp = [];
    if (BalanceExtensions.selectedParts.length > 0) {
      for (int i = 0; i < items!.length; i++) {
        for (int j = 0; j < BalanceExtensions.selectedParts.length; j++) {
          if (items![i].id == BalanceExtensions.selectedParts[j].id) {
            temp.add(items![i]);
          }
        }
      }
      items = temp;
    }
    isLoadingfilter = false;
    update(["Load"]);
  }
}
