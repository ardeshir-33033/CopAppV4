import 'package:copapp/Controller/Controllers/LoginController.dart';
import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/View/Pages/LoginPages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Base.dart';

class Snacki with ChangeNotifier {
  Future? showExitSnack(GlobalKey<ScaffoldState> scaffold) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 7),
      content: Container(
          height: 50.0,
          child: Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "خروج از برنامه",
                      style: TextStyle(
                        fontSize: CBase().getTextfontSizeByScreen(),
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    Text(
                      "آیا مایل به خروج از برنامه هستید ؟",
                      style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen()),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Row(
                children: [
                  InkWell(
                    child: Container(
                      width: 50.0,
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: CBase().basePrimaryColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          "بله",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: CBase().getTextfontSizeByScreen(),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      CartServiceV2.myCart = null;
                      LoginController loginController = Get.find();
                      loginController.password.text = '';
                      loginController.userName.text = '';
                      loginController.autoLoginValue('0');
                      loginController.circularVis = false;
                      Navigator.pushAndRemoveUntil(
                          scaffold.currentContext!,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                      // Navigator.popAndPushNamed(context, routeName)
                      // Get.offAll(()=>LoginPage());
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: 50.0,
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          "خیر",
                          style: TextStyle(
                            color: CBase().textPrimaryColor,
                            fontSize: CBase().getTextfontSizeByScreen(),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      // ignore: deprecated_member_use
                      scaffold.currentState!.hideCurrentSnackBar();
                      // return false;
                    },
                  )
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          )),
    );

    // ignore: deprecated_member_use
    scaffold.currentState!.showSnackBar(snackBar);
    Future.delayed(Duration(seconds: 3), () {
      // ignore: deprecated_member_use
      scaffold.currentState!.hideCurrentSnackBar();
    });
  }
  //
  // ShowMessage(
  //     {bool isSuccess = false,
  //     String message = "",
  //     required GlobalKey<ScaffoldState> scaffold}) {
  //   final snackBar = SnackBar(
  //     content: Container(
  //       height: 50.0,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             isSuccess ? "عملیات موفق" : "عملیات ناموفق",
  //             style: TextStyle(
  //               fontSize: CBase().getTextfontSizeByScreen(),
  //               fontWeight: FontWeight.bold,
  //               color:
  //                   isSuccess ? CBase().successColor : CBase().basePrimaryColor,
  //             ),
  //           ),
  //           Text(
  //             message,
  //             style: TextStyle(
  //               fontSize: CBase().getTextfontSizeByScreen(),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //
  //   scaffold.currentState!.showSnackBar(snackBar);
  // }

  // ignore: non_constant_identifier_names
  GETSnackBar(bool isSuccessful , String text){
    Get.showSnackbar(GetBar(
      titleText: Text(
        isSuccessful ? "عملیات موفق" : "عملیات ناموفق",
        style: TextStyle(
          fontSize: CBase().getTextfontSizeByScreen(),
          fontWeight: FontWeight.bold,
          color: isSuccessful ? CBase().successColor : CBase().basePrimaryColor,
        ),
      ),
      messageText: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: CBase().getTextfontSizeByScreen(),
        ),
      ),
      duration: Duration(seconds: 2),
      snackStyle: SnackStyle.GROUNDED,
    ));
  }
}
