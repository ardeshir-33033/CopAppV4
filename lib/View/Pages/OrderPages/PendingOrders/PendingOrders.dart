import 'package:copapp/Controller/Controllers/PendingOrdController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/MainFooter.dart';
import 'package:copapp/View/Pages/OrderPages/OrdersV2Widget.dart';
import 'package:copapp/View/Pages/OrderPages/PendingOrders/pendingOrderDetailPage.dart';
import 'package:copapp/View/Widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class PendingOrders extends StatelessWidget {
  final PendingOrdController pendingOrdController =
      Get.put(PendingOrdController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        bottomNavigationBar: MainFooterNavigation(),
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),
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
                    'سبد های خرید در انتظار پرداخت',
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
          leading: DrawerWidget(scaffoldKey: scaffoldKey),
        ),
        body: GetBuilder<PendingOrdController>(builder: (_) {
          return SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    flex: 10,
                    child: pendingOrdController.pendingOrders == null
                        ? Center(
                            child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                CBase().basePrimaryColor),
                          ))
                        : pendingOrdController.pendingOrders?.length != 0
                            ? ListView.builder(
                                itemCount:
                                    pendingOrdController.pendingOrders!.length,
                                itemBuilder: (context, int index) {
                                  return OrdersV2Widget(
                                    item: pendingOrdController
                                        .pendingOrders![index],
                                    pageTitle: "در انتظار پرداخت",
                                    tapFunc: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PendingOrdersDetailPage(
                                                      finalScore:
                                                          pendingOrdController
                                                              .pendingOrders![
                                                                  index]
                                                              .totalScore!,
                                                      finalPrice:
                                                          pendingOrdController
                                                              .pendingOrders![
                                                                  index]
                                                              .finalPrice!,
                                                      orderId: pendingOrdController.pendingOrders![index].id!)
                                              // OrdersDetail(
                                              //   orderDetails:
                                              //       pendingOrdController
                                              //           .pendingOrders![
                                              //               index]
                                              //           .orderDetails,
                                              //   orderId:
                                              //       pendingOrdController
                                              //           .pendingOrders![
                                              //               index]
                                              //           .id,
                                              //   type: 1,
                                              // )
                                              ));
                                    },
                                  );
                                })
                            : Center(child: Text("سبدی وجود ندارد")))
              ],
            ),
          );
        }),
      ),
    );
  }
}
