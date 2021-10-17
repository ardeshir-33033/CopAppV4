import 'package:copapp/Controller/Controllers/Balance/BalanceItemController.dart';
import 'package:copapp/Controller/Controllers/Cart/CartController.dart';
import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:easy_localization/easy_localization.dart' as lc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'BottomCompeleteBuying.dart';
import 'CartTab.dart';

class CartPage extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  CartController cartController = Get.find();
  ScoreService scoreController = Get.find();

  lc.NumberFormat nf = lc.NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: scaffoldKey,
        ),
        body: SafeArea(
          child: GetBuilder<CartController>(builder: (_) {
            return cartController.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
                  ))
                : CartServiceV2().getMyCart() != null
                    ? GetBuilder<BalanceItemController>(
                        id: 5,
                        builder: (_) {
                          return Column(
                            children: [
                              Expanded(
                                flex: 8,
                                child: CartTab(
                                    scaffold: scaffoldKey,
                                    cartDetail:
                                        CartServiceV2().getMyCart()!.details
                                    // cartController.cartDetail,
                                    // refreshCallback: (refresh) {
                                    //   cartDetail =
                                    //       CartServiceV2().getMyCart()!.cart!.cartDetails!;
                                    //   setState(() {});
                                    // },
                                    ),
                              ),
                              Visibility(
                                // visible: CartServiceV2().cartHasProduct(),
                                child: IntrinsicHeight(
                                  child: Align(
                                    alignment: FractionalOffset.bottomCenter,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: FractionalOffset
                                                      .bottomCenter,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 5,
                                                      ),
                                                    ],
                                                  ),
                                                  child:
                                                      GetBuilder<ScoreService>(
                                                          builder: (_) {
                                                    return Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("مبلغ کل"),
                                                              Text(nf
                                                                      .format(CartServiceV2()
                                                                          .getCartTotalPrice())
                                                                      .toString() +
                                                                  ' تومان'),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Visibility(
                                                          visible: scoreController
                                                              .getShowScore(),
                                                          child: Container(
                                                            color: CBase()
                                                                .borderPrimaryColor,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            width: CBase()
                                                                .getFullWidth(
                                                                    context),
                                                            height: 1,
                                                          ),
                                                        ),
                                                        Visibility(
                                                          maintainSize: false,
                                                          visible: scoreController
                                                              .getShowScore(),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            20),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        "جمع امتیاز"),
                                                                    Text((scoreController
                                                                        .getCartTotalPrice()
                                                                        .toInt()
                                                                        .toString()
                                                                        .toPersianDigit()))
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                BottomCompeleteBuying(
                                                  type: 1,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        })
                    : Center(
                        child: Text(
                          'مشکلی در دریافت اطلاعات رخ داده است',
                          style: TextStyle(color: CBase().textPrimaryColor),
                        ),
                      );
          }),
        ),
      ),
    );
  }
}
