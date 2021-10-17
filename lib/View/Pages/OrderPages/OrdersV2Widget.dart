import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Model/Order/OrderDetail.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/OrderPages/OrdersDetail.dart';
import 'package:copapp/View/Pages/TrackingPages/InvoicePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class OrdersV2Widget extends StatelessWidget {
  OrderHeader? item = OrderHeader();

  @required
  int? type;

  OrdersV2Widget({required this.item, @required this.type});
  ScoreService scoreController = Get.find();
  double getTotalScore(List<OrderDetail> item) {
    double totalScore = 0.0;
    item.forEach((element) {
      totalScore +=
          element.product!.score! * element.quantity!;
    });
    return totalScore;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            height: CBase().getFullHeight(context) / 6,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            margin: EdgeInsets.symmetric(
                horizontal: CBase().getFullWidth(context) / 17),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(3, 3),
                    blurRadius: 6)
              ],
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Center(
                                child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: FittedBox(
                                  child: Text(
                                      "سبد خرید:${(item!.id.toString()).toPersianDigit()}",
                                      style: TextStyle(
                                        fontSize: CBase().mtitlefontSize,
                                        color: CBase().textPrimaryColor,
                                      ))),
                            ))),
                        VerticalDivider(
                          width: 8,
                          color: CBase().borderPrimaryColor,
                          thickness: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text(
                                    "${item!.title == "" ? "بدون نام" : item!.title}"
                                        .toPersianDigit(),
                                    style: TextStyle(
                                      fontSize: CBase().mtextfontSize,
                                      color: CBase().textPrimaryColor,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: CBase().borderPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 5,
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: CBase().borderPrimaryColor,
                      ),
                    ),
                  ],
                ),
                Expanded(
                    flex: 2,
                    child: GetBuilder<ScoreService>(builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              ("تعداد اقلام: ${item!.orderDetails!.length}"
                                      .toPersianDigit()) +
                                  " عدد",
                              style: TextStyle(
                                fontSize: CBase().mtextfontSize,
                                color: CBase().textPrimaryColor,
                              )),
                          Text(
                              type == 1
                                  ? "در انتظار پرداخت"
                                  : type == 2
                                      ? "پرداخت شده"
                                      : type == 3
                                          ? "در حال ارسال"
                                          : "",
                              style: TextStyle(
                                fontSize: CBase().mtextfontSize,
                                color: CBase().textPrimaryColor,
                              )),
                          scoreController.getShowScore()
                              ? Text(
                                  ("امتیاز: ${getTotalScore(item!.orderDetails!)}"
                                      .toPersianDigit()),
                                  style: TextStyle(
                                    fontSize: CBase().mtextfontSize,
                                    color: Color(0xffBD8729),
                                  ))
                              : Text(""),
                        ],
                      );
                    })),
              ],
            ),
          ),
          onTap: () {
            if (type == 1 || type == 3) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrdersDetail(
                            type: type!,
                            orderDetails: item!.orderDetails,
                            orderId: item!.id,
                          )));
            }
            if (type == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Tracking(
                            orderId: item!.id,
                          )));
            }
          },
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
