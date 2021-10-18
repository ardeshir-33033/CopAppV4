import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

class OrdersV2Widget extends StatelessWidget {
  final int? count, id;
  final GlobalKey<ScaffoldState> scaffold;
  final int type;

  OrdersV2Widget(
      {required this.scaffold, required this.type, this.count, this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              height: CBase().getFullHeight(context) / 5,
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
                                    child: Text("سبد خرید:$id",
                                        style: TextStyle(
                                          fontSize: CBase().mtitlefontSize,
                                          color: CBase().textPrimaryColor,
                                        ))),
                              ))),
                          VerticalDivider(
                            width: 1,
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
                                  child: Text("نام گیرنده",
                                      style: TextStyle(
                                        fontSize: CBase().mtitlefontSize,
                                        color: CBase().textPrimaryColor,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Icon(
                              Icons.phone,
                              color: Colors.red,
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
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: CBase().borderPrimaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: CBase().borderPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("تعداد اقلام:$count",
                              style: TextStyle(
                                fontSize: CBase().mtitlefontSize,
                                color: CBase().textPrimaryColor,
                              )),
                          Text(
                              type == 2
                                  ? "سبد های خرید در انتظار پرداخت"
                                  : type == 1
                                      ? "سبد های خرید پرداخت شده"
                                      : type == 3
                                          ? "سبد های خرید در حال ارسال"
                                          : "",
                              style: TextStyle(
                                fontSize: CBase().mtitlefontSize,
                                color: CBase().textPrimaryColor,
                              )),
                          Text(""),
                        ],
                      )),
                ],
              ),
            ),
          ),
          onTap: () {
            if (type == 1) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             OrdersDetail(type: type,
              //               orderDetails: item.orderDetails,
              //             )));
            }
            if (type == 2) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             OrdersDetail(type: type,
              //               orderDetails: item.orderDetails,
              //             )));
            }

            if (type == 3) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             OrdersDetail(type: type,
              //               orderDetails: item.orderDetails,
              //             )));
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
