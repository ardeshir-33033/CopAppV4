import 'package:copapp/AppModel/Balance/Product.dart';
import 'package:copapp/Controller/Controllers/General/PointController.dart';
import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalanceItemController extends GetxController {
  bool buyLoading = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<int> add(Product bal, bool hasItem) async {
    update(['load']);
    if (!hasItem) {
      var result = await CartServiceV2().addProduct(bal.productsId!, 1);
      if (!result.isSuccess) {
        result.showMessage();

        return 0;
      } else {
        if (CartServiceV2().cartProductQTY(bal.productsId!) == 0) {
          Snacki().GETSnackBar(
              false, 'خطایی در برقراری ارتباط با سرور رخ داده است');
          return 0;
        }
        update(["addDel"]);
        update(["parent"]);
        if (bal.productInfosPrice! > 0) {
          PointController pointController = Get.find();
          pointController.add(
              bal.score!.toDouble() * (bal.multipleQTY ?? 1), true);
          ScoreService scoreService = Get.find();
          scoreService.update();
        }
      }
      if (bal.multipleQTY! <= 0) {
        return 1;
      } else {
        return bal.multipleQTY!;
      }
    } else {
      upDate();

      int qty = CartServiceV2().cartProductQTY(bal.productsId);
      int newQTY = qty;

      if (bal.multipleQTY! <= 0)
        newQTY += 1;
      else
        newQTY += bal.multipleQTY!;
      if (newQTY > bal.productVirtualQTY!.toInt()) {
        Snacki().GETSnackBar(
            false, "تعداد خرید این کالا به ماکسیمم خود رسیده است.");
        return qty;
      } else {
        var result =
            await CartServiceV2().updateProduct(bal.productsId!, newQTY);

        if (!result.isSuccess) {
          result.showMessage();
        } else {
          update(["addDel"]);
          update(["parent"]);
          if (bal.score! > 0) {
            PointController pointController = Get.find();
            pointController.add(
                bal.score!.toDouble() * (bal.multipleQTY ?? 1), false);
            ScoreService scoreService = Get.find();
            scoreService.update();
          }
        }
        return newQTY;
      }
    }
  }

  Future<int> remove(Product bal, int itemCount) async {
    upDate();

    // var newQty = CartServiceV2().cartProductQTY(bal.id);
    int oldQTY = itemCount;
    if (bal.multipleQTY! <= 0)
      itemCount -= 1;
    else
      itemCount -= bal.multipleQTY!;

    if (itemCount <= 0) {
      var result = await CartServiceV2().deleteProduct(bal.productsId!);

      if (!result.isSuccess) {
        result.showMessage();
        itemCount = oldQTY;
      } else {
        PointController pointController = Get.find();
        pointController
            .decrease(bal.score!.toDouble() * (bal.multipleQTY ?? 1));
        ScoreService scoreService = Get.find();
        scoreService.update();
        update(["cart"]);
        update(["parent"]);
        // update([1]);
      }
    } else {
      var result =
          await CartServiceV2().updateProduct(bal.productsId!, itemCount);

      if (!result.isSuccess) {
        result.showMessage();
        itemCount = oldQTY;
      } else {
        PointController pointController = Get.find();
        pointController
            .decrease(bal.score!.toDouble() * (bal.multipleQTY ?? 1));
        ScoreService scoreService = Get.find();
        scoreService.update();
        update(["addDel"]);
        update(["parent"]);
      }
    }
    return itemCount;
    // if (widget.onTapCallback != null) {
    //   // widget.onTapCallback("tap");
    // }
  }

  upDate() {
    update(['load']);
  }

  upDateRow() {
    update(["addDel"]);
  }
}
