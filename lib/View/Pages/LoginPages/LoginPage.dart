import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Controllers/LoginController.dart';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Model/GoogleAuth.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/FullCheckBox.dart';
import 'package:copapp/View/Components/RedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'RegisterPage.dart';
import 'ResetPasswordPage.dart';

class LoginPage extends StatelessWidget {
  LoginController loginController = Get.put(LoginController());

  GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          '257344829185-b5h3l1hm775unc4nn21bsljku461b877.apps.googleusercontent.com');

  @override
  Widget build(BuildContext context) {
    double widgetHeight = (CBase().getFullWidth(context) - 42) * (128 / 950);
    loginController.setContext(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: loginController.scaffoldKey,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: CBase().getFullHeight(context) / 3,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: CBase().getFullHeight(context) / 3.5,
                              decoration: BoxDecoration(
                                  // color: Colors.black,
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                        "images/LoginPic.png",
                                      ))),
                            ),
                          ),
                          SvgPicture.asset(
                            "images/CopAppLogin.svg",
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: CBase().getFullHeight(context) / 15,
                    ),
                    Expanded(
                      child: Container(
                        width: CBase().getFullWidth(context) / 1.4,
                        padding: EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: loginController.userName,
                              decoration: InputDecoration(
                                hintText: "نام کاربری",
                                hintStyle: TextStyle(
                                    fontSize: CBase().getTitlefontSizeByScreen(),
                                    color: CBase().textPrimaryColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            TextField(
                              obscureText: true,
                              controller: loginController.password,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "رمز عبور",
                                hintStyle: TextStyle(
                                    fontSize: CBase().getTitlefontSizeByScreen(),
                                    color: CBase().textPrimaryColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          FlatButton(
                                            padding: EdgeInsets.only(
                                                top: 0.0, bottom: 35.0),
                                            child: Text(
                                              "بازیابی رمز عبور",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.normal,
                                                color: CBase().textPrimaryColor,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                            highlightColor: Colors.grey[200],
                                            onPressed: () {
                                              Get.to(
                                                  () => QC_ResetPasswordPage());
                                            },
                                          ),
                                          SizedBox(
                                            width: 1,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              loginController.checkLoginVal();
                                            },
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                bottom: 35.0,
                                                top: 0.0,
                                              ),
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "ورود خودکار",
                                                      style: TextStyle(
                                                        color: CBase()
                                                            .textPrimaryColor,
                                                        fontSize: CBase()
                                                            .getTextfontSizeByScreen(),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Obx(() {
                                                    return FullCheckBox(
                                                      value: loginController
                                                                  .autoLoginValue
                                                                  .value ==
                                                              "1"
                                                          ? true
                                                          : false,
                                                    );
                                                  })
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: CBase().getFullHeight(context) / 20,
                                    ),
                                    GetBuilder<LoginController>(
                                      id: 2,
                                      builder: (_) {
                                        return Visibility(
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          visible: loginController.circularVis,
                                          child: Container(
                                              child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Color(0xffff0000),
                                            ),
                                            backgroundColor: Color(0xFF2C2C2C),
                                          )),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    REDButton(
                                      title: "ورود",
                                      onTapCallback: (result) async {
                                        if (!loginController.circularVis) {
                                          loginController.loginPress(
                                              userName: loginController
                                                  .userName.text
                                                  .toEnglishDigit(),
                                              password: loginController
                                                  .password.text
                                                  .toEnglishDigit(),
                                              scaffoldKey:
                                                  loginController.scaffoldKey);
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: CBase().getFullHeight(context) / 30,
                                    ),
                                    Image(
                                      image: AssetImage(
                                        "images/GoogleLogin.png",
                                      ),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          LoginSignIn();
                                        },
                                        child: Text(
                                          'ورود با حساب گوگل',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: CBase().textPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: FractionalOffset.bottomCenter,
                                      child: FlatButton(
                                        child: Container(
                                          height: 30,
                                          width:
                                              CBase().getFullWidth(context) / 3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color(0x29000000),
                                                  offset: Offset(0, 0),
                                                  blurRadius: 6)
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "حساب کاربری ",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.normal,
                                                  color: CBase().textPrimaryColor,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                              Text(
                                                "جدید ",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.red,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          ),
                                        ),
                                        highlightColor: Colors.grey[200],
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QC_RegisterPage()),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void LoginSignIn() async {
    await googleSignIn.signOut();

    GoogleSignInAccount? GoogleUser = await googleSignIn.signIn();
    GoogleAuth googleAuth;

    if (GoogleUser == null) {
      print("failed");
    } else {
      googleAuth = loginController.googleSignToPost(GoogleUser);
      ResponseModel model = await UserServiceV2().googleLogIn(googleAuth);
      if (model.isSuccess) {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (BuildContext context) => HomePageV4()));
      } else {
        model.showMessage();
      }
      ////RegisterBusiness().initialDataAsync();

    }
  }
}
