import 'package:copapp/Controller/Controllers/General/AppDrawerController.dart';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:copapp/View/Pages/AboutUsPage/AboutUsPage.dart';
import 'package:copapp/View/Pages/AccessPointsPage/AccessPointsPage.dart';
import 'package:copapp/View/Pages/AddressPages/AddressPage.dart';
import 'package:copapp/View/Pages/CartPage/CartPage.dart';
import 'package:copapp/View/Pages/ContactUsPage/ContactUs.dart';
import 'package:copapp/View/Pages/CreditCardPage/CreditCardPage.dart';
import 'package:copapp/View/Pages/EpcPages/HomePage.dart';
import 'package:copapp/View/Pages/FinancialPages/Financial.dart';
import 'package:copapp/View/Pages/InquiryPage/InquiryCartPage.dart';
import 'package:copapp/View/Pages/OrderPages/ConfirmedOrders/ConfirmedOrders.dart';
import 'package:copapp/View/Pages/OrderPages/PendingOrders/PendingOrders.dart';
import 'package:copapp/View/Pages/OrderPages/SendingOrders/SendingOrders.dart';
import 'package:copapp/View/Pages/ProfilePage/UserInformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Divider.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final AppDrawerController appDrawerController = Get.put(AppDrawerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CBase().getFullWidth(context) / 2,
      child: Drawer(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff4d4d4d),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: CBase().baseYellowColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Text(
                          UserServiceV2.user?.fullName ?? "",
                          style: TextStyle(
                              fontSize: CBase().getTextfontSizeByScreen() * 1.2,
                              color: CBase().baseYellowColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: CBase().getFullHeight(context) / 30,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartPage()));
                    },
                    title: Text(
                      "?????? ????????",
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen() * 1.2,
                          color: CBase().baseYellowColor),
                    ),
                  ),
                  KDivider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InquiryCartPage()));
                    },
                    title: Text(
                      "?????? ??????????",
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen() * 1.2,
                          color: CBase().baseYellowColor),
                    ),
                  ),
                  KDivider(),
                  ListTile(
                    onTap: () {
                      appDrawerController.profileSelected();
                    },
                    title: Text(
                      "?????????????? ????????????",
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen() * 1.2,
                          color: CBase().baseYellowColor),
                    ),
                  ),
                  KDivider(),
                  GetBuilder<AppDrawerController>(
                      id: "profile",
                      builder: (_) {
                        return Visibility(
                          visible: appDrawerController.profileVis,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Get.to(() => AccessPointsPage());
                                  },
                                  title: Text("?????????? ????????????????",
                                      style: TextStyle(
                                          fontSize: CBase()
                                                  .getTextfontSizeByScreen() *
                                              1.2,
                                          color: Colors.white)),
                                ),
                                WDivider(),
                                ListTile(
                                  onTap: () {
                                    Get.to(() => Financial());
                                  },
                                  title: Text("?????? ????????",
                                      style: TextStyle(
                                          fontSize: CBase()
                                                  .getTextfontSizeByScreen() *
                                              1.2,
                                          color: Colors.white)),
                                ),
                                WDivider(),
                                ListTile(
                                  onTap: () {
                                    Get.to(() => UserInformationPage());
                                  },
                                  title: Text("?????????????? ????????",
                                      style: TextStyle(
                                          fontSize: CBase()
                                                  .getTextfontSizeByScreen() *
                                              1.2,
                                          color: Colors.white)),
                                ),
                                WDivider(),
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddressPage()));
                                  },
                                  title: Text("???????? ???????????? ??????????",
                                      style: TextStyle(
                                          fontSize: CBase()
                                                  .getTextfontSizeByScreen() *
                                              1.2,
                                          color: Colors.white)),
                                ),
                                WDivider(),
                                ListTile(
                                  onTap: () {
                                    Get.to(() => CreditCardPage());
                                  },
                                  title: Text("?????????? ????????",
                                      style: TextStyle(
                                          fontSize: CBase()
                                                  .getTextfontSizeByScreen() *
                                              1.2,
                                          color: Colors.white)),
                                ),
                                WDivider(),
                              ],
                            ),
                          ),
                        );
                      }),
                  ListTile(
                    onTap: () {
                      appDrawerController.ordersSelected();
                    },
                    title: Text("??????????????",
                        style: TextStyle(
                            fontSize: CBase().getTextfontSizeByScreen() * 1.2,
                            color: CBase().baseYellowColor)),
                  ),
                  KDivider(),
                  GetBuilder<AppDrawerController>(
                      id: "order",
                      builder: (_) {
                        return Visibility(
                          visible: appDrawerController.sefareshVis,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                      Get.to(() => PendingOrders());
                                  },
                                  title: Text("???? ???????????? ????????????",
                                      style: TextStyle(
                                          fontSize: CBase()
                                                  .getTextfontSizeByScreen() *
                                              1.2,
                                          color: Colors.white)),
                                ),
                                WDivider(),
                                ListTile(
                                  onTap: () {
                                    Get.to(() => ConfirmedOrders());
                                  },
                                  title: Text("???????????? ??????",
                                      style: TextStyle(
                                          fontSize: CBase()
                                                  .getTextfontSizeByScreen() *
                                              1.2,
                                          color: Colors.white)),
                                ),
                                WDivider(),
                                ListTile(
                                  onTap: () {
                                    Get.to(() => SendingOrders());
                                  },
                                  title: Text("???? ?????? ??????????",
                                      style: TextStyle(
                                          fontSize: CBase()
                                                  .getTextfontSizeByScreen() *
                                              1.2,
                                          color: Colors.white)),
                                ),
                                WDivider(),
                              ],
                            ),
                          ),
                        );
                      }),
                  ListTile(
                    onTap: () {
                      Get.to(() => EpcHome());
                    },
                    title: Text(
                      "EPC",
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen() * 1.2,
                          color: CBase().baseYellowColor),
                    ),
                  ),
                  KDivider(),
                  ListTile(
                    onTap: () {
                      Get.to(() => AboutUsPage());
                    },
                    title: Text(
                      "???????????? ????",
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen() * 1.2,
                          color: CBase().baseYellowColor),
                    ),
                  ),
                  KDivider(),
                  ListTile(
                    onTap: () {
                      Get.to(() => ContactUs());
                    },
                    title: Text(
                      "???????????? ???? ????",
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen() * 1.2,
                          color: CBase().baseYellowColor),
                    ),
                  ),
                  KDivider(),
                  ListTile(
                    onTap: () async {
                      appDrawerController.exitPressed();
                      await Snacki().showExitSnack(
                        scaffoldKey,
                      );
                    },
                    title: Text("????????",
                        style: TextStyle(
                            fontSize: CBase().getTextfontSizeByScreen() * 1.2,
                            color: CBase().baseYellowColor)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

