import 'dart:ui';
import 'package:copapp/Controller/Controllers/AddAddressController.dart';
import 'package:copapp/Controller/Controllers/General/GoogleMapController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/NewDropDown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressComponent extends StatefulWidget {
  @override
  _AddAddressComponentState createState() => _AddAddressComponentState();
}

class _AddAddressComponentState extends State<AddAddressComponent> {
  AddAddressController addAddressController = Get.find();
  List<DropdownMenuItem> provincesItems = [];
  int? dropdownProvincevalue;

  MapController mapController = Get.find();
  @override
  void initState() {
    super.initState();
    addAddressController.initAddComp(
        addAddressController.currentAddress, mapController.mapAddress);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressController>(builder: (_) {
      return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(3, 3),
                    blurRadius: 6)
              ],
            ),
            child: !addAddressController.isLoading
                ? InkWell(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: MediaQuery.of(context).size.width * 0.2),
                      height: 35.0,
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
                      padding: EdgeInsets.all(2.0),
                      child: Center(
                        child: Text(
                          "ثبت",
                          style: TextStyle(
                            color: Color(0xffff0000),
                            fontSize: 18.0,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      addAddressController.onConfirm(mapController.mapPosition);
                    },
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CBase().basePrimaryColor),
                      ),
                    ),
                  ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                // CustomDropdownButton(
                //   hint: 'استان',
                //   items: provincesItems,
                //   value: dropdownProvincevalue,
                //   dropdownColor: Colors.white,
                //   onChanged: (value) {
                //     dropdownProvincevalue = value;
                //     // setCities(value);
                //     setState(() {});
                //   },
                // ),
                // ManagementDropDown(),
                Container(
                  margin: EdgeInsets.only(
                    right: 5.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CBase().textLightPrimaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: NewDropDown(
                    items: addAddressController.provincesItems,
                    value: addAddressController.dropdownProvincevalue,
                    alignment: Alignment.centerRight,
                    style: TextStyle(
                      fontSize: CBase().getTextfontSizeByScreen(),
                      fontFamily: 'IRANSans',
                      color: CBase().textPrimaryColor,
                    ),
                    listDecoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 5)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    iconColor: CBase().textPrimaryColor,
                    height: CBase().getFullHeight(context) / 15,
                    listWidth: CBase().getFullWidth(context) / 2,
                    onChanged: (value) {
                      addAddressController.onProvinceChange(value);
                    },
                    title: 'استان',
                  ),
                  // child: DropdownButtonHideUnderline(
                  //   child: DropdownButton<dynamic>(
                  //     hint: Text(
                  //       'استان',
                  //       style: TextStyle(
                  //         fontSize: CBase().getTextfontSizeByScreen(),
                  //         color: CBase().textPrimaryColor,
                  //       ),
                  //     ),
                  //     style: TextStyle(
                  //       fontSize: CBase().getTextfontSizeByScreen(),
                  //       fontFamily: 'IRANSans',
                  //       color: CBase().textPrimaryColor,
                  //     ),
                  //     items: addAddressController.provincesItems,
                  //     value: addAddressController.dropdownProvincevalue,
                  //     dropdownColor: Colors.white,
                  //     onChanged: (value) {
                  //       addAddressController.onProvinceChange(value);
                  //     },
                  //   ),
                  // ),
                ),
                Container(
                  width: CBase().getFullWidth(context) - 20,
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CBase().textLightPrimaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: NewDropDown(
                    alignment: Alignment.centerRight,
                    style: TextStyle(
                      fontSize: CBase().getTextfontSizeByScreen(),
                      fontFamily: 'IRANSans',
                      color: CBase().textPrimaryColor,
                    ),
                    listDecoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 5)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    iconColor: CBase().textPrimaryColor,
                    height: CBase().getFullHeight(context) / 15,
                    listWidth: CBase().getFullWidth(context) / 2,
                    items: addAddressController.citiesItems,
                    value: addAddressController.dropdownCityvalue,
                    onChanged: (value) {
                      addAddressController.onCityChange(value);
                    },
                    title: 'شهر',
                  ),
                  // child: DropdownButtonHideUnderline(
                  //   child: DropdownButton<dynamic>(
                  //     hint: Text(
                  //       ,
                  //       style: TextStyle(
                  //         fontSize: CBase().getTextfontSizeByScreen(),
                  //         color: CBase().textPrimaryColor,
                  //       ),
                  //     ),
                  //     items: addAddressController.citiesItems,
                  //     value: addAddressController.dropdownCityvalue,
                  //     dropdownColor: Colors.white,
                  //     onChanged: (value) {
                  //       addAddressController.onCityChange(value);
                  //     },
                  //   ),
                  // ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CBase().textLightPrimaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: addAddressController.titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "عنوان آدرس",
                      hintStyle: TextStyle(
                        fontSize: CBase().getTextfontSizeByScreen(),
                        color: CBase().textPrimaryColor,
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CBase().textLightPrimaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: addAddressController.recieverNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "نام گیرنده",
                      hintStyle: TextStyle(
                        fontSize: CBase().getTextfontSizeByScreen(),
                        color: CBase().textPrimaryColor,
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CBase().textLightPrimaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: addAddressController.mobileNumberController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "تلفن همراه",
                      hintStyle: TextStyle(
                        fontSize: CBase().getTextfontSizeByScreen(),
                        color: CBase().textPrimaryColor,
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CBase().textLightPrimaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: addAddressController.phoneNumberController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "تلفن",
                      hintStyle: TextStyle(
                        fontSize: CBase().getTextfontSizeByScreen(),
                        color: CBase().textPrimaryColor,
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CBase().textLightPrimaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: addAddressController.completeAddressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "آدرس",
                      hintStyle: TextStyle(
                        fontSize: CBase().getTextfontSizeByScreen(),
                        color: CBase().textPrimaryColor,
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CBase().textLightPrimaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: addAddressController.postalCode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "کد پستی",
                      hintStyle: TextStyle(
                        fontSize: CBase().getTextfontSizeByScreen(),
                        color: CBase().textPrimaryColor,
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      );
    });
  }
}
