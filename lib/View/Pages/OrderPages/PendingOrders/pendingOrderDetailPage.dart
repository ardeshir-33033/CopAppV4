import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Controller/Controllers/PendingOrdController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Pages/CartPage/BottomCompeleteBuying.dart';
import 'package:easy_localization/easy_localization.dart' as lc;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PendingOrdersDetailPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  lc.NumberFormat nf = lc.NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  ScoreService scoreController = Get.find();

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
          child: Column(
            children: [
              // Expanded(
              //   flex: 5,
              //   child: ListView.builder(
              //       itemCount: orderDetails!.length,
              //       itemBuilder: (context, int index) {
              //         return type == 1 || type == 3
              //             ? OrdersDetailWidget(
              //           orderDetail: orderDetails![index],
              //           scaffold: _scaffoldKey,
              //         )
              //             : SizedBox()
              //         //  ConfirmedOrdersDetailWidget(
              //         //     orderDetail: widget.orderDetails[index],
              //         //     scaffold: _scaffoldKey,
              //         //     onTapCallback: () {
              //         //       setState(() {});
              //         //     },
              //         //   )
              //             ;
              //       }),
              // ),
              IntrinsicHeight(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    child: Column(
                      children: [
                        GetBuilder<ScoreService>(builder: (_) {
                          PendingOrdController pendingOrdController =
                              Get.find();
                          return Container(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("قیمت کل"),
                                      Row(
                                        children: [
                                          // Text(nf
                                          //     .format(pendingOrdController
                                          //     .getOrderFinalPrice(
                                          //     orderId!))
                                          //     .toString()),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: SvgPicture.string(
                                              CBase.toman,
                                              color: Colors.black,
                                              height: 20.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                scoreController.getShowScore()
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Divider(
                                          color: CBase().borderPrimaryColor,
                                          height: 1,
                                        ),
                                      )
                                    : SizedBox(),
                                scoreController.getShowScore()
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("جمع امتیاز"),
                                            // Text(
                                            //   "${nf.format(getTotalScore(orderDetails!))} امتیاز",
                                            // )
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          );
                        }),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: CBase().getFullWidth(context) / 18,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}