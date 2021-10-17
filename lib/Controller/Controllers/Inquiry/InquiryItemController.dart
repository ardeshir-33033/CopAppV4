import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Controllers/Balance/BalanceItemController.dart';
import 'package:copapp/Controller/Service/InquiryService.dart';
import 'package:copapp/Model/Inquiry/InquiryCart.dart';
import 'package:copapp/Model/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InquiryItemController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<int> add(Product product) async {
    int multipleQty = (product.multipleQTY == null || product.multipleQTY! <= 0
        ? 1
        : product.multipleQTY!);
    int newQty = 0;
    await InquiryService()
        .AddInquiryProduct(product.id!, multipleQty)
        .then((value) {
      if (value.isSuccess) {
        InquiryCart t = value.data;
        newQty = t.inquiryDetails
            .firstWhere((element) => element.productId == product.id)
            .qty!;
      } else {
        value.ShowMessage();
      }
    });
    return newQty;
  }

  Future<int> upDate(Product product, bool isAdding) async {
    int qty = 0;
    int newQty = InquiryService().inquiryProductQTY(product.id);
    int multipleQty = (product.multipleQTY == null || product.multipleQTY! <= 0
        ? 1
        : product.multipleQTY!);
    if (isAdding) {
      //is adding to item quantity
      qty = newQty + multipleQty;
      await InquiryService().UpdateProduct(product.id!, qty).then((value) {
        if (value.isSuccess) {
          InquiryCart t = value.data;
          newQty = t.inquiryDetails
              .firstWhere((element) => element.productId == product.id)
              .qty!;
          BalanceItemController balanceItemController = Get.find();
          balanceItemController.update([6]);
        } else {
          value.ShowMessage();
        }
      });
    } else {
      //is decreasing item quantity
      if (InquiryService().inquiryProductQTY(product.id) - multipleQty > 0) {
        //the item won't be removed
        qty = InquiryService().inquiryProductQTY(product.id) - multipleQty;
        await InquiryService().UpdateProduct(product.id!, qty).then((value) {
          if (value.isSuccess) {
            InquiryCart t = value.data;
            newQty = t.inquiryDetails
                .firstWhere((element) => element.productId == product.id)
                .qty!;
            BalanceItemController balanceItemController = Get.find();
            balanceItemController.update([6]);
          } else {
            value.ShowMessage();
          }
        });
      } else {
        //is removing from inquiry
        await remove(product).then((value) {
          if (value.isSuccess) {
            newQty = 0;
          } else {
            value.ShowMessage();
          }
        });
      }
    }
    return newQty;
  }

  Future<ResponseModel> remove(Product product) async {
    var response = await InquiryService().DeleteProduct(product.id!);
    if (response.isSuccess) {
      BalanceItemController balanceItemController = Get.find();
      balanceItemController.update([6]);
    }
    return response;
  }

}
