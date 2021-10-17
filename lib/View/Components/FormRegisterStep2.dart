import 'dart:async';

import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/LoginPages/NumberPage.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart'; //import

import 'RedButton.dart';

class FormRegisterStep2 extends StatefulWidget {
  // UserRegisterModel user = UserRegisterModel();
  String phoneNumber;

  FormRegisterStep2({
    required this.phoneNumber,
    // this.user,
  });

  @override
  _FormRegisterStep2State createState() => _FormRegisterStep2State();
}

class _FormRegisterStep2State extends State<FormRegisterStep2> {
  // UserRegisterModel user = UserRegisterModel();

  TextEditingController verifyCode = TextEditingController();
  bool vis = false;

  // TextEditingController confirm = TextEditingController();

  // _FormRegisterStep2State({this.user});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CBase().getFullWidth(context) / 1.4,
      padding: EdgeInsets.only(
        bottom: 10.0,
        // left: 50.0,
        // right: 50.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              "تایید شماره تلفن",
              style: TextStyle(
                fontFamily: CBase().fontFamily,
                color: CBase().textPrimaryColor,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
                top: 15.0, left: 10.0, right: 10.0, bottom: 0.0),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 40.0,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(),
              child: TextField(
                obscureText: true,
                controller: verifyCode,
                decoration: InputDecoration(
                  hintText: "  کد ",
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
          Container(
            padding: EdgeInsets.only(top: 0.0, bottom: 40.0),
            child: Row(
              children: [
                FlatButton(
                  child: Text(
                    "ارسال دوباره کد",
                    style: TextStyle(
                      fontFamily: CBase().fontFamily,
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      color: CBase().textPrimaryColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  highlightColor: Colors.grey[200],
                  onPressed: () async {
                    if (_start == 0) {
                      await UserServiceV2().AgainSendValidCodeForSuspendedUser(
                          widget.phoneNumber);
                      _start = 60;
                      startTimer();
                      setState(() {});
                    }
                  },
                ),
                Text(
                  "$_start",
                  style: TextStyle(
                    fontFamily: CBase().fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: CBase().textPrimaryColor,
                  ),
                ),
              ],
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
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CBase().basePrimaryColor),
                      )
                    : Text(""),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          REDButton(
            title: "بعدی",
            onTapCallback: (result) async {
              setState(() {
                vis = true;
              });
              widget.phoneNumber = widget.phoneNumber.toEnglishDigit();
              verifyCode.text = verifyCode.text.toEnglishDigit();
              // if (password.text == confirm.text) {
              //   user.password = password.text;
              ResponseModel response = await UserServiceV2()
                  .SuspendedUserVerify(widget.phoneNumber, verifyCode.text);

              if (response.isSuccess) {
                setState(() {
                  vis = true;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QC_NumberPanel(
                              phoneNumber: widget.phoneNumber,
                            )));
              }
            },
          ),
        ],
      ),
    );
  }

  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          // Navigator.pop(context);
          // Navigator.pop(context);
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
