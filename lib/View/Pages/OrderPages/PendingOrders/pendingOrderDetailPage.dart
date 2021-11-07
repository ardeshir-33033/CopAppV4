import 'package:copapp/Controller/Controllers/Order/OrderInfoController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/Order/scorePriceOrderDetail.dart';
import 'package:copapp/View/Pages/CartPage/BottomCompeleteBuying.dart';
import 'package:easy_localization/easy_localization.dart' as lc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../OrdersDetailWidget.dart';
import 'InvoiceOrderPage.dart';

// ignore: must_be_immutable
class PendingOrdersDetailPage extends StatefulWidget {
  PendingOrdersDetailPage({required this.orderId});

  int orderId;

  @override
  _PendingOrdersDetailPageState createState() =>
      _PendingOrdersDetailPageState();
}

class _PendingOrdersDetailPageState extends State<PendingOrdersDetailPage> {
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
          title: "سبدهای خرید در انتظار پرداخت",
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                CBase().basePrimaryColor),
                          ),
                          Text("در حال دریافت")
                        ],
                      ),
                    )
                  : orderInfoController.order == null
                      ? Center(
                          child: Text(
                            "سیستم در دریافت اطلاعات با مشکل مواجه شد",
                            style: TextStyle(
                                color: CBase().textPrimaryColor,
                                fontSize:
                                    CBase().getTextfontSizeByScreen() * 1.2),
                          ),
                        )
                      : orderInfoController.order!.orderDetails!.length == 0
                          ? Center(
                              child: Text(
                                "لیست خالی است",
                                style: TextStyle(
                                    color: CBase().textPrimaryColor,
                                    fontSize:
                                        CBase().getTextfontSizeByScreen() *
                                            1.2),
                              ),
                            )
                          : orderInfoController.order!.orderDetails == null
                              ? Center(
                                  child: Text(
                                    "سیستم در دریافت اطلاعات با مشکل مواجه شد",
                                    style: TextStyle(
                                        color: CBase().textPrimaryColor,
                                        fontSize:
                                            CBase().getTextfontSizeByScreen() *
                                                1.2),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: ListView.builder(
                                            itemCount: orderInfoController
                                                .order!.orderDetails!.length,
                                            itemBuilder: (context, int index) {
                                              return OrdersDetailWidget(
                                                orderDetail: orderInfoController
                                                    .order!
                                                    .orderDetails![index],
                                                scaffold: _scaffoldKey,
                                              );
                                            })),
                                    IntrinsicHeight(
                                      child: Align(
                                        alignment:
                                            FractionalOffset.bottomCenter,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              // PendingOrdController pendingOrdController =
                                              //     Get.find();
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: CBase()
                                                              .getFullWidth(
                                                                  context) /
                                                          18,
                                                      right: CBase()
                                                              .getFullWidth(
                                                                  context) /
                                                          18,
                                                      top: 8),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x29000000),
                                                        offset: Offset(-3, 5),
                                                        blurRadius: 5,
                                                      ),
                                                    ],
                                                  ),
                                                  child: ScorePriceOrderDetail(
                                                    finalPrice:
                                                        orderInfoController
                                                            .order!.finalPrice!,
                                                    score: orderInfoController
                                                        .order!.totalScore!,
                                                  )),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: CBase()
                                                            .getFullWidth(
                                                                context) /
                                                        18,
                                                    vertical: 10),
                                                child: BottomCompleteBuying(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InvoiceOrderPage()));
                                                    },
                                                    pendingCart:
                                                        orderInfoController
                                                            .order!
                                                            .orderDetails,
                                                    orderId: orderInfoController
                                                        .order!.id),
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
