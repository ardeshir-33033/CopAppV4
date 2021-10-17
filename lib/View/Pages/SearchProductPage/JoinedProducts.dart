import 'package:copapp/Controller/Controllers/SearchProductController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'JoinedItems.dart';
import 'MoreFamily.dart';

class JoinedProducts extends StatelessWidget {
  SearchProductController searchProductController = Get.find();
  ScreenshotController screenshotController = ScreenshotController();

  NumberFormat nf = NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  NumberFormat nf1 = NumberFormat.decimalPattern("fa-IR");

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
                          searchProductController.part != null &&
                                  searchProductController
                                      .part!.thumbImagePath!.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    // ProductWidgets().showDialog(
                                    //     context, widget.scaffold, [
                                    //   ProductImage(
                                    //     id: 1,
                                    //     path: widget.bal?.imagePath ?? "",
                                    //   )
                                    // ]);
                                  },
                                  child: Container(
                                    height: 200.0,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 200.0,
                                          margin: EdgeInsets.all(0.0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  searchProductController
                                                      .part!.thumbImagePath!),
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 200.0,
                                  margin: EdgeInsets.all(0.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'images/noimageicon.png'),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // InkWell(
                            //   child:
                            //   onTap: () {
                            //     ProductWidgets()
                            //         .showDialog(context, widget.scaffold, [
                            //       ProductImage(
                            //         id: 1,
                            //         path: widget.bal?.imagePath ?? "",
                            //       )
                            //     ]);
                            //   },
                            // ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    searchProductController.part!.name!,
                                    style: TextStyle(
                                      fontSize:
                                          CBase().getTitlefontSizeByScreen(),
                                      color: CBase().textPrimaryColor,
                                      letterSpacing: -0.26,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    (searchProductController
                                                .part?.vehiclePersianName ??
                                            ' ')
                                        .toPersianDigit(),
                                    style: TextStyle(
                                      fontSize: CBase()
                                          .getSubTitlefontSizeByScreen(),
                                      color: CBase().basePrimaryColor,
                                      letterSpacing: -0.26,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              maintainSize: false,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: searchProductController.isLoadingJoin,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  accentColor: CBase().basePrimaryColor,
                                ),
                                child: Container(
                                  width: 20.0,
                                  height: 20.0,
                                  margin: EdgeInsets.only(right: 10),
                                  child: searchProductController.isLoadingJoin
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  CBase().basePrimaryColor),
                                        )
                                      : Text(""),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          JoinedItems(
                            bal:
                                searchProductController.part?.products?.first,
                          )
                        ],
                      ),
                      Visibility(
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: searchProductController.allJoinVis,
                        child: searchProductController.part!.products != null
                            ? Column(
                                children:
                                    searchProductController.part!.products!
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
          searchProductController.part!.products != null &&
                  searchProductController.part!.products!.length > 0 &&
                  searchProductController
                          .part!.products!.first.productVirtualQTY !=
                      0 &&
                  searchProductController
                          .part!.products!.first.productInfosPrice !=
                      0
              ? MoreFamily(
                  fvis: searchProductController.allJoinVis,
                  familyCount: searchProductController.part!.products!.length-1,
                )
              : SizedBox(
                  width: 1.0,
                ),
        ],
      ),
    );
  }
}
