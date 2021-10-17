import 'package:copapp/AppModel/Home/Car.dart';
import 'package:copapp/AppModel/Home/Category.dart';
import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/AppModel/MultiBalance/SubCategory.dart';
import 'package:copapp/Model/Balance/Filter.dart';
import 'package:copapp/Model/Balance/ShowCategoryModel.dart';
import 'package:flutter/material.dart';

import 'BalanceService.dart';

class BalanceExtensions {
  static Car? selectedCar;
  static Category? selectedCategory;
  static List<Category>? selectedSubCategories;
  static Category? formerCategory;
  static List<Part> selectedParts = [];
  static List<Filter> filters = [];
  List<SubCategory> subCategories = [];

  setSelectedCar(Car car) {
    selectedCar = car;
  }

  setSelectedSubCategories(List<Category> cats) {
    selectedSubCategories = cats;
  }

  setFormerCategory(bool del) {
    if (del == true) {
      formerCategory = getSelectedCategory();
    } else {
      formerCategory = null;
    }
  }

  Category? getFormerCategory() {
    return formerCategory;
  }

  setSelectedCategory(Category? cat) {
    selectedCategory = cat;
  }

  Car? getSelectedCar() {
    return selectedCar;
  }

  Category? getSelectedCategory() {
    return selectedCategory;
  }

  List<Filter> getFilter() {
    return filters;
  }

  int filterLength() {
    return filters.length;
  }

  setFilter(List<Filter> filter) {
    filters = filter;
  }

  bool haveSelectedCar(int id) {
    if (selectedCar != null && selectedCar!.id == id) {
      return true;
    }

    return false;
  }

  List<Category>? getSelectedSubCategory() {
    return selectedSubCategories;
  }

  bool selectedPart(int? id) {
    if (selectedParts.length != 0) {
      for (Part element in selectedParts) {
        if (element.id == id) {
          return true;
        }
      }
    }
    return false;
  }

  selectPart(Part select) {
    selectedParts.add(select);
  }

  removePart(int? remove) {
    int i = selectedParts.indexWhere((element) => element.id == remove);
    selectedParts.removeAt(i);
  }

  List<Part> getSelectedPart() {
    return selectedParts;
  }

  void setSelectedPart(List<Part> part) {
    selectedParts = part;
  }

  int getSelectedPartLength() {
    return selectedParts.length;
  }

  clearSelectedPart() {
    selectedParts.clear();
  }

  Future<List<Part>?> productsToWidgets(
      int? filterId, GlobalKey<ScaffoldState> _scaffoldKey) async {
    var selectedBalances = await BalanceServiceV2().getBalanceData(
        BalanceServiceV2().getSelectedCategory()?.id,
        // 233,
        BalanceExtensions().getSelectedCar()?.id, //7
        // BalanceServiceV2().getSelectedCar()?.id,
        filterId: filterId);

    if (selectedBalances.isSuccess) {
      filters = (selectedBalances.data as RShowCategoryModel).filters!;
      subCategories =
          (selectedBalances.data as RShowCategoryModel).subCategories!;

      // selectedParts = (selectedBalances.data as ShowCategoryModel).parts!;

      return (selectedBalances.data as RShowCategoryModel).parts!;
    } else {
      selectedBalances.showMessage();
      return [];
    }
  }

  List<SubCategory> getSubCategoryList() {
    return subCategories;
  }
}
