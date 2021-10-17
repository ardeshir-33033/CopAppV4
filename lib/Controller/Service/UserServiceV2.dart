import 'dart:convert';
import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingUser.dart';
import 'package:copapp/Model/AuthModel.dart';
import 'package:copapp/Model/GoogleAuth.dart';
import 'package:copapp/Model/JwtSecurityToken.dart';
import 'package:copapp/Model/LoginModel.dart';
import 'package:copapp/Model/User.dart';
import 'package:copapp/Model/UserVerifyCodeModel.dart';
import 'package:copapp/Model/phoneNumberModel.dart';
import 'package:copapp/Utilities/SharedPreferencePath.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart' as path;

import '../../Api/Enums.dart';

class UserServiceV2 extends Api {
  // consts
  String userKey = "user-data";
  String jwtKey = "jwt-data";
  String userTypeKey = "type-data";
  // String autoLoginKey = "auto-login-data";

  // models
  static JwtSecurityToken? jwt;
  static User? user;
  static int? profileId;
  static int? chairId;
  Future<User?> initialization() async {
    // userType = await loadUserTypeLocaly();

    user = await loadUserDataLocaly();
  }

  Future saveAutoLoginDataLocaly(bool al) async {
    await SharedPreferencePath()
        .setUserDataInSharePrefrences(al ? "1" : "0", "autoLoginKey");
    // autoLoginValue.value = al ? "1" : "0";
  }

  Future<User?> loadUserDataLocaly() async {
    try {
      var json = jsonDecode(
          await SharedPreferencePath().getUserDataInSharePrefrences(userKey) ??
              "");
      if (json != null) {
        user = User.fromJson(json);
      }
    } catch (e) {}

    return user;
  }

