import 'package:copapp/Controller/Controllers/AddAddressController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/General/GoogleMapComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AddAddressComp.dart';

class AddAddress extends StatelessWidget {
  final AddAddressController addAddressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: addAddressController.scaffoldKey,
        drawer: AppDrawer(
          scaffoldKey: addAddressController.scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: addAddressController.scaffoldKey,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text("لطفا آدرس خود را در نقشه مشخص کنید",
                            style: TextStyle(
                              fontSize: CBase().mtitlefontSize,
                              color: CBase().textPrimaryColor,
                            )))),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: CBase().getFullHeight(context) / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(3, 3),
                          blurRadius: 6)
                    ],
                  ),
                  child: Container(
                    // height: CBase().getFullHeight(context) / 1.9,
                    // padding: EdgeInsets.only(
                    //     bottom: CBase().getFullHeight(context) / 8),
                    // margin: EdgeInsets.only(bottom: 20),
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                        child: GoogleMapComponent()),
                  ),
                ),
                AddAddressComponent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
