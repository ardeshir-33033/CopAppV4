import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Model/Part.dart';
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
    update([1]);
  }

  List<Part>? getItems() {
    return items;
  }

  BalanceFilter(
      {required GlobalKey<ScaffoldState> scaffoldKey, int? filterId}) async {
    isLoadingfilter = true;
    update([2]);
    update([1]);

    items =
        (await BalanceExtensions().productsToWidgets(filterId, scaffoldKey))!;
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
    update([1]);
  }
}
