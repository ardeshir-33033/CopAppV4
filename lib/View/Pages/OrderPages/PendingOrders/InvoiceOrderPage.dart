
import 'package:copapp/Controller/Controllers/Order/OrderInfoController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Pages/InvoicePage/WhiteButton.dart';
import 'package:easy_localization/easy_localization.dart'as lc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:screenshot/screenshot.dart';
import 'InvoicePageWidget.dart';

class InvoiceOrderPage extends StatelessWidget {
  final OrderInfoController orderInfoController = Get.find();
      final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final lc.NumberFormat nf = lc.NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderInfoController>(builder: (_) {
      return Screenshot(
        controller: orderInfoController.screenshotController,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            key: scaffoldKey,
            drawer: AppDrawer(
              scaffoldKey: scaffoldKey,
            ),
            appBar: CustomAppBar(
              scaffoldKey: scaffoldKey,
            ),
            body: orderInfoController.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xffff0000),
                      ),
                    ),
                  )
                : SafeArea(
                    child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: CBase().getFullHeight(context) / 18,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    'ردیف',
                                    style: TextStyle(
                                      fontSize:
                                          CBase().getTitlefontSizeByScreen(),
                                      color: CBase().textPrimaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4.5,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: VerticalDivider(
                                color: CBase().borderPrimaryColor,
                                width: 1,
                              ),
                            ),
                            SizedBox(
                              width: 4.5,
                            ),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "نام محصول",
                                  style: TextStyle(
                                    fontSize: CBase().getTitlefontSizeByScreen(),
                                    color: CBase().textPrimaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4.5,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: VerticalDivider(
                                color: CBase().borderPrimaryColor,
                                width: 1,
                              ),
                            ),
                            SizedBox(
                              width: 4.5,
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "تعداد",
                                  style: TextStyle(
                                    fontSize: CBase().getTitlefontSizeByScreen(),
                                    color: CBase().textPrimaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                            SizedBox(
                              width: 4.5,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: VerticalDivider(
                                color: CBase().borderPrimaryColor,
                                width: 1,
                              ),
                            ),
                            SizedBox(
                              width: 4.5,
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                "قیمت",
                                style: TextStyle(
                                  fontSize: CBase().getTitlefontSizeByScreen(),
                                  color: CBase().textPrimaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Divider(
                                  color: CBase().borderPrimaryColor,
                                  height: 1,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 8,
                                child: Divider(
                                  color: CBase().borderPrimaryColor,
                                  height: 1,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 2,
                                child: Divider(
                                  color: CBase().borderPrimaryColor,
                                  height: 1,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 4,
                                child: Divider(
                                  color: CBase().borderPrimaryColor,
                                  height: 1,
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: 
                                orderInfoController.order!.orderDetails!.isNotEmpty
                            ? ListView.builder(
                                controller: orderInfoController.scrollController,
                                itemCount: orderInfoController.order!.orderDetails!.length,
                                itemBuilder: (context, int index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: InvoiceWidget(
                                      item: orderInfoController.order!.orderDetails![index],
                                      id: index + 1,
                                    ),
                                  );
                                })
                            : Container(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Text(
                                  "قیمت کل",
                                  style: TextStyle(
                                    fontSize: CBase().getTitlefontSizeByScreen(),
                                    color: CBase().textPrimaryColor,
                                    letterSpacing: -0.065,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                (orderInfoController.order!.orderDetails!.length.toString())
                                    .toPersianDigit(),
                                style: TextStyle(
                                  fontSize: CBase().getTextfontSizeByScreen() + 1,
                                  color: CBase().textPrimaryColor,
                                  letterSpacing: -0.065,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                // CartServiceV2().getCartTotalPrice()
                                nf.format(orderInfoController.getCartFinalPrice()),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                  fontSize: CBase().getTextfontSizeByScreen() + 1,
                                  color: CBase().textPrimaryColor,
                                  letterSpacing: -0.065,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          WhiteButton(
                            text: 'تایید',
                            color: CBase().basePrimaryLightColor,
                            onTapCallback: (v) {
                              orderInfoController.confirmFactor();
                            },
                          ),
                          
                        ],
                      )
                    ],
                  )),
          ),
        ),
      );
    });
  }
}
