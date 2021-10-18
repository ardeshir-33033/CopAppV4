import 'package:copapp/Controller/Controllers/ProfileController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ProfileTextfield.dart';

class EditingNumberTab extends StatelessWidget {
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    if(profileController.phoneNumber.text.isEmpty){
    profileController.setNumberTextFields();}
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileTextField(
            controller: profileController.phoneNumber,
            hint: "شماره همراه",
          ),
          ProfileTextField(
            controller: profileController.teleNumber,
            hint: "تلفن ثابت",
          ),
          ProfileTextField(
            controller: profileController.email,
            hint: "ایمیل",
          ),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: CBase().getFullHeight(context) / 12,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: profileController.isLoadingNumber
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CBase().basePrimaryColor),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        profileController.confirmNumber();
                      },
                      child: Center(
                        child: Text(
                          "ثبت",
                          style: TextStyle(
                            fontSize: CBase().getLargefontSizeByScreen(),
                            fontFamily: CBase().fontFamily,
                            color: Color(0xffff0000),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
