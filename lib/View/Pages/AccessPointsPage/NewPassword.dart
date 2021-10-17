import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Model/User.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:copapp/View/Components/RedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persian_number_utility/persian_number_utility.dart';


class PointsNewPassword extends StatefulWidget {
  PointsNewPassword({
    Key? key,
  }) : super(key: key);

  @override
  _PointsNewPasswordState createState() => _PointsNewPasswordState();
}

class _PointsNewPasswordState extends State<PointsNewPassword> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool vis = false;
  bool auto = false;
  Widget autoWidget = SizedBox();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        // SvgPicture.asset(
                        //   "images/LoginPicture.svg",
                        //   fit: BoxFit.fitWidth,
                        // ),
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
                        // left: 50.0,
                        // right: 50.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: userName,
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
                            controller: password,
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
                          SizedBox(height: 30,),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  REDButton(
                                    title: "بررسی",
                                    onTapCallback: (result) async {
                                      try {
                                        setState(() {
                                          vis = true;
                                        });
                                        password.text =
                                            password.text.toEnglishDigit();
                                        userName.text =
                                            userName.text.toEnglishDigit();

                                        User user = UserServiceV2().getUser();
                                        if (userName.text == user.userName &&
                                            password.text == user.password) {
                                          Navigator.pop(context , 1);
                                        } else {
                                          Snacki().GETSnackBar(false, "رمز عبور یا نام کاربری صحیح نمی باشد.");
                                        }
                                      } catch (e) {}
                                      setState(() {
                                        vis = false;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: CBase().getFullHeight(context) / 30,
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
    );
  }
}