  Future<ResponseModel<AuthModel>> Token(LoginModel model) async {
    // validation
    if (model == null)
      return ResponseModel<AuthModel>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    FormData form = FormData.fromMap(model.toFormData());

    var response = await HTTPPOSTFORM<AuthModel>(
      RoutingUser.POST_Token,
      [],
      form,
      HeaderEnum.FormDataHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      profileId = response.data['user']['profile']['id'];
      chairId = AuthModel().fromJson(response.data).user!.chairs!.first.chairId;
      response.data = AuthModel().fromJson(response.data);
      response.data.user.userName = model.userName;
      response.data.user.password = model.password;
      user = response.data.user;
      saveUserDataLocaly(user!);

      jwt = response.data.jwt;
      saveJWTDataLocaly(jwt!);
    }

    return ResponseModel<AuthModel>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<AuthModel>> AutoLogin() async {
    if (user != null && user!.userName != null && user!.password != null) {
      return await Token(
        LoginModel(
            grantType: "password",
            userName: user!.userName,
            password: user!.password),
      );
    }

    return ResponseModel<AuthModel>(
      isSuccess: false,
      statusCode: "500",
      data: AuthModel(),
      message: "ورود خودکار موفقیت آمیز نبود",
    );
  }

  Future GoogleLogIn(GoogleAuth modelAuth) async {
    var json = jsonEncode(modelAuth.toJson());
    var response = await HTTPPOST(
      RoutingUser.Post_GoogleToken,
      [],
      json,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    JwtSecurityToken jwt1 = JwtSecurityToken();
    if (response.isSuccess) {
      jwt1.accessToken = response.data['access_token'] ?? "";
      jwt1.refreshToken = response.data['refresh_token'] ?? "";
      jwt1.tokenType = response.data['token_type'] ?? "";
      jwt1.expiresIn = response.data['expires_in'] ?? 0;

      jwt = jwt1;
      saveJWTDataLocaly(jwt!);

      user = User.fromJson(response.data['user']);
      // profileId = user.profile.id;
      saveUserDataLocaly(user!);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future saveUserDataLocaly(User? model) async {
    await SharedPreferencePath()
        .setUserDataInSharePrefrences(jsonEncode(model), userKey);
  }

  setJWTData(JwtSecurityToken model) {
    jwt = model;
  }

  saveJWTDataLocaly(JwtSecurityToken? model) async {
    await SharedPreferencePath()
        .setUserDataInSharePrefrences(jsonEncode(model), jwtKey);
  }

  Future<JwtSecurityToken?> loadJWTDataLocaly() async {
    var json = jsonDecode(
        await SharedPreferencePath().getUserDataInSharePrefrences(jwtKey) ??
            "");

    jwt = JwtSecurityToken.fromJson(json);

    return jwt;
  }

  JwtSecurityToken getJWT() {
    return jwt!;
  }

  String getToken() {
    return jwt?.accessToken ?? "";
  }

  Future saveUserTypeLocaly(String type) async {
    await SharedPreferencePath()
        .setUserDataInSharePrefrences(type, userTypeKey);
  }

  Future loadUserTypeLocaly() async {
    var ut =
        await SharedPreferencePath().getUserDataInSharePrefrences(userTypeKey);

    return ut ?? "";
  }

  String getUserType() {
    return userKey;
  }

  User getUser() {
    return user!;
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

  Future<ResponseModel> ResetPassword(String resetUserName) async {
    var response = await HTTPDELETE(
      RoutingUser.DELETE_ResetPassword,
      [QueryModel(name: "userName", value: resetUserName)],
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.message,
    );
  }

  Future<ResponseModel> ChangePassword(String current, String password) async {
    if (current.isEmpty && password.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPDELETE(
      RoutingUser.DELETE_ChangeThePassword,
      [
        QueryModel(
          name: "userName",
          value: user?.userName ?? "",
        ),
        QueryModel(
          name: "currentPassword",
          value: current,
        ),
        QueryModel(
          name: "newPassword",
          value: password,
        )
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.message,
    );
  }

  Future<ResponseModel> SendAgainValidCode() async {
    var response = await HTTPGET(
      RoutingUser.GET_SendValidCodeAgain,
      [
        QueryModel(
          name: "username",
          value: user?.userName ?? "",
        )
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.message,
    );
  }

  Future<ResponseModel> SuspendedUser(String phone) async {
    if (phone.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );
    phoneNumberModel model = phoneNumberModel(phoneNumber: phone);

    // var map = {"phoneNumber": phone};
    var json2 = model.toJson();
    // print(json2);
    var jsonModel = jsonEncode(json2);
    // print(jsonModel);

    // var json = jsonEncode(map);

    var response = await HTTPPOST(
      RoutingUser.POST_SuspendedUser,
      [],
      jsonModel,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.message,
    );
  }

  Future<ResponseModel> SuspendedUserVerify(String phone, String code) async {
    if (code.isEmpty && phone.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );
    userVerifyCodeModel model =
        userVerifyCodeModel(phoneNumber: phone, code: code);
    var json = model.toJson();
    var jsonModel = jsonEncode(json);

    // var map = {"phoneNumber": phone, "code": code};
    //
    // var json = jsonEncode(map);

    var response = await HTTPPOST(
      RoutingUser.POST_SuspendedUserVerify,
      [],
      jsonModel,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.message,
    );
  }

  Future<ResponseModel> AgainSendValidCodeForSuspendedUser(String phone) async {
    if (phone.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var map = {"phoneNumber": phone};

    var json = jsonEncode(map);

    var response = await HTTPPOST(
      RoutingUser.POST_AgainSendValidCodeForSuspendedUser,
      [],
      json,
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.message,
    );
  }

  Future<ResponseModel> SuspendedUserResetPassword(String phone) async {
    if (phone.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var map = {"phoneNumber": phone};

    var json = jsonEncode(map);
    var response = await HTTPPOST(
      RoutingUser.POST_SuspendedUserVerifyResert,
      [],
      json,
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.message,
    );
  }

  Future<ResponseModel> SuspendedUserVerifyReset(
      String phone, String code) async {
    if (code.isEmpty && phone.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var map = {"phoneNumber": phone, "code": code};

    var json = jsonEncode(map);

    var response = await HTTPPOST(
      RoutingUser.POST_SuspendedUserVerifyResert,
      [],
      json,
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.message,
    );
  }

  Future<ResponseModel<User>> CreateWithValidation(
      {String? phone, String? password}) async {
    if (phone!.isEmpty && password!.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    ValidationModel model =
        ValidationModel(phoneNumber: phone, password: password);
    var json = model.toJson();
    var jsonModel = jsonEncode(json);

    // var map = {"phoneNumber": phone, "password": password};
    //var map = {"phoneNumber": '0919941532', "password": '109876'};
    //
    // var json = jsonEncode(map);

    var response = await HTTPPOST<User>(
      RoutingUser.POST_CreateWithValidation,
      [],
      jsonModel,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = User.fromJson(response.data);

    return ResponseModel<User>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future? setUserModel(User model) {
    user = model;
  }
}
