import 'dart:convert';
import 'dart:io';

import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingProfile.dart';
import 'package:copapp/Model/Address.dart';
import 'package:copapp/Model/CardModel.dart';
import 'package:copapp/Model/FavoriteProduct.dart';
import 'package:copapp/Model/MainData.dart';
import 'package:copapp/Model/Profile.dart';
import 'package:copapp/Model/ProfileInformation.dart';
import 'package:copapp/Utilities/Sharei.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../Api/Enums.dart';
import 'Extensions/ProfileExtension.dart';
import 'UserServiceV2.dart';

class ProfileServiceV2 extends UserServiceV2 with ProfileExtensions {
  // models
  static Profile profile = new Profile();
  static bool uploadPic = false;

  Future<bool> upload(File imageFile) async {
    var head = Api().bearerHeader;
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://copserver.dinavision.org/api/v1/Profile/EditPersonalAvatar'));
    request.files
        .add(await http.MultipartFile.fromPath('avatar', imageFile.path));
    request.headers.addAll(head);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // String varo = await response.stream.bytesToString();
      return true;
    } else {
      // String varo = await response.stream.bytesToString();
      return false;
    }
  }

  Future<ResponseModel?> uploadScreenShot(int index) async {
    File file = Sharei().getScreenShot(index);
    Map<String, String> head = Api().bearerHeader;
    var request = http.MultipartRequest(
        'POST', Uri.parse(RoutingProfile.POST_UploadScreenShot));

    request.files.add(await http.MultipartFile.fromPath('screen', file.path));
    request.headers.addAll(head);
    http.StreamedResponse response = await request.send();

    String jsonString = await response.stream.bytesToString();
    var data = json.decode(jsonString);

    if (response.statusCode == 200) {
      if (data["statusCode"] == "success") {
        return ResponseModel(
            message: "موفقیت آمیز",
            isSuccess: true,
            data: data["data"],
            statusCode: "success");
      }
    } else {
      return ResponseModel(
          message: "عملیات با شکست مواجه شد.",
          isSuccess: false,
          data: data["data"],
          statusCode: "failed");
    }
  }

  Future<ResponseModel<Profile>> editPersonalInformation(
      {bool isImageDeleted = false}) async {
    // profile = Profile();
    FormData form = FormData.fromMap({
      "FirstName": profile.firstName,
      "LastName": profile.lastName,
      "UserPhoneNumber": profile.phoneNumber,
      "TelePhoneNumber": profile.telePhoneNumber,
      "NationalCode": profile.nationalCode,
      "EmailAddress": profile.emailAddress,
      "YearBirthDate": profile.yearBirthDate,
      "MonthBirthDate": profile.monthBirthDate,
      "DayBirthDate": profile.dayBirthDate,
      "IsImageDeleted": isImageDeleted,
      "Id": profile.id
    });

    ResponseModel response = await HTTPPOSTFORM<Profile>(
      RoutingProfile.POST_EditPersonalInformation,
      [],
      form,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = Profile.fromJson(response.data);
    }
    return ResponseModel<Profile>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> setSecondPassword(String password) async {
    Map<String, String> map = {
      "password": "$password",
    };
    String json = jsonEncode(map);
    ResponseModel response = await HTTPPOST(
        RoutingProfile.POST_SetSecondPassword,
        [],
        json,
        HeaderEnum.BearerHeaderEnum,
        ResponseEnum.ResponseModelEnum);

    return response;
  }

  Future<bool> changeSecondPassword(String password, String newPassword) async {
    Map<String, String> map = {
      "password": "$password",
      "newPassword": "$newPassword"
    };
    String json = jsonEncode(map);
    ResponseModel response = await HTTPPOST(
      RoutingProfile.POST_ChangeSecondPassword,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response.isSuccess;
  }

  Future<ResponseModel> checkSecondPassword(String password) async {
    Map<String, String> map = {
      "password": "$password",
    };
    String json = jsonEncode(map);
    ResponseModel response = await HTTPPOST(
      RoutingProfile.POST_CheckSecondPassword,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response;
  }

  Future<ResponseModel<Profile>> getPersonalInformation() async {
    ResponseModel response = await HTTPGET<Profile>(
      RoutingProfile.GET_GetPersonalInformation,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = Profile.fromJson(response.data);
      profile = response.data;
    }

    return ResponseModel<Profile>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> setAddresses(Address address) async {

    String json = jsonEncode(address.toJson());

    ResponseModel response = await HTTPPOST(
      RoutingProfile.POST_SetAddresses,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.message,
    );
  }

  Future<ResponseModel> setBankCardNumber(CardModel card) async {
    var json = jsonEncode(card.toJson());
    var response = await HTTPPOST(
      RoutingProfile.POST_SetBankCardNumber,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      // data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> deleteAddress(int id) async {
    if (id == 0)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    ResponseModel response = await HTTPDELETE(
      RoutingProfile.DELETE_Delete,
      [
        QueryModel(
          name: "id",
          value: id.toString(),
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

  Future<ResponseModel<List<Address>>> getAddresses() async {
    var response = await HTTPGET<List<Address>>(
      RoutingProfile.GET_GetAddresses,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      profile = Profile();
      profile.addresses = Address().listFromJson(response.data);
      response.data = Address().listFromJson(response.data);
    }

    return ResponseModel<List<Address>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }



  // Future<ResponseModel<List<MustBuyProduct>>> GetProductMostBuy() async {
  //   var response = await HTTPGET<List<MustBuyProduct>>(
  //     RoutingProfile.GET_GetProductMostBuy,
  //     [],
  //     HeaderEnum.BearerHeaderEnum,
  //     ResponseEnum.ResponseModelEnum,
  //   );

  //   response.data = MustBuyProduct().listFromJson(response.data);

  //   return ResponseModel<List<MustBuyProduct>>(
  //     isSuccess: response.isSuccess,
  //     statusCode: response.statusCode,
  //     data: response.data,
  //     message: response.message,
  //   );
  // }

}
