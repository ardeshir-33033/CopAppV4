import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/AppModel/Balance/Product.dart';
import 'package:copapp/Controller/Controllers/Balance/BalanceItemController.dart';
import 'package:copapp/Controller/Service/InquiryService.dart';
import 'package:copapp/Model/Inquiry/InquiryCart.dart';
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
        .addInquiryProduct(
            productId: product.productsId!,
            qty: multipleQty,
            supplier: product.supplierId!)
        .then((value) {
      if (value.isSuccess) {
        InquiryCart t = value.data;
        newQty = t.details
            .firstWhere(
                (element) => element.product!.productsId == product.productsId)
            .product!
            .detailQTY!;
      } else {
        value.showMessage();
      }
    });
    return newQty;
  }

  Future<int> upDate(Product product, bool isAdding) async {
    int qty = 0;
    int newQty = InquiryService().inquiryProductQTY(product.productsId);
    int multipleQty = (product.multipleQTY == null || product.multipleQTY! <= 0
        ? 1
        : product.multipleQTY!);
    if (isAdding) {
      //is adding to item quantity
      qty = newQty + multipleQty;
      await InquiryService()
          .updateProduct(product.productsId!, qty, product.supplierId!)
          .then((value) {
        if (value.isSuccess) {
          InquiryCart t = value.data;
          newQty = t.details
              .firstWhere((element) =>
                  element.product!.productsId == product.productsId)
              .product!
              .detailQTY!;
          BalanceItemController balanceItemController = Get.find();
          balanceItemController.update(["parent"]);
        } else {
          value.showMessage();
        }
      });
    } else {
      //is decreasing item quantity
      if (InquiryService().inquiryProductQTY(product.productsId) - multipleQty >
          0) {
        //the item won't be removed
        qty = InquiryService().inquiryProductQTY(product.productsId) -
            multipleQty;
        await InquiryService()
            .updateProduct(product.productsId!, qty, product.supplierId!)
            .then((value) {
          if (value.isSuccess) {
            InquiryCart t = value.data;
            newQty = t.details
                .firstWhere((element) =>
                    element.product!.productsId == product.productsId)
                .product!
                .detailQTY!;
            BalanceItemController balanceItemController = Get.find();
            balanceItemController.update(["parent"]);
          } else {
            value.showMessage();
          }
        });
      } else {
        //is removing from inquiry
        await remove(product).then((value) {
          if (value.isSuccess) {
            newQty = 0;
          } else {
            value.showMessage();
          }
        });
      }
    }
    return newQty;
  }

  Future<ResponseModel> remove(Product product) async {
    var response = await InquiryService()
        .deleteProduct(product.productsId!, product.supplierId!);
    if (response.isSuccess) {
      BalanceItemController balanceItemController = Get.find();
      balanceItemController.update(["parent"]);
    }
    return response;
  }
}
