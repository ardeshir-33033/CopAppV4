import 'dart:ui';

import 'package:copapp/AppModel/Balance/Product.dart';
import 'package:copapp/Controller/Controllers/Balance/BalanceItemController.dart';
import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Controller/Controllers/SearchProductController.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class JoinedItems extends StatefulWidget {
  Product? bal;

  JoinedItems({
    this.bal,
    Key? key,
  }) : super(key: key);

  @override
  _JoinedItemsState createState() => _JoinedItemsState();
}

class _JoinedItemsState extends State<JoinedItems> {
  SearchProductController searchProductController = Get.find();

  bool isLoadingPurchase = false;
  int itemCount = 0;
  bool hasItem = false;
  ScoreService scoreController = Get.find();

  BalanceItemController balanceItemController =
      Get.put(BalanceItemController());

  NumberFormat nf = NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  NumberFormat nf1 = NumberFormat.decimalPattern("fa-IR");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkHasItem(widget.bal!.productsId!);
    balanceItemController.scaffoldKey = searchProductController.scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.33),
              color: const Color(0xffcbcbcb),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 8.0),
            height: 70.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: InkWell(
                          onTap: () {
                            // ProductWidgets().showDialog(
                            //   context,
                            //   widget.scaffold,
                            //   widget.bal.images,
                            // );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 5.0,
                              bottom: 5.0,
                            ),
                            alignment: Alignment.centerRight,
                            child: SvgPicture.network(
                                widget.bal?.brandsImagePath ?? ""),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 3.0),
                      child: Text(
                        '${widget.bal?.brandsName} ${widget.bal?.country}',
                        style: TextStyle(
                          fontSize: CBase().getSubTitlefontSizeByScreen(),
                          color: CBase().basePrimaryLightColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 5.0,
                        left: 10.0,
                        right: 5.0,
                      ),
                      width: 1.0,
                      height: 15.0,
                      decoration:
                          BoxDecoration(color: CBase().textLightPrimaryColor),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      child: SvgPicture.asset(
                        "images/truck.svg",
                        height: 16.0,
                      ),
                    ),
                    // Container(
                    //   child: Text(
                    //     (widget.bal?.code ?? "").toPersianDigit(),
                    //     style: TextStyle(
                    //       fontSize: CBase().getTextfontSizeByScreen(),
                    //       color: CBase().textPrimaryColor,
                    //     ),
                    //   ),
                    // ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(""),
                    ),
                    Container(
                      width: 20.0,
                      height: 20.0,
                      child: GetBuilder<BalanceItemController>(
                        id: 'load',
                        builder: (_) {
                          return Visibility(
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: isLoadingPurchase,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                accentColor: CBase().basePrimaryColor,
                              ),
                              child: isLoadingPurchase
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          CBase().basePrimaryColor),
                                    )
                                  : Text(""),
                            ),
                          );
                        },
                      ),
                    ),
                    ProfileServiceV2().getDisplayPoint()
                        ? Container(
                            child: Text(
                              "-",
                              style: TextStyle(
                                fontSize: CBase().getSubTitlefontSizeByScreen(),
                                color: CBase().textPrimaryColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          )
                        : SizedBox(
                            width: 1.0,
                          ),
                    ProfileServiceV2().getDisplayPoint()
                        ? Container(
                            margin: EdgeInsets.only(
                              left: 5.0,
                              right: 5.0,
                            ),
                            child: Image.asset(
                              "images/commition.png",
                              width: 20.0,
                              height: 20.0,
                            ),
                          )
                        : SizedBox(
                            width: 1.0,
                          ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.33),
              color: CBase().borderPrimaryColor,
            ),
          ),
          Container(
              height: 60.0,
              child: widget.bal!.productInfosPrice != 0.0 &&
                      widget.bal!.productVirtualQTY != 0.0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            child: GetBuilder<BalanceItemController>(
                              id: 1,
                              builder: (_) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    hasItem
                                        ? InkWell(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                right: 10.0,
                                                left: 5.0,
                                              ),
                                              child: SvgPicture.asset(
                                                "images/plus.svg",
                                                width: 15.0,
                                                height: 15.0,
                                                color: CBase().basePrimaryColor,
                                              ),
                                            ),
                                            onTap: () {
                                              isLoadingPurchase = true;
                                              searchProductController.update();
                                              balanceItemController
                                                  .add(widget.bal!, hasItem)
                                                  .then((value) {
                                                checkNewCount(value);
                                                isLoadingPurchase = false;
                                                searchProductController
                                                    .update();
                                              });
                                            },
                                          )
                                        : Text(""),
                                    Flexible(
                                      child: InkWell(
                                        child: Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                            !hasItem
                                                ? 'خرید'
                                                : (CartServiceV2()
                                                            .cartProductQTY(
                                                                widget.bal!.productsId)
                                                            .toString() +
                                                        " " +
                                                        widget.bal!.unitsName!)
                                                    .toPersianDigit(),
                                            style: TextStyle(
                                              fontSize: CBase()
                                                  .getTitlefontSizeByScreen(),
                                              color: hasItem
                                                  ? CBase().textPrimaryColor
                                                  : CBase().basePrimaryColor,
                                              letterSpacing: -0.32,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        onTap: () {
                                          isLoadingPurchase = true;
                                          searchProductController.update();
                                          balanceItemController
                                              .add(widget.bal!, hasItem)
                                              .then((value) {
                                                checkNewCount(value);
                                            isLoadingPurchase = false;
                                            searchProductController.update();
                                          });
                                        },
                                      ),
                                    ),
                                    hasItem
                                        ? InkWell(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 10.0,
                                                right: 5.0,
                                              ),
                                              child: SvgPicture.asset(
                                                "images/del.svg",
                                                width: 15.0,
                                                height: 15.0,
                                              ),
                                            ),
                                            onTap: () {
                                              isLoadingPurchase = true;
                                              searchProductController.update();
                                              balanceItemController
                                                  .remove(
                                                      widget.bal!, itemCount)
                                                  .then((value) {
                                                    checkNewCount(value);
                                                isLoadingPurchase = false;
                                                searchProductController
                                                    .update();
                                              });
                                            },
                                          )
                                        : Text(""),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: CBase().borderPrimaryColor,
                          ),
                          width: 0.5,
                          height: 47.0,
                        ),
                        Flexible(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      hasItem
                                          ? Visibility(
                                              visible: scoreController
                                                  .getShowScore(),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      ('${(widget.bal!.score! * itemCount).toInt()}'),
                                                      style: TextStyle(
                                                        fontSize: CBase()
                                                                .getTextfontSizeByScreen() +
                                                            2,
                                                        color: CBase()
                                                            .textPrimaryColor,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text(
                                                    "امتیاز",
                                                    style: TextStyle(
                                                      fontSize: CBase()
                                                          .getSmallfontSizeByScreen(),
                                                      color: CBase()
                                                          .textPrimaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    nf
                                                        .format(widget
                                                                .bal!
                                                                .productInfosPrice ??
                                                            0.0)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: CBase()
                                                              .getTextfontSizeByScreen() +
                                                          2,
                                                      color: CBase()
                                                          .textPrimaryColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                SvgPicture.string(
                                                  CBase.toman,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  width: 13.0,
                                                  height: 13.0,
                                                ),
                                              ],
                                            ),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: hasItem &&
                                                scoreController.getShowScore(),
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 1),
                                              height: 0.47,
                                              width: CBase().getFullWidth(
                                                          context) /
                                                      2.4 -
                                                  5,
                                              color: CBase().borderPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: hasItem,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IntrinsicHeight(
                                              child: Container(
                                                child: Text(
                                                  nf
                                                      .format(itemCount *
                                                          widget
                                                              .bal!
                                                              .productInfosPrice!)
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: CBase()
                                                        .getTitlefontSizeByScreen(),
                                                    color: CBase()
                                                        .basePrimaryLightColor,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            SvgPicture.string(
                                              CBase.toman,
                                              allowDrawingOutsideViewBox: true,
                                              width: 18.0,
                                              height: 18.0,
                                              color:
                                                  CBase().basePrimaryLightColor,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "موجودی کالای مورد نظر صفر میباشد.",
                          style: TextStyle(
                              fontSize: CBase().getTextfontSizeByScreen(),
                              color: CBase().textPrimaryColor),
                        )
                      ],
                    ))
        ],
      ),
    );
  }

  checkHasItem(int id) {
    itemCount = CartServiceV2().cartProductQTY(id);
    if (itemCount == 0) {
      hasItem = false;
    } else {
      hasItem = true;
    }
  }

  void checkNewCount(int c) {
    if (c <= 0) {
      hasItem = false;
      itemCount = 0;
    } else {
      hasItem = true;
      itemCount = c;
    }
  }
}
