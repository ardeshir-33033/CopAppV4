import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/OrderPages/OrdersDetailWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Bill extends StatefulWidget {
  Bill({this.orderId, required this.scaffoldKey, this.order});

  int? orderId;
  OrderHeader? order = OrderHeader();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'مشتری گرامی فاکتور تولید و برای بسته بندی ارسال خواهد شد.',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: CBase().getSubTitlefontSizeByScreen(),
                        color: Color(0xff7B7B7B)),
                  ),
                ),
              ],
            ),
            widget.order!.orderDetails != null
                ? Column(children: <Widget>[
                    for (int index = 0;
                        index < widget.order!.orderDetails!.length;
                        index++)
                      OrdersDetailWidget(
                        scaffold: widget.scaffoldKey,
                        orderDetail: widget.order!.orderDetails![index],
                      )
                  ])
                : Text("در حال دریافت"),
            // Column(
            //   children: <Widget>[for (int i = 0; i <= 10; i++) ProductCard()],
            // ),
            // TotalCard()
          ],
        ),
      ),
    );
  }
}
