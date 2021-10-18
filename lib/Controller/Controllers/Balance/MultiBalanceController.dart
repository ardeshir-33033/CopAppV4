import 'package:copapp/AppModel/Balance/FilterBox.dart';
import 'package:copapp/AppModel/Home/Category.dart';
import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/AppModel/MultiBalance/SubCategory.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiBalanceController extends GetxController {
  static MultiBalanceController instance = Get.find();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Part>? result;
  List<SubCategory>? subCategories = [];
  List<Widget>? products;

  void startFunc() {
    BalanceExtensions().clearSelectedPart();
    getBalance();
  }

  getBalance({bool isSubCat = false}) async {
    await getBalanceData(isSubCat: isSubCat).then((value) async {
      result = value;
      update([2]);
    });
    await getFilters().then((value) => update([1]));
  }

  Future getFilters({bool isSubCat = false}) async {
    var response = await BalanceServiceV2().getBalanceFilterBox(
      isSubCat
          ? BalanceExtensions().getSelectedCategory()?.id
          : BalanceServiceV2().getSelectedCategory()?.id,
      BalanceExtensions().getSelectedCar()?.id,
    );
    if (response.isSuccess) {
      subCategories = (response.data as FilterBox).subCategories;
      BalanceExtensions().setFilter((response.data as FilterBox).filters!);
    }
  }

  Future<List<Part>?> getBalanceData({bool isSubCat = false}) async {
    var selectedBalances = await BalanceServiceV2().getBalanceData(
      isSubCat
          ? BalanceExtensions().getSelectedCategory()!.id
          : BalanceServiceV2().getSelectedCategory()?.id,
      // 233,
      BalanceExtensions().getSelectedCar()?.id,
      // BalanceServiceV2().getSelectedCar()?.id,
    );

    if (selectedBalances.isSuccess) {
      return (selectedBalances.data);
    } else {
      selectedBalances.showMessage();
      return [];
    }
  }

  subCategorySelect(int index) {
    if (BalanceExtensions().getFormerCategory() == null) {
      BalanceExtensions().setFormerCategory(true);
    }
    result = null;
    update([2]);
    BalanceExtensions()
        .setSelectedCategory(Category(name: "", id: subCategories![index].id));
    update([1]);
    getBalanceData(isSubCat: true).then((value) {
      result = value;
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
        getBalance(isSubCat: true);
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
