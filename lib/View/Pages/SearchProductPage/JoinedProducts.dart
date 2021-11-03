import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Controllers/Balance/BalanceItemController.dart';
import 'package:copapp/Controller/Controllers/SearchProductController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:screenshot/screenshot.dart';

import 'JoinedItems.dart';
import 'MoreFamily.dart';

class JoinedProducts extends StatelessWidget {
  JoinedProducts({required this.part, required this.index});
  final Part part;
  final int index;
  final SearchProductController searchProductController = Get.find();
  final ScreenshotController screenshotController = ScreenshotController();

  final NumberFormat nf = NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  final NumberFormat nf1 = NumberFormat.decimalPattern("fa-IR");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5.0,
        left: 10.0,
        right: 10.0,
        bottom: 5.0,
      ),
      child: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 0.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(blurRadius: 5, color: Colors.black12)
                      ]),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          part.partImage!.isNotEmpty
                              ? Container(
                                  height: 200.0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 200.0,
                                        margin: EdgeInsets.all(0.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(part.partImage!),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 200.0,
                                  margin: EdgeInsets.all(0.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('images/noimageicon.png'),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                          // Container(
                          //   child: InkWell(
                          //     child: Container(
                          //       child: Icon(
                          //         Icons.share,
                          //         color: Colors.lightBlue,
                          //       ),
                          //     ),
                          //     onTap: () async {
                          //       await Sharei().sharePartScreenshot(
                          //           screenshotController,
                          //           searchProductController.part!);
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                          left: 10.0,
                          bottom: 7.5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    // "ardeshir gave",
                                    part.name!,
                                    style: TextStyle(
                                      fontSize:
                                          CBase().getTitlefontSizeByScreen(),
                                      color: CBase().textPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              (part.vehiclePersianName ?? ' ').toPersianDigit(),
                              style: TextStyle(
                                fontSize: CBase().getSubTitlefontSizeByScreen(),
                                color: CBase().basePrimaryColor,
                                letterSpacing: -0.26,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          GetBuilder<BalanceItemController>(
                            id: "search",
                            builder: (_) {
                              return JoinedItems(
                                bal: part.products?.first,
                              );
                            },
                          )
                        ],
                      ),
                      Visibility(
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: searchProductController.allJoinVis[index],
                        child: part.products != null
                            ? Column(
                                children: part.products!
                                    .skip(1)
                                    .map(
                                      (e) => JoinedItems(
                                        bal: e,
                                      ),
                                    )
                                    .toList(),
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          part.products != null //&&
              // part.products!.first.productVirtualQTY != 0 &&
              // part.products!.first.productInfosPrice != 0
              ? MoreFamily(
                  index: index,
                  vis: searchProductController.allJoinVis[index],
                  familyCount: part.products!.length - 1,
                )
              : SizedBox(
                  width: 1.0,
                ),
        ],
      ),
    );
  }
}
