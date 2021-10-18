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

    user = await loadUserDataLocal();
  }

  Future saveAutoLoginDataLocal(bool al) async {
    await SharedPreferencePath()
        .setUserDataInSharePrefrences(al ? "1" : "0", "autoLoginKey");
    // autoLoginValue.value = al ? "1" : "0";
  }

  Future<User?> loadUserDataLocal() async {
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

  // ignore: non_constant_identifier_names
  Future<ResponseModel<AuthModel>> Token(LoginModel model) async {
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
      saveUserDataLocal(user!);

      jwt = response.data.jwt;
      saveJWTDataLocal(jwt!);
    }

    return ResponseModel<AuthModel>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  // ignore: non_constant_identifier_names
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

  Future googleLogIn(GoogleAuth modelAuth) async {
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
      saveJWTDataLocal(jwt!);

      user = User.fromJson(response.data['user']);
      // profileId = user.profile.id;
      saveUserDataLocal(user!);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future saveUserDataLocal(User? model) async {
    await SharedPreferencePath()
        .setUserDataInSharePrefrences(jsonEncode(model), userKey);
  }

  saveJWTDataLocal(JwtSecurityToken? model) async {
    await SharedPreferencePath()
        .setUserDataInSharePrefrences(jsonEncode(model), jwtKey);
  }

  String getToken() {
    return jwt?.accessToken ?? "";
  }

  User getUser() {
    return user!;
  }

  GoogleAuth googleSignToPost(GoogleSignInAccount googleUser) {
    GoogleAuth googleAuthUser = GoogleAuth(
      id: googleUser.id,
      displayName: googleUser.displayName,
      photoUrl: googleUser.photoUrl,
      email: googleUser.email,
    );

    return googleAuthUser;
  }

  Future<ResponseModel> resetPassword(String resetUserName) async {
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

  Future<ResponseModel> changePassword(String current, String password) async {
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

  Future<ResponseModel> sendAgainValidCode() async {
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

  Future<ResponseModel> suspendedUser(String phone) async {
    if (phone.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );
    PhoneNumberModel model = PhoneNumberModel(phoneNumber: phone);

    Map<String, dynamic> json2 = model.toJson();
    String jsonModel = jsonEncode(json2);

    ResponseModel response = await HTTPPOST(
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

  Future<ResponseModel> suspendedUserVerify(String phone, String code) async {
    if (code.isEmpty && phone.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );
    UserVerifyCodeModel model =
        UserVerifyCodeModel(phoneNumber: phone, code: code);
    Map<String, dynamic> json = model.toJson();
    String jsonModel = jsonEncode(json);

    ResponseModel response = await HTTPPOST(
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

  Future<ResponseModel> againSendValidCodeForSuspendedUser(String phone) async {
    if (phone.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    Map<String, dynamic> map = {"phoneNumber": phone};
    String json = jsonEncode(map);

    ResponseModel response = await HTTPPOST(
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

  Future<ResponseModel> suspendedUserResetPassword(String phone) async {
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

  Future<ResponseModel> suspendedUserVerifyReset(
      String phone, String code) async {
    if (code.isEmpty && phone.isEmpty)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    Map<String, dynamic> map = {"phoneNumber": phone, "code": code};
    String json = jsonEncode(map);

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

  Future<ResponseModel> createWithValidation(
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
    Map<String, dynamic> json = model.toJson();
    String jsonModel = jsonEncode(json);

    ResponseModel response = await HTTPPOST(
      RoutingUser.POST_CreateWithValidation,
      [],
      jsonModel,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = User.fromJson(response.data);
    }

    return ResponseModel(
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
