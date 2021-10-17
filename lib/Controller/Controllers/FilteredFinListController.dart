import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/FilterResponseModel.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilteredFinListController extends GetxController {
  NumberFormat nf = NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );
  ResponseModel<FilterResponseModel>? model;
  List<FilterResponseModel> items = [];
  List<OrderHeader> commissions = [];
  bool? isLoading;
  List<double> points = [];
  List<OrderHeader>? allCommissions;
  int? id;
  dynamic selected;

  doInits() {
    isLoading = true;
    update();
    getFinances().then((v) {
      isLoading = false;
      items = model!.data;
      setCommisions();
      setPoints();
      update();
    });
  }

  void setCommisions() {
    commissions = [];
    for (int i = 0; i < items.length; i++) {
      bool found = false;
      for (int j = 0; j < allCommissions!.length; j++) {
        if (items[i].code == allCommissions![j].code) {
          commissions.add(allCommissions![j]);
          found = true;
        }
      }
      if (!found) {
        commissions.add(OrderHeader(code: items[i].code));
      }
    }
  }

  getFinances() async {
    Map<String, dynamic> data = {};
    if (id == 1) {
      data = {'customer': selected};
    } else if (id == 2) {
      data = {'productId': selected};
    }
    model = await OrderServiceV2().PostOrdersFilter(data);
            if (!model!.isSuccess) {
      model!.ShowMessage();
    }
  }

  setPoints() {
    for (int i = 0; i < items.length; i++) {
      points.add(0);
      for (int j = 0; j < items[i].orderDetails!.length; j++) {
        if (items[i].orderDetails![j].product!.productInfos![0].score != null) {
          points[i] +=
              items[i].orderDetails![j].product!.productInfos![0].score!;
        }
      }
    }
  }

  void setInits(int? _id, List<OrderHeader>? _allCommissions, _selected) {
    allCommissions = _allCommissions;
    id = _id;
    selected = _selected;
    doInits();
  }
}
