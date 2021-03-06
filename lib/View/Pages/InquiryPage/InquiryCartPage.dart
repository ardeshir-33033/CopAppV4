import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Controller/Controllers/Inquiry/InquiryController.dart';
import 'package:copapp/Controller/Controllers/Inquiry/InquiryItemController.dart';
import 'package:copapp/Controller/Service/InquiryService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/Inquiry/InquiryItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart' as lc;

class InquiryCartPage extends StatelessWidget {
  InquiryCartPage({Key? key}) : super(key: key);
  final ScoreService scoreController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final InquiryCartController inquiryController = Get.find();
  final lc.NumberFormat nf = lc.NumberFormat.currency(
    locale: "fa-IR",
    symbol: "",
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: scaffoldKey,
        ),
        body: SafeArea(
          child: GetBuilder<InquiryCartController>(builder: (_) {
            return inquiryController.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
                  ))
                : InquiryService().getInquiryCart() != null
                    ? GetBuilder<InquiryItemController>(
                        id: 1,
                        builder: (_) {
                          return InquiryService()
                                  .getInquiryCart()!
                                  .details
                                  .isNotEmpty
                              ? Column(
                                  children: [
                                    Expanded(
                                        flex: 8,
                                        child: ListView.builder(
                                            itemCount: InquiryService()
                                                .getInquiryCart()!
                                                .details
                                                .length,
                                            itemBuilder: (context, i) {
                                              return InquiryService()
                                                          .getInquiryCart()!
                                                          .details[i].product!
                                                          .detailQTY! >
                                                      0
                                                  ? InquiryItem(
                                                      scaffold: scaffoldKey,
                                                      bal: InquiryService()
                                                          .getInquiryCart()!
                                                          .details[i]
                                                          .product,
                                                    )
                                                  : SizedBox();
                                            })),
                                    IntrinsicHeight(
                                      child: Align(
                                        alignment:
                                            FractionalOffset.bottomCenter,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 10,
                                                    left: 20,
                                                    right: 20),
                                                child: Column(
                                                  children: [
                                                    // Container(
                                                    //   alignment: FractionalOffset
                                                    //       .bottomCenter,
                                                    //   decoration: BoxDecoration(
                                                    //     color: Colors.white,
                                                    //     borderRadius:
                                                    //         BorderRadius.circular(
                                                    //             10.0),
                                                    //     boxShadow: [
                                                    //       BoxShadow(
                                                    //         color: Colors.black12,
                                                    //         blurRadius: 5,
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    //   child:
                                                    //       GetBuilder<ScoreService>(
                                                    //           builder: (_) {
                                                    //     return Column(
                                                    //       children: [
                                                    //         SizedBox(
                                                    //           height: 5,
                                                    //         ),
                                                    //         Container(
                                                    //           margin: EdgeInsets
                                                    //               .symmetric(
                                                    //                   horizontal:
                                                    //                       20),
                                                    //           child: Row(
                                                    //             mainAxisAlignment:
                                                    //                 MainAxisAlignment
                                                    //                     .spaceBetween,
                                                    //             children: [
                                                    //               Text("???????? ????"),
                                                    //               Text(nf
                                                    //                       .format(CartServiceV2()
                                                    //                           .getCartTotalPrice())
                                                    //                       .toString() +
                                                    //                   ' ??????????'),
                                                    //             ],
                                                    //           ),
                                                    //         ),
                                                    //         SizedBox(
                                                    //           height: 5,
                                                    //         ),
                                                    //         Visibility(
                                                    //           visible: scoreController
                                                    //               .getShowScore(),
                                                    //           child: Container(
                                                    //             color: CBase()
                                                    //                 .borderPrimaryColor,
                                                    //             margin: EdgeInsets
                                                    //                 .symmetric(
                                                    //                     horizontal:
                                                    //                         20),
                                                    //             width: CBase()
                                                    //                 .getFullWidth(
                                                    //                     context),
                                                    //             height: 1,
                                                    //           ),
                                                    //         ),
                                                    //         Visibility(
                                                    //           maintainSize: false,
                                                    //           visible: scoreController
                                                    //               .getShowScore(),
                                                    //           child: Column(
                                                    //             children: [
                                                    //               SizedBox(
                                                    //                 height: 5,
                                                    //               ),
                                                    //               Container(
                                                    //                 margin: EdgeInsets
                                                    //                     .symmetric(
                                                    //                         horizontal:
                                                    //                             20),
                                                    //                 child: Row(
                                                    //                   mainAxisAlignment:
                                                    //                       MainAxisAlignment
                                                    //                           .spaceBetween,
                                                    //                   children: [
                                                    //                     Text(
                                                    //                         "?????? ????????????"),
                                                    //                     Text((scoreController
                                                    //                         .getCartTotalPrice()
                                                    //                         .toInt()
                                                    //                         .toString()
                                                    //                         .toPersianDigit()))
                                                    //                   ],
                                                    //                 ),
                                                    //               ),
                                                    //               SizedBox(
                                                    //                 height: 5,
                                                    //               ),
                                                    //             ],
                                                    //           ),
                                                    //         )
                                                    //       ],
                                                    //     );
                                                    //   }),
                                                    // ),
                                                    // SizedBox(
                                                    //   height: 10,
                                                    // ),
                                                    InkWell(
                                                      child: Container(
                                                        height: CBase()
                                                                .getFullHeight(
                                                                    context) /
                                                            12,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        child: GetBuilder<
                                                            InquiryCartController>(
                                                          id: 'sub',
                                                          builder: (_) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                inquiryController
                                                                        .isSubmiting
                                                                    ? Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
                                                                      ))
                                                                    : Text(
                                                                        "?????? ??????????",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              CBase().getLargefontSizeByScreen(),
                                                                          fontFamily:
                                                                              CBase().fontFamily,
                                                                          color:
                                                                              Color(0xffff0000),
                                                                        ),
                                                                      ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        if (!inquiryController
                                                            .isSubmiting)
                                                          inquiryController
                                                              .submitPreOrder();
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    "?????? ???????????? ???????? ??????????",
                                    style: TextStyle(
                                      color: CBase().textPrimaryColor,
                                    ),
                                  ),
                                );
                        })
                    : Center(
                        child: Text(
                          '?????????? ???? ???????????? ?????????????? ???? ???????? ??????',
                          style: TextStyle(color: CBase().textPrimaryColor),
                        ),
                      );
          }),
        ),
      ),
    );
  }
}
