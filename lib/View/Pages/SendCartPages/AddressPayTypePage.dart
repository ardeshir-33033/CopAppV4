import 'package:copapp/Controller/Controllers/InvoiceController.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/Address.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/Controller/Controllers/ChooseAddController.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:copapp/View/Components/General/InAppBrowser.dart';
import 'package:copapp/View/Pages/ConfirmPages/ConfirmInPerson.dart';
import 'package:easy_localization/easy_localization.dart' as lc;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'AddressWidget.dart';

class AddressPayType extends StatefulWidget {
  @override
  _AddressPayTypeState createState() => _AddressPayTypeState();
}

class _AddressPayTypeState extends State<AddressPayType>
    with WidgetsBindingObserver {
  final lc.NumberFormat nf = lc.NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );
  final MyInAppBrowser browser = new MyInAppBrowser();
  final ChooseAddressController addressController =
      Get.put(ChooseAddressController());

  final InvoiceController invoiceController = Get.find();

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
            CartServiceV2().getCart();

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
      child: GetBuilder<ChooseAddressController>(builder: (_) {
        return SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Expanded(child: SingleChildScrollView(child: AddressWidget())),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      alignment: FractionalOffset.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(-3, 5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  " تعداد اقلام " +
                                      invoiceController.cart.length
                                          .toString()
                                          .toPersianDigit() +
                                      ' عدد',
                                  style: TextStyle(
                                      color: CBase().textPrimaryColor,
                                      fontSize:
                                          CBase().getTextfontSizeByScreen()),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  " مبلغ کل خرید ",
                                  style: TextStyle(
                                      color: CBase().textPrimaryColor,
                                      fontSize:
                                          CBase().getTextfontSizeByScreen()),
                                ),
                                Text(
                                  nf
                                          .format(invoiceController
                                              .getCartSumPrice())
                                          .toString() +
                                      " تومان",
                                  style: TextStyle(
                                      color: CBase().textPrimaryColor,
                                      fontSize:
                                          CBase().getTextfontSizeByScreen()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<ChooseAddressController>(
                      id: 'loading',
                      builder: (_) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10, top: 20),
                            width: CBase().getFullWidth(context) / 2.5,
                            height: CBase().getFullHeight(context) / 15,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                addressController.isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  CBase().basePrimaryColor),
                                        ),
                                      )
                                    : Text(
                                        "ثبت",
                                        style: TextStyle(
                                          fontSize: CBase()
                                              .getLargefontSizeByScreen(),
                                          fontFamily: CBase().fontFamily,
                                          color: Color(0xffff0000),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          onTap: () {
                            if (!addressController.isLoading) {
                              Address? address =
                                  addressController.getSelectedAddress();
                              if (addressController.getSelectedAddress() !=
                                  null) {
                                Get.to(() => ConfirmInPerson(
                                      items: {
                                        'شهر :': '${address!.city}',
                                        'نوع ارسال :': 'توسط CopApp',
                                        'مبدأ :': '${address.city}',
                                        'محل تخلیه :':
                                            '${address.completeAddress}',
                                      },
                                      addressId: addressController
                                          .getSelectedAddress()!
                                          .id!,
                                    ));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ConfirmPorterage(
                                //           address: address,
                                //           confirmTerminal: AllShippers(
                                //               shipperName: 'تهران',
                                //               shipperDistinations: [
                                //                 ShipperDestination(
                                //                     distinationSummary:
                                //                     address.city)
                                //               ]),
                                //         )));
                              } else {
                                pay();
                                // Get.to(() => ConfirmInPerson(
                                //       items: {
                                //         'نحوه تحویل :': 'حضوری',
                                //         'نوع ارسال :': '',
                                //         'مبدأ :': '',
                                //         'محل تخلیه :': '',
                                //       },
                                //       //-10 is the Id for in-person shopping - Synced with backend
                                //       addressId: -10,
                                //     ));
                              }
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ),
        );
      }),
    );
  }

  void pay() async {
    addressController.setLoading(true);
    // -10 is the Id for in-person shopping - Synced with backend
    await CartServiceV2().payment(-10)!.then((value) async {
      if (value.isSuccess) {
        MyInAppBrowser().setBrowser(browser);
        await browser.openUrlRequest(
            urlRequest: URLRequest(
              url: Uri.parse(value.data),
            ),
            options: InAppBrowserClassOptions(
                inAppWebViewGroupOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              useOnLoadResource: true,
            ))));
        addressController.setLoading(false);
      } else
        value.showMessage();
      addressController.setLoading(false);
    });
  }
}
