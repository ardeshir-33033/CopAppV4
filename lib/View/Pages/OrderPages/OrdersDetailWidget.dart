import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Model/Order/OrderDetail.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

// ignore: must_be_immutable
class OrdersDetailWidget extends StatelessWidget {
  OrdersDetailWidget({
    this.orderDetail,
    required this.scaffold,
  });

  OrderDetail? orderDetail = OrderDetail();
  final GlobalKey<ScaffoldState> scaffold;

  NumberFormat nf = NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );
  bool vis = false;
  ScoreService scoreController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          height: CBase().getFullHeight(context) / 7,
          margin: EdgeInsets.symmetric(
              horizontal: CBase().getFullWidth(context) / 17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0x29000000), offset: Offset(3, 3), blurRadius: 6)
            ],
          ),
          child: GetBuilder<ScoreService>(builder: (_) {
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 3,
                          child: orderDetail!.product!.images!.length != 0
                              ? Image.network(
                                  orderDetail!.product!.images!.first)
                              : Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "images/noimageicon.png"))),
                                )),
                      scoreController.getShowScore()
                          ? Expanded(
                              flex: 1,
                              child: Text(
                                ('${orderDetail?.product?.score}'
                                    .toPersianDigit()),
                                style:
                                    TextStyle(color: CBase().basePrimaryColor),
                              ))
                          : Expanded(
                              flex: 1,
                              child: orderDetail!.product!.brandsImagePath !=
                                          null ||
                                      orderDetail!.product!.brandsImagePath!=
                                          ""
                                  ? SvgPicture.network(
                                      orderDetail!.product!.brandsImagePath!)
                                  : Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "images/noimageicon.png"))),
                                    ))
                    ],
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: VerticalDivider(
                        width: 1,
                        color: CBase().borderPrimaryColor,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: VerticalDivider(
                        width: 1,
                        color: CBase().borderPrimaryColor,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      orderDetail?.product?.productsName ?? "",
                                      style: TextStyle(
                                        fontSize:
                                            CBase().getTitlefontSizeByScreen(),
                                        color: CBase().textPrimaryColor,
                                        letterSpacing: -0.065,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        scoreController.getShowScore()
                                            ? orderDetail!.product!.brandsImagePath !=
                                                        null ||
                                                    orderDetail!.product!.brandsImagePath!=
                                                        ""
                                                ? SvgPicture.network(
                                                    orderDetail!.product!.brandsImagePath!)
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "images/noimageicon.png"))),
                                                  )
                                            : Row(
                                                children: [
                                                  Text(
                                                      orderDetail?.product
                                                              ?.brandsName ??
                                                          "",
                                                      style: TextStyle(
                                                        fontSize: CBase()
                                                            .getTextfontSizeByScreen(),
                                                        color: CBase()
                                                            .basePrimaryLightColor,
                                                      )),
                                                  Text(
                                                    " - ",
                                                    style: TextStyle(
                                                        color: CBase()
                                                            .basePrimaryLightColor),
                                                  ),
                                                  Text(
                                                      orderDetail?.product
                                                              ?.country??
                                                          "",
                                                      style: TextStyle(
                                                        fontSize: CBase()
                                                            .getTextfontSizeByScreen(),
                                                        color: CBase()
                                                            .basePrimaryLightColor,
                                                      )),
                                                ],
                                              ),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          child: Visibility(
                                            maintainSize: false,
                                            maintainAnimation: true,
                                            maintainState: true,
                                            visible: vis,
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                accentColor:
                                                    CBase().basePrimaryColor,
                                              ),
                                              child: vis
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
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: CBase().borderPrimaryColor,
                            thickness: 1,
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: Text(
                                              (orderDetail!.product!.detailQTY!
                                                      .toInt()
                                                      .toString()
                                                      .toPersianDigit() +
                                                  " " +
                                                  orderDetail!
                                                      .product!.unitsName!),
                                              style: TextStyle(
                                                fontSize: CBase()
                                                    .getTitlefontSizeByScreen(),
                                                color: orderDetail!.product!.detailQTY! >
                                                        0
                                                    ? CBase().textPrimaryColor
                                                    : CBase().basePrimaryColor,
                                                letterSpacing: -0.32,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: VerticalDivider(
                                      width: 1,
                                      color: CBase().borderPrimaryColor,
                                      thickness: 1,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "فی",
                                                    style: TextStyle(
                                                      fontSize: CBase()
                                                          .getTextfontSizeByScreen(),
                                                      color: CBase()
                                                          .textPrimaryColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    nf
                                                        .format(orderDetail!
                                                                .unitPrice ??
                                                            0)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: CBase()
                                                          .getTextfontSizeByScreen(),
                                                      color: CBase()
                                                          .textPrimaryColor,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text("")
                                                ],
                                              )),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 5.0),
                                            child: Divider(
                                              height: 1,
                                              color: CBase().borderPrimaryColor,
                                              thickness: 1,
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(""),
                                                  FittedBox(
                                                    child: Text(
                                                      nf.format(orderDetail!
                                                          .finalPrice),
                                                      style: TextStyle(
                                                          color: CBase()
                                                              .basePrimaryLightColor,
                                                          fontSize: CBase()
                                                              .getTitlefontSizeByScreen()),
                                                    ),
                                                  ),
                                                  SvgPicture.string(
                                                    CBase.toman,
                                                    color: CBase()
                                                        .basePrimaryLightColor,
                                                    allowDrawingOutsideViewBox:
                                                        true,
                                                    width: 18.0,
                                                    height: 18.0,
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ))
                                ],
                              ))
                        ],
                      ),
                    ))
              ],
            );
          }),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
