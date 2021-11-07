import 'package:copapp/Controller/Controllers/Order/OrderInfoController.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/General/InAppBrowser.dart';
import 'package:copapp/View/Pages/ConfirmPages/PreDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({Key? key, required this.items, required this.addressId})
      : super(key: key);
  final int addressId;

  @override
  _ConfirmPaymentState createState() => _ConfirmPaymentState();
  final Map<String, String> items;
}

class _ConfirmPaymentState extends State<ConfirmPayment>
    with WidgetsBindingObserver {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  final MyInAppBrowser browser = new MyInAppBrowser();
  OrderInfoController orderInfoController = Get.find();

  // void _launchURL(_url) async {
  //   if (await canLaunch(_url)) await launch(_url);
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

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
            Snacki().GETSnackBar(true, "عملیات موفق بود");

            ///
          } else {
            Snacki().GETSnackBar(false, "عملیات انجام نشد.");
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
                        setState(() {
                          isLoading = true;
                        });
                        await OrderServiceV2()
                            .zarrinPayOrder(orderInfoController.order!.id!,
                                addressId: widget.addressId)
                            .then((value) async {
                          if (value.isSuccess) {
                            MyInAppBrowser().setBrowser(browser);
                            await browser.openUrlRequest(
                                urlRequest: URLRequest(
                                  url: Uri.parse(value.data),
                                ),
                                options: InAppBrowserClassOptions(
                                    inAppWebViewGroupOptions:
                                        InAppWebViewGroupOptions(
                                            crossPlatform: InAppWebViewOptions(
                                  useShouldOverrideUrlLoading: true,
                                  useOnLoadResource: true,
                                ))));
                          } else
                            value.showMessage();
                        });

                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
