import 'package:copapp/Controller/Controllers/Order/OrderInfoController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/Order/scorePriceOrderDetail.dart';
import 'package:easy_localization/easy_localization.dart' as lc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../OrdersDetailWidget.dart';

// ignore: must_be_immutable
class SendingOrdersDetailPage extends StatefulWidget {
  SendingOrdersDetailPage({required this.finalScore,
    required this.finalPrice,
    required this.orderId});

  double finalPrice = 0.0;
  double finalScore = 0.0;
  int orderId;

  @override
  _SendingOrdersDetailPageState createState() =>
      _SendingOrdersDetailPageState();
}

class _SendingOrdersDetailPageState extends State<SendingOrdersDetailPage> {
  OrderInfoController orderInfoController = Get.put(OrderInfoController());

  @override
  void initState() {
    super.initState();
    orderInfoController.getOrder(widget.orderId);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final lc.NumberFormat nf = lc.NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: AppDrawer(
          scaffoldKey: _scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: "سبدهای خرید در حال ارسال",
        ),
        body: SafeArea(
          child: GetBuilder<OrderInfoController>(
            id: "loading",
            builder: (_) {
              return orderInfoController.isLoading
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(
                          CBase().basePrimaryColor),
                    ),
                    Text("در حال دریافت")
                  ],
                ),
              )
                  : orderInfoController.order!.orderDetails!.length == 0
                  ? Center(
                child: Text("لیست خالی است."),
              )
                  : orderInfoController.order!.orderDetails == null
                  ? Center(
                child: Text(
                    "سیستم در گرفتن اطلاعات با مشکل مواجه شد."),
              )
                  :Column(
                children: [
                  Expanded(
                      flex: 5,
                      child: ListView.builder(
                          itemCount: orderInfoController
                              .order!.orderDetails!.length,
                          itemBuilder: (context, int index) {
                            return OrdersDetailWidget(
                              orderDetail: orderInfoController
                                  .order!.orderDetails![index],
                              scaffold: _scaffoldKey,
                            );
                          })),
                  IntrinsicHeight(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        child: Column(
                          children: [
                            // PendingOrdController pendingOrdController =
                            //     Get.find();
                            Container(
                                margin: EdgeInsets.only(
                                    left: CBase().getFullWidth(context) / 18,
                                    right: CBase().getFullWidth(context) / 18,
                                    top: 8),
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x29000000),
                                      offset: Offset(-3, 5),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: ScorePriceOrderDetail(
                                  finalPrice: widget.finalPrice,
                                  score: widget.finalScore,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: CBase().getFullWidth(context) /
                                      18,
                                  vertical: 10),
                              // child: BottomCompleteBuying(
                              //     type: 2,
                              //     pendingCart: orderDetails,
                              //     orderId: orderId),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
