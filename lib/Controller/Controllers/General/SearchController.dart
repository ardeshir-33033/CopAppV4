import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  String hintText = "";

  List<Part> searchedItems = [];

  Future searchItems(
      {String search = '',
      required GlobalKey<ScaffoldState> scaffoldKey}) async {
    ResponseModel<Part> result = await BalanceServiceV2().getSearch(
        search: search, keywordId: BalanceServiceV2().getSelectedCar()?.id);

    if (result.isSuccess == false) {
      result.showMessage();
    } else {
      searchedItems = result.data;
      update(['item']);
    }
  }

  textfieldTapped() {
    hintText = "";
    update(['text']);
  }
}
