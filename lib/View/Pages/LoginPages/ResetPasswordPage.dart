import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/RedButton.dart';
import 'package:copapp/View/Pages/LoginPages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'RegisterPage.dart'; //import

class QC_ResetPasswordPage extends StatefulWidget {

  @override
  _QC_QC_ResetPasswordPageState createState() =>
      _QC_QC_ResetPasswordPageState();
}

class _QC_QC_ResetPasswordPageState extends State<QC_ResetPasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool vis = false;
  TextEditingController mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: CBase().getFullHeight(context) / 2.8,
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
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: SvgPicture.asset(
                              "images/CopAppLogin.svg",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: CBase().getFullHeight(context) / 30,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: CBase().getFullWidth(context) / 1.4,
                              padding: EdgeInsets.only(
                                bottom: 10.0,
                                // left: 50.0,
                                // right: 50.0,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text("بازیابی رمز عبور"),
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(10.0),
                                  ),
                                  SizedBox(height: CBase().getFullHeight(context) / 30,),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    height: 40.0,
                                    child: TextField(
                                      controller: mobile,
                                      decoration: InputDecoration(
                                        hintText: "  شماره تلفن همراه",
                                        hintStyle: TextStyle(
                                            fontSize: CBase()
                                                .getTitlefontSizeByScreen(),
                                            color: CBase().textPrimaryColor),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              FlatButton(
                                                padding: EdgeInsets.only(
                                                  top: 0.0,
                                                  bottom: 35.0,
                                                ),
                                                highlightColor: Colors.grey[200],
                                                child: Text(
                                                  "پنل ورود",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: CBase()
                                                          .textPrimaryColor,
                                                      fontWeight:
                                                      FontWeight.normal),
                                                  textAlign: TextAlign.right,
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage()),
                                                  );
                                                },
                                              ),
                                              FlatButton(
                                                padding: EdgeInsets.only(
                                                  top: 0.0,
                                                  bottom: 35.0,
                                                ),
                                                child: Text(
                                                  "حساب کاربری ندارم",
                                                  style: TextStyle(
                                                      fontSize: CBase()
                                                          .getTextfontSizeByScreen(),
                                                      color: CBase()
                                                          .textPrimaryColor,
                                                      fontWeight:
                                                      FontWeight.normal),
                                                  textAlign: TextAlign.right,
                                                ),
                                                highlightColor:
                                                CBase().backgroundColor,
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QC_RegisterPage()),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Container(
                                    child: Visibility(
                                      maintainSize: false,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      visible: vis,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          accentColor: CBase().basePrimaryColor,
                                        ),
                                        child: vis
                                            ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),)
                                            : Text(""),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: CBase().getFullHeight(context) / 30,
                                  ),
                                  REDButton(
                                    title: "بازیابی",
                                    onTapCallback: (result) async {
                                      setState(() {
                                        vis = true;
                                      });
                                      mobile.text = mobile.text.toEnglishDigit();
                                      await UserServiceV2()
                                          .ResetPassword(mobile.text);

                                      setState(() {
                                        vis = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
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
}
