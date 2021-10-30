import 'package:copapp/Controller/Controllers/InvoiceController.dart';
import 'package:copapp/Model/Address.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/Controller/Controllers/ChooseAddController.dart';
import 'package:copapp/View/Pages/ConfirmPages/ConfirmInPerson.dart';
import 'package:easy_localization/easy_localization.dart'as lc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'AddressWidget.dart';

class AddressPayType extends StatelessWidget {
  final lc.NumberFormat nf = lc.NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  final ChooseAddressController addressController =
      Get.put(ChooseAddressController());
  final InvoiceController invoiceController = Get.find();

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
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                          .format(
                                              invoiceController.getCartSumPrice())
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
                    InkWell(
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
                            Text(
                              "ثبت",
                              style: TextStyle(
                                fontSize: CBase().getLargefontSizeByScreen(),
                                fontFamily: CBase().fontFamily,
                                color: Color(0xffff0000),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Address? address = addressController.getSelectedAddress();
                        if (addressController.getSelectedAddress() != null) {
                          Get.to(() => ConfirmInPerson(
                                items: {
                                  'شهر :': '${address!.city}',
                                  'نوع ارسال :': 'توسط CopApp',
                                  'مبدأ :': '${address.city}',
                                  'محل تخلیه :': '${address.completeAddress}',
                                },
                                addressId:
                                    addressController.getSelectedAddress()!.id!,
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
                          Get.to(() => ConfirmInPerson(
                                items: {
                                  'نحوه تحویل :': 'حضوری',
                                  'نوع ارسال :': '',
                                  'مبدأ :': '',
                                  'محل تخلیه :': '',
                                },
                                //-10 is the Id for in-person shopping - Synced with backend
                                addressId: -10,
                              ));
                        }
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
}
