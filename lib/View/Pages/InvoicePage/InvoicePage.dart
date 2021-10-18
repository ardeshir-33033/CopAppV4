import 'package:copapp/Controller/Controllers/InvoiceController.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:easy_localization/easy_localization.dart'as lc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:screenshot/screenshot.dart';

import 'InvoicePageWidget.dart';
import 'WhiteButton.dart';

class InvoicePage extends StatelessWidget {
  final InvoiceController invoiceController = Get.find();
  final lc.NumberFormat nf = lc.NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceController>(builder: (_) {
      return Screenshot(
        controller: invoiceController.screenshotController,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            key: invoiceController.scaffoldKey,
            drawer: AppDrawer(
              scaffoldKey: invoiceController.scaffoldKey,
            ),
            appBar: CustomAppBar(
              scaffoldKey: invoiceController.scaffoldKey,
            ),
            body: invoiceController.isLoading
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
                        child: CartServiceV2().cartHasProduct() ||
                                invoiceController.cart.isNotEmpty
                            ? ListView.builder(
                                controller: invoiceController.scrollController,
                                itemCount: invoiceController.cart.length,
                                itemBuilder: (context, int index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: InvoiceWidget(
                                      item: invoiceController.cart[index],
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
                                (invoiceController.cart.length.toString())
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
                                nf.format(invoiceController.getCartSumPrice()),
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
                              invoiceController.confirm();
                            },
                          ),
                          WhiteButton(
                            text: 'اصلاح',
                            color: CBase().textPrimaryColor,
                            onTapCallback: (v) {
                              // shareScreenshot();
                              Navigator.pop(context);
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
