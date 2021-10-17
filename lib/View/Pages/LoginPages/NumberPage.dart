import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Model/User.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:copapp/View/Components/RedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'LoginPage.dart';

class QC_NumberPanel extends StatefulWidget {
  String phoneNumber;

  QC_NumberPanel({
    required this.phoneNumber,
  });

  @override
  _QC_NumberPanelState createState() => _QC_NumberPanelState();
}

class _QC_NumberPanelState extends State<QC_NumberPanel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool vis = false;
  TextEditingController password = TextEditingController();
  TextEditingController repeatPassword = TextEditingController();
  ResponseModel? result1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: CBase().getFullHeight(context) / 2.8,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: CBase().getFullHeight(context) / 3,
                              decoration: BoxDecoration(
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
                    Container(
                      width: CBase().getFullWidth(context) / 1.4,
                      padding: const EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "ثبت رمز عبور",
                              style: TextStyle(
                                color: CBase().textPrimaryColor,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                              top: 15.0,
                              left: 10.0,
                              right: 10.0,
                              bottom: 0.0,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40.0,
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextField(
                                controller: password,
                                decoration: InputDecoration(
                                  hintText: "  رمز عبور",
                                  hintStyle: TextStyle(
                                      fontSize:
                                          CBase().getTitlefontSizeByScreen(),
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
                            height: 30.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40.0,
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextField(
                                controller: repeatPassword,
                                decoration: InputDecoration(
                                  hintText: "  تکرار رمز عبور",
                                  hintStyle: TextStyle(
                                      fontSize:
                                          CBase().getTitlefontSizeByScreen(),
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
                            height: 45.0,
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
                                    ? CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            CBase().basePrimaryColor),
                                      )
                                    : Text(""),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          REDButton(
                            title: "بعدی",
                            onTapCallback: (result) async {
                              setState(() {
                                vis = true;
                              });
                              password.text = password.text.toEnglishDigit();
                              repeatPassword.text =
                                  repeatPassword.text.toEnglishDigit();

                              if (password.text == repeatPassword.text) {
                                result1 = await UserServiceV2()
                                    .CreateWithValidation(
                                        phone: widget.phoneNumber,
                                        password: password.text);
                              } else {
                                Snacki().GETSnackBar(
                                    false, "رمز عبور با تکرار آن همخوانی ندارد.");
                              }

                              setState(() {
                                vis = false;
                              });

                              if (result1 != null) {
                                UserServiceV2().setUserModel(User(
                                  userName: widget.phoneNumber,
                                ));
                                if (result1!.isSuccess) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                }

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         QC_Validation(user: result.data),
                                //   ),
                                // );
                              } else {
                                Snacki().GETSnackBar(false, "لطفا رمز و شماره همراه خود را بصورت صحیح وارد کنید.");
                              }
                            },
                          ),
                        ],
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
