import 'dart:io';

import 'package:copapp/AppModel/Home/Category.dart';
import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/AppModel/MultiBalance/SubCategory.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:copapp/Model/Balance/ShowCategoryModel.dart';
import 'package:copapp/Model/Category.dart';
import 'package:copapp/Model/Part.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiBalanceController extends GetxController {
  static MultiBalanceController instance = Get.find();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int? sortId;
  List<Part>? result;
  List<SubCategory>? subCategories = [];
  List<Widget>? products;


  void startFunc() {
    BalanceExtensions().clearSelectedPart();
    getBalance();
  }


  getBalance({bool isFilter = false}) async {
    productsToWidgets(isFilter: isFilter).then((value) {
      result = value;
      update([2, 1]);
    });
  }

  Future<List<Part>?> productsToWidgets({bool isFilter = false}) async {
    var selectedBalances = await BalanceServiceV2().GetShowCategory(
        BalanceServiceV2().getSelectedCategory()?.id,
        // 233,
        BalanceExtensions().getSelectedCar()?.id,
        // BalanceServiceV2().getSelectedCar()?.id,
        null,
        null,
        sortId);

    if (selectedBalances.isSuccess) {
      BalanceExtensions()
          .setFilter((selectedBalances.data as RShowCategoryModel).filters!);
      if (!isFilter)
        subCategories =
            (selectedBalances.data as RShowCategoryModel).subCategories!;

      return (selectedBalances.data as RShowCategoryModel).parts;
    } else {
      selectedBalances.ShowMessage();
      return [];
    }

  }

  subCategorySelect(int index){
    if (BalanceExtensions()
        .getFormerCategory() ==
        null) {
      BalanceExtensions()
          .setFormerCategory(true);
    }
    result = null;
    update([2]);
    BalanceExtensions().setSelectedCategory(
        Category(
            name: "",
            id: subCategories![index].id));
    update([1]);
    getBalance(isFilter: true)
        .then((value) {
      update([2]);
    });
  }

  backPress() async {

      if (BalanceExtensions().getFormerCategory() == null) {
        result = null;
        subCategories = [];
        BalanceExtensions().clearSelectedPart();
        Get.back();
      } else {
        if (BalanceExtensions().getSelectedCategory()!.id ==
            BalanceExtensions().getFormerCategory()!.id) {
          result = null;
          subCategories = [];

          BalanceExtensions().clearSelectedPart();
          Get.back();
        } else {
          result = null;
          update([2]);
          BalanceExtensions()
              .setSelectedCategory(BalanceExtensions().getFormerCategory());
          update([1]);
          // getBalance().then((value) {
          //   setState(() {});
          // });
          getBalance(isFilter: true);
        }
      }

  }

  selectPart(Part part) {
    BalanceExtensions().selectedPart(part.id) == true
        ? BalanceExtensions().removePart(part.id)
        : BalanceExtensions().selectPart(part);

    update([3]);
  }
}
