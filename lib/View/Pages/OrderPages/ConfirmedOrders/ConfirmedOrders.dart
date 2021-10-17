import 'package:copapp/Controller/Controllers/ConfirmedOrdController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/MainFooter.dart';
import 'package:copapp/View/Widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../OrdersV2Widget.dart';

class ConfirmedOrders extends StatelessWidget {
  ConfirmedOrdController confirmedOrdController =
      Get.put(ConfirmedOrdController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),
        bottomNavigationBar: MainFooterNavigation(),
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
          leading: DrawerWidget(scaffoldKey: scaffoldKey),
        ),
        body: GetBuilder<ConfirmedOrdController>(builder: (_) {
          return SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    flex: 10,
                    child: confirmedOrdController.confirmedOrders == null
                        ? Center(
                            child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                CBase().basePrimaryColor),
                          ))
                        : confirmedOrdController.confirmedOrders?.length != 0
                            ? ListView.builder(
                                itemCount: confirmedOrdController
                                    .confirmedOrders!.length,
                                itemBuilder: (context, int index) {
                                  return OrdersV2Widget(
                                    item: confirmedOrdController
                                        .confirmedOrders![index],
                                    type: 2,
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
