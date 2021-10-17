import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Model/GoogleAuth.dart';
import 'package:copapp/Model/LoginModel.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/Utilities/SharedPreferencePath.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:copapp/View/Pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  var circularVis = false;
  var autoLoginValue = "0".obs;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    loadAutoLoginDataLocaly().then((value) {
      if (autoLoginValue.value == '1') {
        UserServiceV2().initialization().then((value) async {
          circularVis = true;
          update([2]);
          userName.text = UserServiceV2().getUser().userName!;
          password.text = UserServiceV2().getUser().password!;

          LoginController()
              .LoginFunc(userName: userName.text, password: password.text)
              .then((value) {
            circularVis = false;
            update([2]);
          });
          // logingIn();
        });
      }
    });
    super.onInit();
  }

  setContext(BuildContext context) {
    CBase().setDeviceDimension(
        CBase().getFullWidth(context), CBase().getFullHeight(context));
  }

  setCircularVal(bool val) {
    circularVis = val;
    update([2]);
  }

  Future<bool> LoginFunc({
    required String userName,
    required String password,
  }) async {
    circularVis = true;
    update([2]);
    ResponseModel res = await UserServiceV2()
        .Token(LoginModel(password: password, userName: userName));
    if (res.isSuccess == false) {
      // setCircularVal(false);
      res.ShowMessage();
      circularVis = false;
      update([2]);
      return false;
    } else {
      if (autoLoginValue.value == '1') {
        saveAutoLoginDataLocaly(true);
      }
      // circularVis = false;
      // update([2]);
      // Get.o(HomePageV4());
      Get.offAll(
        () => HomePageV4(),
      );
      this.password.text = '';
      this.userName.text = '';
      circularVis = false;
      autoLoginValue = '0'.obs;
      update([2]);
      return false;
    }
  }

  LoginPress(
      {required String userName,
      required String password,
      required GlobalKey<ScaffoldState> scaffoldKey}) async {
    if (password == "" || userName == "") {
      Snacki().GETSnackBar(false, "فیلد رمز و پسورد نباید خالی باشد.");
    } else {
      LoginFunc(password: password, userName: userName);
      update([2]);
    }

    // Future.delayed(Duration(milliseconds: 1000), () {
    //   circularVis.value = false;
    //   Get.to(() => HomePage());
    // });
  }

  Future saveAutoLoginDataLocaly(bool al) async {
    await SharedPreferencePath()
        .setUserDataInSharePrefrences(al ? "1" : "0", "autoLoginKey");
    autoLoginValue.value = al ? "1" : "0";
  }

  Future loadAutoLoginDataLocaly() async {
    var data = await SharedPreferencePath()
        .getUserDataInSharePrefrences("autoLoginKey");
    autoLoginValue.value = data ?? '0';

    // return autoLoginValue.value;
  }

  logingIn() async {
    ResponseModel res = await UserServiceV2().AutoLogin();

    if (res.isSuccess) {
      // Get.off(
      //   HomePage(),
      // );
    }
  }

  GoogleAuth GoogleSignToPost(GoogleSignInAccount GoogleUser) {
    GoogleAuth googleAuthUser = GoogleAuth(
      id: GoogleUser.id,
      displayName: GoogleUser.displayName,
      photoUrl: GoogleUser.photoUrl,
      email: GoogleUser.email,
    );

    return googleAuthUser;
  }

  void checkLoginVal() {
    if (autoLoginValue.value == "1") {
      autoLoginValue.value = "0";
    } else {
      autoLoginValue.value = "1";
    }
  }
}
