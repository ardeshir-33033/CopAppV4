import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Model/Address.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/ChooseAddController.dart';
import 'package:copapp/View/Components/FullCheckBox.dart';
import 'package:copapp/View/Pages/AddressPages/AddAddress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddressWidget extends StatelessWidget {
  ChooseAddressController addressController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: CBase().getFullWidth(context),
            child: addressController.addresses == null
                ? Center(
                    child: Text("در حال دریافت"),
                  )
                : addressController.addresses!.length != 0
                    ? Column(children: [
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    addressController.checkboxSelect(0);
                                  },
                                  child: Container(
                                    height: CBase().getFullHeight(context) / 15,
                                    width: CBase().getFullWidth(context) - 40,
                                    margin: EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0x29000000),
                                            offset: Offset(3, 3),
                                            blurRadius: 6)
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015,
                                          child: FullCheckBox(
                                              value: addressController
                                                  .checkboxes[0],
                                              onChanged: (v) {
                                                addressController
                                                    .checkboxSelect(0);
                                              }),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "حضوری",
                                          style: TextStyle(
                                              fontSize: CBase()
                                                  .getTextfontSizeByScreen(),
                                              color: CBase().textPrimaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            for (int index = 0;
                                index < addressController.addresses!.length;
                                index++)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    addressController.checkboxSelect(index + 1);
                                  },
                                  child: Container(
                                    height: CBase().getFullHeight(context) / 4,
                                    width: CBase().getFullWidth(context),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0x29000000),
                                            offset: Offset(3, 3),
                                            blurRadius: 6)
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 5),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.015,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.015,
                                                    child: FullCheckBox(
                                                        value: addressController
                                                                .checkboxes[
                                                            index + 1],
                                                        onChanged: (v) {
                                                          addressController
                                                              .checkboxSelect(
                                                                  index + 1);
                                                        }),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10.0),
                                                      child: Text(
                                                        '${addressController.addresses![index].title ?? ""}',
                                                        style: TextStyle(
                                                          fontSize: CBase()
                                                              .mtextfontSize,
                                                          color: CBase()
                                                              .textPrimaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  addressController
                                                      .delete(index);
                                                },
                                                child: Container(
                                                  width: CBase().getFullWidth(
                                                              context) >
                                                          675
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.06,
                                                  height: CBase().getFullWidth(
                                                              context) >
                                                          675
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.06,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: SvgPicture.asset(
                                                    'images/del.svg',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          thickness: 2,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              height: CBase()
                                                      .getFullHeight(context) /
                                                  20,
                                              child: Text(
                                                  "آدرس:${addressController.addresses![index].city} - ${addressController.addresses![index].completeAddress}",
                                                  style: TextStyle(
                                                    fontSize:
                                                        CBase().mtextfontSize,
                                                    color: CBase()
                                                        .textPrimaryColor,
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          thickness: 2,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("گیرنده",
                                                        style: TextStyle(
                                                          fontSize: CBase()
                                                              .mtextfontSize,
                                                          color: CBase()
                                                              .textPrimaryColor,
                                                        )),
                                                    Divider(
                                                      height: 1,
                                                      thickness: 2,
                                                    ),
                                                    Text("کد پستی",
                                                        style: TextStyle(
                                                          fontSize: CBase()
                                                              .mtextfontSize,
                                                          color: CBase()
                                                              .textPrimaryColor,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: VerticalDivider(
                                                        width: 1,
                                                        thickness: 2,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Expanded(
                                                      child: VerticalDivider(
                                                        width: 1,
                                                        thickness: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                        "${addressController.addresses![index].receiverName ?? ""}",
                                                        style: TextStyle(
                                                          fontSize: CBase()
                                                              .mtextfontSize,
                                                          color: CBase()
                                                              .textPrimaryColor,
                                                        )),
                                                    Divider(
                                                      height: 1,
                                                      thickness: 2,
                                                    ),
                                                    Text(
                                                        "${addressController.addresses![index].postalCode ?? ""}",
                                                        style: TextStyle(
                                                          fontSize: CBase()
                                                              .mtextfontSize,
                                                          color: CBase()
                                                              .textPrimaryColor,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: VerticalDivider(
                                                        width: 1,
                                                        thickness: 2,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                          height: 30,
                                                          child:
                                                              VerticalDivider(
                                                            width: 1,
                                                            thickness: 2,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                  onTap: () {
                                                    addressController
                                                            .addAddressController
                                                            .currentAddress =
                                                        addressController
                                                            .addresses![index];
                                                    Get.to(() => AddAddress());
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 3,
                                                        top: 5.0,
                                                        bottom: 5.0),
                                                    width: CBase().getFullWidth(
                                                            context) /
                                                        4.3,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text("ویرایش آدرس",
                                                            style: TextStyle(
                                                              fontSize: CBase()
                                                                  .getTextfontSizeByScreen(),
                                                              color: Colors
                                                                  .red[300],
                                                            )),
                                                        Icon(
                                                          Icons.chevron_right,
                                                          color:
                                                              Colors.red[300],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: InkWell(
                                onTap: () {
                                  addressController.addAddressController
                                      .currentAddress = null;
                                  Get.to(() => AddAddress());
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("افزودن آدرس جدید",
                                          style: TextStyle(
                                            fontSize: CBase().mtextfontSize,
                                            color: CBase().textPrimaryColor,
                                          )),
                                      Icon(
                                        Icons.add,
                                        color: CBase().basePrimaryLightColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ])
                    : InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddAddress()));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: CBase().getFullWidth(context) / 10,
                              vertical: 20.0),
                          child: Row(
                            children: [
                              Text("افزودن آدرس",
                                  style: TextStyle(
                                    fontSize: CBase().mtextfontSize,
                                    color: CBase().textPrimaryColor,
                                  )),
                              Icon(
                                Icons.add,
                                color: CBase().basePrimaryLightColor,
                              )
                            ],
                          ),
                        ),
                      )),
      ],
    );
  }
}
