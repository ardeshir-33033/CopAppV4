import 'package:copapp/Controller/Controllers/HomePageController.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/CartPage/CartPage.dart';
import 'package:copapp/View/Pages/OrderPages/ConfirmedOrders/ConfirmedOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Controller/Controllers/Cart/CartLengthController.dart';
import '../../../Controller/Controllers/General/FooterController.dart';

class MainFooterNavigation extends StatelessWidget {
  String? currentPage;

  MainFooterNavigation({this.currentPage});

  FooterController footerController = Get.put(FooterController());
  CartLengthController cartLengthController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xfff2f2f2),
          boxShadow: [
            BoxShadow(
              color: const Color(0x21000000),
              offset: Offset(1, -4),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        ),
        child: GetBuilder<FooterController>(
            id: '1',
            builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          "images/home_menu.svg",
                          fit: BoxFit.contain,
                          width: 35,
                          color: footerController.homeColor,
                        ),
                      ),
                      onTap: () {
                        if (!(currentPage == "HomePageV4")) {
                          footerController.homePress();
                          Navigator.of(context).popUntil((route) => route.isFirst);

                          // Navigator.popUntil(
                          //   context,
                          //   (route) =>
                          //       route ==
                          //       MaterialPageRoute(
                          //           builder: (context) => HomePageV4()),
                          // );
                        } else {
                          HomeController homeController = Get.find();
                          if (homeController.carNotSelected == false) {
                            homeController.backPress();
                          }
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.0),
                    child: InkWell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: GetBuilder<CartLengthController>(builder: (_) {
                            return CartServiceV2().cartHasProduct()
                                ? Stack(
                                    children: <Widget>[
                                      Container(
                                        // margin: EdgeInsets.only(top: 5.0),
                                        child: SvgPicture.asset(
                                          "images/buy_empty.svg",
                                          width: 30,
                                          height: 25,
                                          // color: Colors.grey[400],
                                          color: footerController.basketColor,
                                        ),
                                      ),
                                      Container(
                                        width: 25.0,
                                        height: 25.0,
                                        margin: EdgeInsets.only(bottom: 3),
                                        child: Center(
                                          child: Text(
                                            cartLengthController.cartLength
                                                .toString(),
                                            style: TextStyle(
                                                // color: CBase().basePrimaryColor,
                                                color: CBase().textPrimaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                      top: 5.0,
                                    ),
                                    child: SvgPicture.asset(
                                      "images/buy.svg",
                                      width: 35,
                                      // color: basketColor,
                                      color: footerController.basketColor,
                                    ),
                                  );
                          })
                          // }),
                          ),
                      onTap: () {
                        // setActiveColor(2);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CartPageV3(),
                        //   ),
                        // );
                        Get.to(() => CartPage());
                      },
                    ),
                  ),
                  Container(
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          "images/delivery_menu.svg",
                          color: footerController.deliveryColor,
                          width: 35,
                          // color: deliveryColor,
                        ),
                      ),
                      onTap: () {
                        // setActiveColor(3);
                        if (!(currentPage == "ConfirmedOrders"))
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmedOrders()
                                // Tracking(),
                                ),
                          );
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
