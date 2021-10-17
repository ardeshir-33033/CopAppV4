import 'package:copapp/Controller/Controllers/SendCartController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'PlateWidget.dart';

class SendingCartCustomerWidget extends StatefulWidget {
  SendingCartCustomerWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SendingCartCustomerWidgetState createState() =>
      _SendingCartCustomerWidgetState();
}

class _SendingCartCustomerWidgetState extends State<SendingCartCustomerWidget> {
  SendCartController sendCartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: sendCartController.isLoading
          ? Container(
              width: 100,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xffff0000)),
                  ),
                ),
              ),
            )
          : InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 5),
                height: CBase().getFullHeight(context) / 16,
                width: CBase().getFullWidth(context) / 2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
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
                sendCartController.confirmSend();
              },
            ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // constraints: BoxConstraints(minHeight: 100),
              height: CBase().getFullHeight(context) / 3.1,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(3, 3),
                      blurRadius: 6)
                ],
              ),
              child: Column(
                // direction: Axis.vertical,
                children: [
                  Container(
                      height: CBase().getFullHeight(context) / 17,
                      // flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: sendCartController.controller1,
                            style: TextStyle(color: CBase().textPrimaryColor),
                            decoration: InputDecoration(
                              hintText: "نام و نام خانوادگی:",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: CBase().textPrimaryColor,
                                  fontSize: CBase().getTitlefontSizeByScreen()),
                            ),
                          )),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "ضروری",
                              style: TextStyle(
                                  color: Color(0xffff0000),
                                  fontSize: CBase().getTextfontSizeByScreen()),
                            ),
                          )
                        ],
                      )),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: CBase().borderPrimaryColor,
                  ),
                  Container(
                      height: CBase().getFullHeight(context) / 17,

                      // flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: sendCartController.controller2,
                            style: TextStyle(color: CBase().textPrimaryColor),
                            decoration: InputDecoration(
                              hintText: "شماره همراه:",
                              hintStyle: TextStyle(
                                  color: CBase().textPrimaryColor,
                                  fontSize: CBase().getTitlefontSizeByScreen()),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                          )),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "ضروری",
                              style: TextStyle(
                                  color: Color(0xffff0000),
                                  fontSize: CBase().getTextfontSizeByScreen()),
                            ),
                          )
                        ],
                      )),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: CBase().borderPrimaryColor,
                  ),
                  Container(
                      height: CBase().getFullHeight(context) / 17,

                      // flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: sendCartController.controller3,
                            style: TextStyle(color: CBase().textPrimaryColor),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "خودرو:",
                              hintStyle: TextStyle(
                                  color: CBase().textPrimaryColor,
                                  fontSize: CBase().getTitlefontSizeByScreen()),
                            ),
                          ))
                        ],
                      )),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: CBase().borderPrimaryColor,
                  ),
                  Container(
                      height: CBase().getFullHeight(context) / 17,

                      // flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: sendCartController.controller4,
                            style: TextStyle(color: CBase().textPrimaryColor),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "رنگ خودرو:",
                              hintStyle: TextStyle(
                                  color: CBase().textPrimaryColor,
                                  fontSize: CBase().getTitlefontSizeByScreen()),
                            ),
                          ))
                        ],
                      )),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: CBase().borderPrimaryColor,
                  ),
                  Container(
                      height: CBase().getFullHeight(context) / 17,

                      // flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "پلاک:",
                            style: TextStyle(
                                color: CBase().textPrimaryColor,
                                fontSize: CBase().getTitlefontSizeByScreen()),
                          ),
                          PlateWidget(
                            textEditingController1:
                                sendCartController.controllerplate1,
                            textEditingController2:
                                sendCartController.controllerplate2,
                            textEditingController3:
                                sendCartController.controllerplate3,
                            textEditingController4:
                                sendCartController.controllerplate4,
                          )
                        ],
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
