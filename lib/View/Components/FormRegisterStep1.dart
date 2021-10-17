import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/LoginPages/RegisterPagePassword.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'RedButton.dart'; //import

class FormRegisterStep1 extends StatefulWidget {
  // UserRegisterModel user = UserRegisterModel();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

//////ثبت نام

  FormRegisterStep1({
    required this.scaffoldKey,
    // this.user,
  });

  @override
  _FormRegisterStep1State createState() => _FormRegisterStep1State();
}

class _FormRegisterStep1State extends State<FormRegisterStep1> {
  // UserRegisterModel user = UserRegisterModel();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController lname = TextEditingController();

  // _FormRegisterStep1State({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CBase().getFullWidth(context) / 1.4,
      padding: EdgeInsets.only(
        top: 12.5,
        bottom: 10.0,
        // left: 50.0,
        // right: 50.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              "ثبت نام",
              style: TextStyle(
                color: CBase().textPrimaryColor,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 40.0,
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(),
              child: TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  hintText: "  شماره تلفن همراه",
                  hintStyle: TextStyle(
                      fontSize: CBase().getTitlefontSizeByScreen(),
                      color: CBase().textPrimaryColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 91.0,
          ),
          REDButton(
            title: "بعدی",
            onTapCallback: (result) async {
              phoneNumberController.text =
                  phoneNumberController.text.toEnglishDigit();
              ResponseModel result = await UserServiceV2()
                  .SuspendedUser(phoneNumberController.text);
              if (result.isSuccess == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QC_RegisterPasswordPage(
                        // user: user,
                        phoneNumber: phoneNumberController.text,
                      )),
                );
              } else {
                ResponseModel().ShowMessage();
              }
              // user.fullName = fname.text + " " + lname.text;
            },
          ),
        ],
      ),
    );
  }
}
