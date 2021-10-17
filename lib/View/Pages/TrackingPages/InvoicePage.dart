import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/MainFooter.dart';
import 'package:copapp/View/Pages/TrackingPages/packing.dart';
import 'package:copapp/View/Pages/TrackingPages/sending.dart';
import 'package:copapp/View/Pages/TrackingPages/transporting.dart';
import 'package:copapp/View/Widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'TrackingComponents/tracking_progress_widget.dart';
import 'bill.dart';
import 'buy.dart';
import 'invoice.dart';

class Tracking extends StatefulWidget {
  TrackingStage trackingStage;
  int? orderId;

  Tracking({Key? key, this.trackingStage = TrackingStage.Bill, this.orderId})
      : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ResponseModel<OrderHeader> OrderModel = ResponseModel<OrderHeader>();
  OrderHeader order = OrderHeader();
  String? _date;

  Future orderDetail() async {
    OrderModel = await OrderServiceV2().GetWithDetail(widget.orderId!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderDetail().then((value) {
      if (!OrderModel.isSuccess) {
        OrderModel.showMessage();
      } else {
        order = OrderModel.data;
        if (order.orderStatusId == "confirmedPay") {
          widget.trackingStage = TrackingStage.Bill;
        } else if (order.orderStatusId == "Packing") {
          widget.trackingStage = TrackingStage.Packing;
        } else if (order.orderStatusId == "Transporting") {
          widget.trackingStage = TrackingStage.Transporting;
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xffF6F6F6),
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'سبد های خرید پرداخت شده',
                      style: TextStyle(
                          color: CBase().textPrimaryColor,
                          fontSize: CBase().getTextfontSizeByScreen()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.0, top: 0.0),
                      child: SvgPicture.asset("images/CopAppTitle.svg"),
                    ),
                  ],
                )),
            leading: DrawerWidget(scaffoldKey: _scaffoldKey),
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
              child: TrackingProgress(
                trackingStage: widget.trackingStage,
              ),
            )),
        drawer: AppDrawer(
          scaffoldKey: _scaffoldKey,
        ),
        bottomNavigationBar: MainFooterNavigation(),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      widget.trackingStage == TrackingStage.Buy
                          ? Buy()
                          : widget.trackingStage == TrackingStage.Bill
                              ? Bill(
                                  orderId: widget.orderId!,
                                  scaffoldKey: _scaffoldKey,
                                  order: order,
                                )
                              : widget.trackingStage == TrackingStage.Packing
                                  ? Packing(
                                      order: order,
                                    )
                                  : widget.trackingStage == TrackingStage.Sending
                                      ? Sending(
                                          order: order,
                                        )
                                      : widget.trackingStage ==
                                              TrackingStage.Transporting
                                          ? Transporting()
                                          : widget.trackingStage ==
                                                  TrackingStage.Invoice
                                              ? Invoice()
                                              : SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeDatetime(int year, int month, int day) {
    setState(() {
      _date = '$year-$month-$day';
    });
  }
}
