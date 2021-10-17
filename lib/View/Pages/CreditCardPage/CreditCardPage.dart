import 'package:copapp/Controller/Controllers/CreditCardController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'CreditCardFormatter.dart';

class CreditCardPage extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CreditCardController creditCardController = Get.put(CreditCardController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xffF6F6F6),
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: scaffoldKey,
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 16.0, left: 32.0, right: 32.0),
          child: GetBuilder<CreditCardController>(builder: (_) {
            return creditCardController.isLoading
                ? SizedBox()
                : ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0.0),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffffffff)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                    onPressed: () async {
                      if (!creditCardController.isSubmiting)
                        creditCardController.submit();
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: creditCardController.isSubmiting
                                ? Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xffff0000),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'ثبت',
                                      style: TextStyle(
                                          color: Color(0xffFF0000),
                                          fontFamily: 'Iransans',
                                          fontSize: CBase()
                                              .getTitlefontSizeByScreen()),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ));
          }),
        ),
        body: GetBuilder<CreditCardController>(builder: (_) {
          return creditCardController.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xffff0000),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 32.0, top: 16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Center(
                                        child: Text(
                                          'برای ثبت کارت بانکی لطفا شماره کارت خود را وارد کنید',
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontFamily: 'Iransans',
                                              fontSize: CBase()
                                                  .getTextfontSizeByScreen()),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'شماره کارت',
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontFamily: 'Iransans',
                                              fontSize: CBase()
                                                  .getTextfontSizeByScreen()),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 32.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Material(
                                        color: Colors.white,
                                        elevation: 5.0,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              counterText: "",
                                            ),
                                            controller: creditCardController
                                                .cardNumberController,
                                            textAlign: TextAlign.left,
                                            maxLength: 19,
                                            textDirection: TextDirection.ltr,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              new CreditCardFormatter(),
                                            ],
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'نام و نام خانوادگی',
                                          style: TextStyle(
                                              color: Color(0xff707070),
                                              fontFamily: 'Iransans',
                                              fontSize: CBase()
                                                  .getTextfontSizeByScreen()),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 32.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Material(
                                        color: Colors.white,
                                        elevation: 5.0,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              counterText: "",
                                            ),
                                            controller: creditCardController
                                                .nameController,
                                            textAlign: TextAlign.right,
                                            maxLength: 19,
                                            textDirection: TextDirection.rtl,
                                            keyboardType: TextInputType.text,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(
                                                      r'^[\u0600-\u06FF ]*$')),
                                            ],
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
