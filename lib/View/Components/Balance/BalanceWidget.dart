import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/Inquiry/InquiryItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'BrandItems.dart';
import 'CategoryItems.dart';

class BalanceWidget extends StatelessWidget {
  final Part? bal;
  final GlobalKey<ScaffoldState> scaffoldKey;

  BalanceWidget({
    this.bal,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryItems(
            item: bal,
          ),
          bal!.products != null && hasValidProduct(bal!)
              ? GetBuilder<ScoreService>(builder: (_) {
                  return Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // color: Color(0xffD1D1D1),
                          ),
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          child: Column(
                              children: bal!.products!
                                  .map((e) => e.productVirtualQTY != 0 &&
                                          e.productInfosPrice == 0
                                      ? Container()
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: e.isForSale()
                                              ? BalanceItem(
                                                  scaffold: scaffoldKey,
                                                  bal: e,
                                                )
                                              : InquiryItem(
                                                  scaffold: scaffoldKey,
                                                  bal: e,
                                                )))
                                  .toList())),
                    ],
                  );
                })
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                      child: Text(
                    'کالایی موجود نیست',
                    style: TextStyle(
                        color: CBase().textPrimaryColor,
                        fontSize: CBase().getTitlefontSizeByScreen()),
                  )),
                ),
        ],
      ),
    );
  }

  bool hasValidProduct(Part bal) {
    // bool result = false;
    for (int i = 0; i < bal.products!.length; i++) {
      if (bal.products![i].productVirtualQTY == 0 ||
          (bal.products![i].productInfosPrice != 0 &&
              bal.products![i].productVirtualQTY != 0)) {
        // result = true;
        return true;
      }
    }
    return false;
  }
}
