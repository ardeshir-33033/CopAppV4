import 'package:copapp/Controller/Controllers/AddressController.dart';

import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'AddAddress.dart';

class AddressPage extends StatelessWidget {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AddressController addressController = Get.put(AddressController());

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
          child: GetBuilder<AddressController>(builder: (_) {
            return addressController.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xffff0000),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: CBase().getFullWidth(context),
                          child: addressController.Addresses == null
                              ? Center(
                                  child: Text("در حال دریافت"),
                                )
                              : addressController.Addresses.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          addressController.Addresses.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 10.0),
                                              child: Container(
                                                height: CBase()
                                                        .getFullHeight(context) /
                                                    4,
                                                width:
                                                    CBase().getFullWidth(context),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: const Color(
                                                            0x29000000),
                                                        offset: Offset(3, 3),
                                                        blurRadius: 6)
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              10.0),
                                                                  child: Text(
                                                                    '${addressController.Addresses[index].title ?? ""}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          CBase()
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
                                                                  .deleteAddress(
                                                                      index);
                                                            },
                                                            child: Container(
                                                              width: CBase().getFullWidth(
                                                                          context) >
                                                                      675
                                                                  ? MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.05
                                                                  : MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.06,
                                                              height: CBase().getFullWidth(
                                                                          context) >
                                                                      675
                                                                  ? MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.05
                                                                  : MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.06,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'images/del.svg',
                                                                fit: BoxFit
                                                                    .contain,
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
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 10),
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          height: CBase()
                                                                  .getFullHeight(
                                                                      context) /
                                                              20,
                                                          child: Text(
                                                              "آدرس: ${addressController.Addresses[index].city} - ${addressController.Addresses[index].completeAddress}",
                                                              style: TextStyle(
                                                                fontSize: CBase()
                                                                    .mtextfontSize,
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
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          CBase()
                                                                              .mtextfontSize,
                                                                      color: CBase()
                                                                          .textPrimaryColor,
                                                                    )),
                                                                Divider(
                                                                  height: 1,
                                                                  thickness: 2,
                                                                ),
                                                                Text("کد پستی",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          CBase()
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
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5),
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      VerticalDivider(
                                                                    width: 1,
                                                                    thickness: 2,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      VerticalDivider(
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
                                                                    "${addressController.Addresses[index].receiverName ?? ""}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          CBase()
                                                                              .mtextfontSize,
                                                                      color: CBase()
                                                                          .textPrimaryColor,
                                                                    )),
                                                                Divider(
                                                                  height: 1,
                                                                  thickness: 2,
                                                                ),
                                                                Text(
                                                                    "${addressController.Addresses[index].postalCode ?? ""}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          CBase()
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
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5),
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      VerticalDivider(
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
                                                                      child: VerticalDivider(
                                                                        width: 1,
                                                                        thickness:
                                                                            2,
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
                                                                            .Addresses[
                                                                        index];
                                                                Get.to(() =>
                                                                    AddAddress());
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right: 3),
                                                                width: CBase()
                                                                        .getFullWidth(
                                                                            context) /
                                                                    4.3,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        "ویرایش آدرس",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              CBase().getTextfontSizeByScreen(),
                                                                          color: Colors
                                                                              .red[300],
                                                                        )),
                                                                    Icon(
                                                                      Icons
                                                                          .chevron_right,
                                                                      color: Colors
                                                                              .red[
                                                                          300],
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
                                            Visibility(
                                                visible: addressController
                                                            .Addresses.length -
                                                        1 ==
                                                    index,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addressController
                                                          .addAddressController
                                                          .currentAddress = null;
                                                      Get.to(() => AddAddress());
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                        children: [
                                                          Text("افزودن آدرس جدید",
                                                              style: TextStyle(
                                                                fontSize: CBase()
                                                                    .mtextfontSize,
                                                                color: CBase()
                                                                    .textPrimaryColor,
                                                              )),
                                                          Icon(
                                                            Icons.add,
                                                            color: CBase()
                                                                .basePrimaryLightColor,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        );
                                      })
                                  : Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 10.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: CBase()
                                                        .getFullWidth(context) /
                                                    10,
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text("افزودن آدرس جدید",
                                                    style: TextStyle(
                                                      fontSize:
                                                          CBase().mtextfontSize,
                                                      color: CBase()
                                                          .textPrimaryColor,
                                                    )),
                                                Icon(
                                                  Icons.add,
                                                  color: CBase()
                                                      .basePrimaryLightColor,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
