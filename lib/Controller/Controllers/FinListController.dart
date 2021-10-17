import 'package:copapp/Model/FilterResponseModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class FinListController extends GetxController{
    List<double> points = [];
  NumberFormat nf = NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  setPoints(  List<FilterResponseModel>? items) {
    for (int i = 0; i < items!.length; i++) {
      points.add(0);
      for (int j = 0; j < items[i].orderDetails!.length; j++) {
        if (items[i].orderDetails![j].product!.score !=
            null) {
          points[i] +=
              items[i].orderDetails![j].product!.score!;
        }
      }
    }
  }


}