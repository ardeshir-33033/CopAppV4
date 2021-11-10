import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Widget> items = [];
  List<Part> parts = [];
  String? partnumber;
  // bool isLoadingJoin = false;
  List<bool> allJoinVis = [];
  bool isLoading = false;

  setPartNumber(String? partNum) {
    this.partnumber = partNum;
  }

  void getPart() async {
    try {
      allJoinVis = [];
      parts = [];
      isLoading = true;
      update(['loading']);
      await BalanceServiceV2()
          .getBalanceDataSearch(search: partnumber)
          .then((value) {
        if (value.isSuccess) {
          parts = value.data;
          parts.forEach((element) => allJoinVis.add(false));
        } else {
          value.showMessage();
        }
      });
    } catch (e) {
      Snacki().GETSnackBar(false, 'خطایی در ارتباط با سرور بوجود آمده است');
    } finally {
      isLoading = false;
      update(['loading']);
    }
  }

  // Future add(Product? bal) async {
  //   int newQTY = CartServiceV2().cartProductQTY(bal!.id);

  //   if (bal.multipleQTY! <= 0)
  //     newQTY += 1;
  //   else
  //     newQTY += bal.multipleQTY!;

  //   var result = await CartServiceV2().UpdateProduct(bal.id, newQTY);

  //   if (!result.isSuccess) result.ShowMessage(scaffoldKey);

  //   // if (widget.onTapCallback != null) {
  //   //   widget.onTapCallback("tap");
  //   // }
  // }

  // Future addToCart(Product? bal) async {
  //   if (bal!.productInfos!.first.price != 0) {
  //     if (CartServiceV2().cartProductQTY(bal.id) <= 0) {
  //       var result = await CartServiceV2().AddProduct(bal.id, 1);

  //       if (!result.isSuccess) result.ShowMessage(scaffoldKey);

  //       // if (widget.onTapCallback != null) {
  //       //   widget.onTapCallback("tap");
  //       // }
  //     }
  //   } else {
  //     Snacki().ShowMessage(
  //         isSuccess: false,
  //         message: "امکان خرید این محصول به دلیل فی صفر نیست.",
  //         scaffold: scaffoldKey);
  //   }
  // }

  // Future remove(Product? bal) async {
  //   var newQty = CartServiceV2().cartProductQTY(bal!.id);

  //   if (bal.multipleQTY! <= 0)
  //     newQty -= 1;
  //   else
  //     newQty -= bal.multipleQTY!;

  //   if (newQty <= 0) {
  //     var result = await CartServiceV2().DeleteProduct(bal.id);

  //     if (!result.isSuccess) result.ShowMessage(scaffoldKey);
  //   } else {
  //     var result = await CartServiceV2().UpdateProduct(bal.id, newQty);

  //     if (!result.isSuccess) result.ShowMessage(scaffoldKey);
  //   }

  //   // if (widget.onTapCallback != null) {
  //   //   widget.onTapCallback("tap");
  //   // }
  // }
}
