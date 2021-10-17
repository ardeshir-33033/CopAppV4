import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:copapp/Controller/Service/InquiryService.dart';
import 'package:copapp/Model/Keyword.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class HomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool carNotSelected = true, isuzuApear = true;
  double titleHeight = 35;
  String? selectedYear;
  bool isLoading = true;
  List<String> years = ['1400-1396', '1396-1388', '1396-1386', '1400-1396'];
  List<Keyword> cars = [];

  @override
  void onInit() {
    BalanceServiceV2().GetShowAllParents().then((v) {
      if(v.isSuccess){
        isLoading = false;
        cars = BalanceServiceV2.myHomeData!.keywords!;
        cars.forEach((v) {
          v.name = v.name!.toPersianDigit();
        });
        update(['2']);
      }else{
        v.ShowMessage();
      }
    });
  }

  Future<bool> backPress() async {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      Get.back();
    } else {
      if (carNotSelected)
        await Snacki().ShowExitSnack(
          scaffoldKey,
        );
      else {
        BalanceExtensions()
            .setSelectedCar(Keyword(id: 0, keyWord: "همه", name: "All"));
        carNotSelected = true;
        isuzuApear = true;
        update(['1']);
        Future.delayed(Duration(milliseconds: 400), () {
          isuzuApear = true;
          update([3]);
        });
      }
    }
    return false;
  }

  onCancelCar() {
    BalanceExtensions()
        .setSelectedCar(Keyword(id: 0, keyWord: "همه", name: "All"));
    carNotSelected = true;
    update(['1']);

    Future.delayed(Duration(milliseconds: 400), () {
      isuzuApear = true;
      update(['1']);
    });
    titleHeight = 35;
    update(['1']);
  }

  onSelectCar(int i) {
    selectedYear = years[i].toPersianDigit();
    BalanceServiceV2().setSelectedCar(cars[i]);

    carNotSelected = false;
    titleHeight = 0.0;
    isuzuApear = false;
    update(['1']);

    Future.delayed(Duration(milliseconds: 400), () {
      carNotSelected = false;
      update(['1']);
    });
  }
}
