// import 'package:copapp/Controller/Controllers/Cart/CartController.dart';
// import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
// import 'package:copapp/Controller/Service/CartService.dart';
// import 'package:copapp/Model/CartDetail.dart';
// import 'package:copapp/Utilities/Base.dart';
// import 'package:copapp/Utilities/Snacki.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:persian_number_utility/persian_number_utility.dart';

// class BasketItem extends StatefulWidget {
//   CartDetail? item;
//   GlobalKey<ScaffoldState>? scaffold;
//   Function(dynamic result)? onTapCallback;
//   bool? cartPageIdentifier = false;

//   BasketItem(
//       {this.item, this.scaffold, this.cartPageIdentifier, this.onTapCallback});

//   @override
//   _BasketItemState createState() => _BasketItemState();
// }

// class _BasketItemState extends State<BasketItem> {
//   ScoreService scoreController = Get.find();
//   CartController cartController = Get.put(CartController());
//   bool vis = false;

//   NumberFormat nf = NumberFormat.currency(
//     locale: "fa-IR",
//     symbol: "",
//   );

//   @override
//   Widget build(BuildContext context) {
//     double widgetHeight = (CBase().getFullWidth(context) - 40) * 0.33;
//     return GetBuilder<ScoreService>(builder: (_) {
//       return Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//             height: widgetHeight,
//             width: double.infinity,
//             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10.0),
//               ),
//               boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
//             ),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   flex: 1,
//                   child: Column(
//                     children: [
//                       widget.item?.product?.images != null &&
//                               widget.item!.product!.images!.length > 0
//                           ? Expanded(
//                               flex: 3,
//                               child: InkWell(
//                                 child: Container(
//                                   height: CBase().getFullHeight(context) / 10,
//                                   width: MediaQuery.of(context).size.width / 4,
//                                   margin: EdgeInsets.all(5.0),
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: NetworkImage(widget
//                                           .item!.product!.images!.first.path!),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   // widget.item!.product!
//                                   //     .displayImageSlider(context);
//                                 },
//                               ),
//                             )
//                           : Expanded(
//                               flex: 3,
//                               child: Container(
//                                 height: CBase().getFullHeight(context) / 11,
//                                 width: MediaQuery.of(context).size.width / 4,
//                                 margin: EdgeInsets.all(5.0),
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: AssetImage(
//                                         "images/noimageiconsmall.png"),
//                                     fit: BoxFit.scaleDown,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                       widget.item?.product?.brand?.imagePath != null
//                           ? Expanded(
//                               flex: 1,
//                               child: SvgPicture.network(
//                                   widget.item?.product?.brand?.imagePath ?? ""),
//                             )
//                           : Container()
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Expanded(
//                       flex: 5,
//                       child: VerticalDivider(
//                         width: 1,
//                         color: CBase().borderPrimaryColor,
//                         thickness: 1,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Expanded(
//                       flex: 4,
//                       child: VerticalDivider(
//                         width: 1,
//                         color: CBase().borderPrimaryColor,
//                         thickness: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Column(
//                     children: [
//                       Expanded(
//                           flex: 5,
//                           child: Padding(
//                             padding: EdgeInsets.only(right: 8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Text(
//                                       widget.item?.product?.name ?? "--",
//                                       style: TextStyle(
//                                         fontSize:
//                                             CBase().getTitlefontSizeByScreen() *
//                                                 0.85,
//                                         color: CBase().textPrimaryColor,
//                                         letterSpacing: -0.065,
//                                       ),
//                                       textAlign: TextAlign.right,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         widget.item!.product!.brand!.name! +
//                                             " - " +
//                                             widget
//                                                 .item!.product!.country!.name,
//                                         style: TextStyle(
//                                           fontSize: CBase()
//                                               .getSubTitlefontSizeByScreen(),
//                                           color: CBase().basePrimaryLightColor,
//                                         ),
//                                         textAlign: TextAlign.right,
//                                       ),
//                                       Container(
//                                         width: 20.0,
//                                         height: 20.0,
//                                         child: Visibility(
//                                           maintainSize: false,
//                                           maintainAnimation: true,
//                                           maintainState: true,
//                                           visible: vis,
//                                           child: Theme(
//                                             data: Theme.of(context).copyWith(
//                                               accentColor:
//                                                   CBase().basePrimaryColor,
//                                             ),
//                                             child: vis
//                                                 ? CircularProgressIndicator(
//                                                     valueColor:
//                                                         AlwaysStoppedAnimation<
//                                                                 Color>(
//                                                             CBase()
//                                                                 .basePrimaryColor),
//                                                   )
//                                                 : Text(""),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )),
//                       Padding(
//                         padding: EdgeInsets.only(right: 5.0),
//                         child: Divider(
//                           height: 1,
//                           color: CBase().borderPrimaryColor,
//                           thickness: 1,
//                         ),
//                       ),
//                       Expanded(
//                         flex: 4,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Flexible(
//                                     child: Container(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Container(
//                                             padding: EdgeInsets.only(
//                                               top: 5.0,
//                                               bottom: 5.0,
//                                               right: 10.0,
//                                               left: 5.0,
//                                             ),
//                                             child: Stack(
//                                               alignment: Alignment.center,
//                                               children: [
//                                                 SvgPicture.asset(
//                                                   "images/plus.svg",
//                                                   width: 15.0,
//                                                   height: 15.0,
//                                                   color:
//                                                       CBase().basePrimaryColor,
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () async {
//                                                     setState(() {
//                                                       vis = true;
//                                                     });

//                                                     int newQTY = CartServiceV2()
//                                                         .cartProductQTY(widget
//                                                             .item!
//                                                             .product!
//                                                             .id!);

//                                                     if (widget.item!.product!
//                                                             .multipleQTY! <=
//                                                         0)
//                                                       newQTY += 1;
//                                                     else
//                                                       newQTY += widget
//                                                           .item!
//                                                           .product!
//                                                           .multipleQTY!;

//                                                     var result =
//                                                         await CartServiceV2()
//                                                             .UpdateProduct(
//                                                                 widget
//                                                                     .item!
//                                                                     .product!
//                                                                     .id!,
//                                                                 newQTY);

//                                                     if (!result.isSuccess)
//                                                       result.ShowMessage(
//                                                           widget.scaffold!);

//                                                     if (widget.onTapCallback !=
//                                                         null) {
//                                                       widget.onTapCallback!(
//                                                           "tap");
//                                                     }
//                                                     setState(() {
//                                                       vis = false;
//                                                     });
//                                                   },
//                                                   child: Column(
//                                                     children: [
//                                                       Expanded(
//                                                         child: Container(
//                                                           color: Colors
//                                                               .transparent,
//                                                           width: 25,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Flexible(
//                                             child: InkWell(
//                                               child: Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 5.0),
//                                                 child: Text(
//                                                   (CartServiceV2()
//                                                               .cartProductQTY(
//                                                                   widget
//                                                                       .item!
//                                                                       .product!
//                                                                       .id!)
//                                                               .toString() +
//                                                           " " +
//                                                           widget.item!.product!
//                                                               .unit!.name!)
//                                                       .toPersianDigit(),
//                                                   maxLines: 1,
//                                                   style: TextStyle(
//                                                     fontSize: CBase()
//                                                         .getTitlefontSizeByScreen(),
//                                                     color: CartServiceV2()
//                                                                 .cartProductQTY(
//                                                                     widget
//                                                                         .item!
//                                                                         .product!
//                                                                         .id!) >
//                                                             0
//                                                         ? CBase()
//                                                             .textPrimaryColor
//                                                         : CBase()
//                                                             .basePrimaryColor,
//                                                     letterSpacing: -0.32,
//                                                   ),
//                                                   textAlign: TextAlign.center,
//                                                 ),
//                                               ),
//                                               onTap: () async {
//                                                 setState(() {
//                                                   vis = true;
//                                                 });
//                                                 if (CartServiceV2()
//                                                         .cartProductQTY(widget
//                                                             .item!
//                                                             .product!
//                                                             .id!) <=
//                                                     0) {
//                                                   var result =
//                                                       await CartServiceV2()
//                                                           .AddProduct(
//                                                               widget.item!
//                                                                   .product!.id!,
//                                                               1);

//                                                   if (!result.isSuccess)
//                                                     result.ShowMessage(
//                                                         widget.scaffold!);

//                                                   if (widget.onTapCallback !=
//                                                       null) {
//                                                     widget
//                                                         .onTapCallback!("tap");
//                                                   }
//                                                 }
//                                                 setState(() {
//                                                   vis = false;
//                                                 });
//                                               },
//                                             ),
//                                           ),
//                                           InkWell(
//                                             child: Container(
//                                               padding: EdgeInsets.only(
//                                                 top: 5.0,
//                                                 bottom: 5.0,
//                                                 left: 10.0,
//                                                 right: 5.0,
//                                               ),
//                                               child: Stack(
//                                                 alignment: Alignment.center,
//                                                 children: [
//                                                   SvgPicture.asset(
//                                                     "images/del.svg",
//                                                     width: 15.0,
//                                                     height: 15.0,
//                                                   ),
//                                                   GestureDetector(
//                                                     onTap: () async {
//                                                       setState(() {
//                                                         vis = true;
//                                                       });
//                                                       var newQty =
//                                                           CartServiceV2()
//                                                               .cartProductQTY(
//                                                                   widget
//                                                                       .item!
//                                                                       .product!
//                                                                       .id!);

//                                                       if (widget.item!.product!
//                                                               .multipleQTY! <=
//                                                           0)
//                                                         newQty -= 1;
//                                                       else
//                                                         newQty -= widget
//                                                             .item!
//                                                             .product!
//                                                             .multipleQTY!;

//                                                       if (newQty <= 0) {
//                                                         if (widget
//                                                                 .cartPageIdentifier ==
//                                                             true) {
//                                                           // Snacki()
//                                                           //     .ShowCartProductDeleteSnack(
//                                                           //         widget
//                                                           //             .scaffold,
//                                                           //         (result) async {
//                                                           //   setState(() {
//                                                           //     vis = true;
//                                                           //   });
//                                                           //   var result = await CartServiceV2()
//                                                           //       .DeleteProduct(
//                                                           //           widget
//                                                           //               .item!
//                                                           //               .product!
//                                                           //               .id!)
//                                                           //       .then((value) {
//                                                           //     setState(() {
//                                                           //       vis = false;
//                                                           //     });
//                                                           //     if (!value
//                                                           //         .isSuccess)
//                                                           //       value.ShowMessage(
//                                                           //           widget
//                                                           //               .scaffold!);
//                                                           //     if (widget
//                                                           //             .onTapCallback !=
//                                                           //         null) {
//                                                           //       widget
//                                                           //           .onTapCallback!(
//                                                           //               "tap");
//                                                           //     }
//                                                           //   });
//                                                           // });
//                                                         }
//                                                       } else {
//                                                         var result =
//                                                             await CartServiceV2()
//                                                                 .UpdateProduct(
//                                                                     widget
//                                                                         .item!
//                                                                         .product!
//                                                                         .id!,
//                                                                     newQty);

//                                                         if (!result.isSuccess)
//                                                           result.ShowMessage(
//                                                               widget.scaffold!);
//                                                       }

//                                                       if (widget
//                                                               .onTapCallback !=
//                                                           null) {
//                                                         widget.onTapCallback!(
//                                                             "tap");
//                                                       }

//                                                       setState(() {
//                                                         vis = false;
//                                                       });
//                                                     },
//                                                     child: Column(
//                                                       children: [
//                                                         Expanded(
//                                                           child: Container(
//                                                             color: Colors
//                                                                 .transparent,
//                                                             width: 25,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 5.0),
//                                     child: VerticalDivider(
//                                       width: 1,
//                                       color: CBase().borderPrimaryColor,
//                                       thickness: 1,
//                                     ),
//                                   ),
//                                   Flexible(
//                                     child: Container(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             child: Column(
//                                               mainAxisAlignment: scoreController
//                                                       .getShowScore()
//                                                   ? MainAxisAlignment
//                                                       .spaceEvenly
//                                                   : MainAxisAlignment.center,
//                                               children: [
//                                                 Visibility(
//                                                   visible: scoreController
//                                                       .getShowScore(),
//                                                   child: Expanded(
//                                                     flex: 1,
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Container(
//                                                           child: Text(
//                                                             ('${(widget.item!.product!.productInfos!.first.score! * CartServiceV2().cartProductQTY(widget.item!.product!.id!)).toInt()}')
//                                                                 .toPersianDigit(),
//                                                             style: TextStyle(
//                                                               fontSize: CBase()
//                                                                   .getTextfontSizeByScreen(),
//                                                               color: CBase()
//                                                                   .textPrimaryColor,
//                                                             ),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           margin:
//                                                               EdgeInsets.only(
//                                                                   right: 10),
//                                                           child: Text(
//                                                             "امتیاز",
//                                                             style: TextStyle(
//                                                               fontSize: CBase()
//                                                                   .getTextfontSizeByScreen(),
//                                                               color: CBase()
//                                                                   .textPrimaryColor,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Visibility(
//                                                   visible: scoreController
//                                                       .getShowScore(),
//                                                   child: Container(
//                                                     margin:
//                                                         EdgeInsets.symmetric(
//                                                             vertical: 1),
//                                                     height: 1,
//                                                     width: CBase().getFullWidth(
//                                                             context) /
//                                                         3.4,
//                                                     color: CBase()
//                                                         .borderPrimaryColor,
//                                                   ),
//                                                 ),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     IntrinsicHeight(
//                                                       child: Container(
//                                                         child: Text(
//                                                           nf
//                                                               .format(CartServiceV2()
//                                                                       .cartProductQTY(widget
//                                                                           .item!
//                                                                           .product!
//                                                                           .id!) *
//                                                                   widget
//                                                                       .item!
//                                                                       .product!
//                                                                       .productInfos!
//                                                                       .first
//                                                                       .price!)
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                             fontSize: CBase()
//                                                                 .getTitlefontSizeByScreen(),
//                                                             color: CBase()
//                                                                 .basePrimaryLightColor,
//                                                           ),
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 5.0,
//                                                     ),
//                                                     // SvgPicture.string(
//                                                     //   SVGIcons.toman,
//                                                     //   color: CBase()
//                                                     //       .basePrimaryLightColor,
//                                                     //   allowDrawingOutsideViewBox:
//                                                     //       true,
//                                                     //   width: 18.0,
//                                                     //   height: 18.0,
//                                                     // ),
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
