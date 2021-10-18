import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:copapp/AppModel/Balance/Product.dart';
import 'package:copapp/Controller/Controllers/Balance/BalanceItemController.dart';
import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class BalanceItem extends StatefulWidget {
  final Product? bal;
  final GlobalKey<ScaffoldState> scaffold;

  BalanceItem({
    this.bal,
    required this.scaffold,
  });

  @override
  _BalanceItemState createState() => _BalanceItemState();
}

class _BalanceItemState extends State<BalanceItem> {
  BalanceItemController balanceItemController = Get.find();
  bool isLoading = false;

  NumberFormat nf = NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  ScoreService scoreServiceController = Get.find();

  NumberFormat nf1 = NumberFormat.decimalPattern("fa-IR");
  int itemCount = 0;
  bool hasItem = false;

  @override
  void initState() {
    super.initState();
    balanceItemController.scaffoldKey = widget.scaffold;
  }

  @override
  Widget build(BuildContext context) {
    checkHasItem(widget.bal!.productsId!);
    double widgetHeight = (CBase().getFullWidth(context) - 40) * 0.33 + 1;
    return GetBuilder<ScoreService>(builder: (_) {
      return Container(
        width: double.infinity,
        height: widgetHeight,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Visibility(
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
                visible: hasItem,
                child: Container(
                  width: 3,
                  height: widgetHeight * 0.35,
                  color: Color(0xffff0000),
                )),
            Expanded(
              flex: 1,
              child: Container(
                height: widgetHeight,
                child: Column(
                  children: [
                    widget.bal?.images != null && widget.bal!.images!.length > 0
                        ? Expanded(
                            flex: 3,
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        widget.bal?.images!.first.path ?? ""),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              onTap: () {
                                ///to fix bottom slider in every device this lines needs to be added to slide_popup_dialog.dart
                                // pageBuilder: ( context,  animation1,
                                //     animation2) {
                                //   return Container();
                                // },
                                widget.bal!.displayImageSlider(context);
                              },
                            ),
                          )
                        : Expanded(
                            flex: 3,
                            child: Container(
                              // height: CBase().getFullHeight(context) / 11,
                              // width: MediaQuery.of(context).size.width / 4,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("images/noimageiconsmall.png"),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                    scoreServiceController.getShowScore()
                        ? Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              '${widget.bal?.score}'.toPersianDigit(),
                              style: TextStyle(color: CBase().basePrimaryColor),
                            ))
                        : widget.bal!.brandsImagePath != null
                            ? Expanded(
                                flex: 1,
                                child: SvgPicture.network(
                                    widget.bal!.brandsImagePath!),
                              )
                            : Container(),
                  ],
                ),
              ),
            ),
            Container(
              height: CBase().getFullHeight(context) / 5.4 - 10,
              child: Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: CBase().borderPrimaryColor,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      flex: 5,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: CBase().borderPrimaryColor,
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: CBase().getFullHeight(context) / 5.4 - 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: CBase().getFullWidth(context) / 1.7 - 15,
                            margin: EdgeInsets.only(right: 10, left: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: AutoSizeText(
                                widget.bal!.productsName!.toPersianDigit(),
                                style: TextStyle(
                                  fontSize:
                                      CBase().getTitlefontSizeByScreen() * 0.85,
                                  color: CBase().textPrimaryColor,
                                  letterSpacing: -0.065,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              scoreServiceController.getShowScore()
                                  ? widget.bal!.brandsImagePath != null
                                      ? SvgPicture.network(
                                          widget.bal!.brandsImagePath!)
                                      : Container()
                                  : Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: AutoSizeText(
                                        widget.bal?.brandsName! ??
                                            "" + " - " + widget.bal!.country!,
                                        style: TextStyle(
                                          fontSize: CBase()
                                              .getSubTitlefontSizeByScreen(),
                                          color: CBase().basePrimaryLightColor,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                              Row(
                                children: [
                                  widget.bal!.warranty == true
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            "گارانتی",
                                            style: TextStyle(
                                              fontSize: CBase()
                                                  .getSubTitlefontSizeByScreen(),
                                              color:
                                                  CBase().basePrimaryLightColor,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  GetBuilder<BalanceItemController>(
                                    id: 'load',
                                    builder: (_) {
                                      return Visibility(
                                        visible: isLoading,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          width: 20.0,
                                          height: 20.0,
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              accentColor:
                                                  CBase().basePrimaryColor,
                                            ),
                                            child: isLoading
                                                ? CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            CBase()
                                                                .basePrimaryColor),
                                                  )
                                                : Text(""),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                      decoration: BoxDecoration(
                        color: CBase().borderPrimaryColor,
                      ),
                      height: 1.0,
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 7,
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
                                                  color:
                                                      CBase().basePrimaryColor,
                                                ),
                                              ),
                                              onTap: () {
                                                if (!isLoading) {
                                                  isLoading = true;
                                                  balanceItemController
                                                      .add(widget.bal!, hasItem)
                                                      .then((value) {
                                                    checkNewCount(value);
                                                    isLoading = false;
                                                    balanceItemController
                                                        .upDate();
                                                    balanceItemController
                                                        .upDateRow();
                                                  });
                                                }
                                              },
                                            )
                                          : Text(""),
                                      Flexible(
                                        child: InkWell(
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: AutoSizeText(
                                              !hasItem
                                                  ? 'خرید'
                                                  : itemCount
                                                          .toString()
                                                          .toPersianDigit() +
                                                      " " +
                                                      widget.bal!.unitsName!,
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
                                            if (!isLoading && !hasItem) {
                                              isLoading = true;
                                              balanceItemController
                                                  .add(widget.bal!, hasItem)
                                                  .then((value) {
                                                isLoading = false;
                                                balanceItemController.upDate();
                                                checkNewCount(value);
                                                balanceItemController
                                                    .upDateRow();
                                              });
                                            }
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
                                                if (!isLoading) {
                                                  isLoading = true;
                                                  balanceItemController
                                                      .remove(widget.bal!,
                                                          itemCount)
                                                      .then((value) {
                                                    isLoading = false;
                                                    balanceItemController
                                                        .upDate();
                                                    checkNewCount(value);
                                                    balanceItemController
                                                        .upDateRow();
                                                  });
                                                }
                                              },
                                            )
                                          : Text(""),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                color: CBase().borderPrimaryColor,
                              ),
                              width: 1,
                              // height: 50.0,
                            ),
                            Flexible(
                              flex: 6,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: GetBuilder<BalanceItemController>(
                                        id: 1,
                                        builder: (_) {
                                          return Column(
                                            mainAxisAlignment:
                                                scoreServiceController
                                                            .getShowScore() &&
                                                        hasItem
                                                    ? MainAxisAlignment
                                                        .spaceEvenly
                                                    : MainAxisAlignment.center,
                                            children: [
                                              !hasItem
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Visibility(
                                                          visible: hasItem,
                                                          child: Text(
                                                            "فی",
                                                            style: TextStyle(
                                                              fontSize: CBase()
                                                                  .getSmallfontSizeByScreen(),
                                                              color: CBase()
                                                                  .textPrimaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          nf
                                                              .format(widget
                                                                      .bal!
                                                                      .productInfosPrice ??
                                                                  0)
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: CBase()
                                                                .getSmallfontSizeByScreen(),
                                                            color: CBase()
                                                                .textPrimaryColor,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        SvgPicture.string(
                                                          CBase.toman,
                                                          color: CBase()
                                                              .textPrimaryColor,
                                                          allowDrawingOutsideViewBox:
                                                              true,
                                                          width: 15.0,
                                                          height: 15.0,
                                                        ),
                                                      ],
                                                    )
                                                  : Visibility(
                                                      visible:
                                                          scoreServiceController
                                                              .getShowScore(),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            (widget.bal!.score! *
                                                                    itemCount)
                                                                .toInt()
                                                                .toString()
                                                                .toPersianDigit(),
                                                            style: TextStyle(
                                                              fontSize: CBase()
                                                                  .getSmallfontSizeByScreen(),
                                                              color: CBase()
                                                                  .textPrimaryColor,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Visibility(
                                                            visible: hasItem,
                                                            child: Text(
                                                              "امتیاز",
                                                              style: TextStyle(
                                                                fontSize: CBase()
                                                                    .getSmallfontSizeByScreen(),
                                                                color: CBase()
                                                                    .textPrimaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              Visibility(
                                                visible: scoreServiceController
                                                        .getShowScore() &&
                                                    hasItem,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 1),
                                                  height: 1,
                                                  width: CBase().getFullWidth(
                                                              context) /
                                                          3.7 -
                                                      5,
                                                  color: CBase()
                                                      .borderPrimaryColor,
                                                ),
                                              ),
                                              Visibility(
                                                visible: hasItem,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FittedBox(
                                                      child: AutoSizeText(
                                                        nf
                                                            .format(itemCount *
                                                                widget.bal!
                                                                    .productInfosPrice!)
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: CBase()
                                                                  .getTitlefontSizeByScreen() *
                                                              0.9,
                                                          color: CBase()
                                                              .basePrimaryLightColor,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    SvgPicture.string(
                                                      CBase.toman,
                                                      color: CBase()
                                                          .basePrimaryLightColor,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                      width: 15.0,
                                                      height: 15.0,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
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
