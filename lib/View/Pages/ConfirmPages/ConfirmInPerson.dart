import 'package:copapp/Controller/Controllers/InvoiceController.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/General/InAppBrowser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'PreDataWidget.dart';

class ConfirmInPerson extends StatefulWidget {
  const ConfirmInPerson(
      {Key? key, required this.items, required this.addressId})
      : super(key: key);
  final int addressId;

  @override
  _ConfirmInPersonState createState() => _ConfirmInPersonState();
  final Map<String, String> items;
}

class _ConfirmInPersonState
    extends State<ConfirmInPerson> // with WidgetsBindingObserver
{
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  final MyInAppBrowser browser = new MyInAppBrowser();
  InvoiceController invoiceController = Get.find();

  // void _launchURL(_url) async {
  //   if (await canLaunch(_url)) await launch(_url);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance?.addObserver(this);
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance?.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (OrderServiceV2().getAuthority() != "") {
        var result = await OrderServiceV2().verify();
        OrderServiceV2().setAuthority("");
        if (!result.isSuccess) {
          result.showMessage();
        } else {
          OrderHeader payedOrder = OrderHeader.fromJson(result.data);
          if (payedOrder.orderStatusId == "confirmed" ||
              payedOrder.orderStatusId == "packing") {
            ShowMessage(isSuccess: true, message: "عملیات موفق بود");
            CartServiceV2().getCart();

            ///
          } else {
            ShowMessage(isSuccess: false, message: "عملیات انجام نشد.");
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xffF6F6F6),
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        drawer: AppDrawer(
          scaffoldKey: _scaffoldKey,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PreviousDataWidget(
              items: widget.items,
            ),
            Padding(
              padding: EdgeInsets.only(right: 25.0, left: 25.0, bottom: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.0),
                        height: CBase().getFullHeight(context) * 0.06,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                          child: isLoading == true
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      CBase().basePrimaryColor),
                                )
                              : Text(
                                  'تأیید',
                                  style: TextStyle(
                                      color: Color(0xffFF0000),
                                      fontFamily: 'Iransans',
                                      fontSize:
                                          CBase().getTitlefontSizeByScreen()),
                                ),
                        ),
                      ),
                      onTap: () async {
                        var result;
                        setState(() {
                          isLoading = true;
                        });
                        if (invoiceController.orderId != null) {
                          result = await OrderServiceV2().zarrinPayOrder(
                              invoiceController.orderId!,
                              addressId: widget.addressId);
                        } else {
                          result =
                              await CartServiceV2().payment(widget.addressId);
                        }
                        setState(() {
                          isLoading = false;
                        });

                        if (result!.isSuccess) {
                          MyInAppBrowser().setBrowser(browser);
                          await browser.openUrlRequest(
                              urlRequest: URLRequest(
                                url: Uri.parse(result.data),
                              ),
                              options: InAppBrowserClassOptions(
                                  inAppWebViewGroupOptions:
                                      InAppWebViewGroupOptions(
                                          crossPlatform: InAppWebViewOptions(
                                useShouldOverrideUrlLoading: true,
                                useOnLoadResource: true,
                              ))));

                          // await _launchURL(result.data);
                        } else {
                          result.showMessage(_scaffoldKey);
                        }
                      },
                    ),
                    flex: 1,
                  ),
                  // Expanded(
                  //   child: InkWell(
                  //     onTap: () {
                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: (context) => ShippingAddress(
                  //       //           address: widget.address,
                  //       //         )));
                  //     },
                  //     child: Container(
                  //       margin: EdgeInsets.only(right: 5.0),
                  //       height: CBase().getFullHeight(context) * 0.06,
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           border: Border.all(width: 1, color: Colors.white),
                  //           borderRadius: BorderRadius.circular(5.0)),
                  //       child: Center(
                  //         child: Text(
                  //           'اصلاح',
                  //           style: TextStyle(
                  //               color: Color(0xff5E5E5E),
                  //               fontFamily: 'Iransans',
                  //               fontSize: CBase().getTitlefontSizeByScreen()),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //   flex: 1,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ShowMessage({bool? isSuccess, String? message}) {
    final snackBar = SnackBar(
      content: Container(
        height: 50.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isSuccess! ? "عملیات موفق" : "عملیات ناموفق",
              style: TextStyle(
                fontSize: CBase().getTextfontSizeByScreen(),
                fontWeight: FontWeight.bold,
                color:
                    isSuccess ? CBase().successColor : CBase().basePrimaryColor,
              ),
            ),
            Text(
              message!,
              style: TextStyle(
                fontSize: CBase().getTextfontSizeByScreen(),
              ),
            ),
          ],
        ),
      ),
    );

    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }
}
