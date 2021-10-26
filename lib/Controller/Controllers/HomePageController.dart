import 'package:copapp/AppModel/Home/Car.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
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
  List<Car> cars = [];

  @override
  void onInit() {
    super.onInit();
    BalanceServiceV2().getHomeData().then((v) {
      if (v.isSuccess) {
        isLoading = false;
        cars = BalanceServiceV2.myHomeData!.cars!;
        cars.forEach((v) {
          v.name = v.name!.toPersianDigit();
        });
        update(['selectCar']);
      } else {
        v.showMessage();
      }
    });
  }

  Future<bool> backPress() async {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      Get.back();
    } else {
      if (carNotSelected)
        await Snacki().showExitSnack(
          scaffoldKey,
        );
      else {
        BalanceExtensions()
            .setSelectedCar(Car(id: 0, engName: "همه", name: "All"));
        carNotSelected = true;
        isuzuApear = true;
        update(['animate']);
        Future.delayed(Duration(milliseconds: 400), () {
          isuzuApear = true;
          // update([3]);
        });
      }
    }
    return false;
  }

  onCancelCar() {
    BalanceExtensions().setSelectedCar(Car(id: 0, engName: "همه", name: "All"));
    carNotSelected = true;
    update(['animate']);

    Future.delayed(Duration(milliseconds: 400), () {
      isuzuApear = true;
      update(['animate']);
    });
    titleHeight = 35;
    update(['animate']);
  }

  onSelectCar(int i) {
    selectedYear = years[i].toPersianDigit();
    BalanceServiceV2().setSelectedCar(cars[i]);

    carNotSelected = false;
    titleHeight = 0.0;
    isuzuApear = false;
    update(['animate']);

    Future.delayed(Duration(milliseconds: 400), () {
      carNotSelected = false;
      update(['animate']);
    });
  }
}
