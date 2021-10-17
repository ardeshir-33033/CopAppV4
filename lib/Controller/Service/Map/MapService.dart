import 'dart:convert';

import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Model/Neshan/NeshanModel.dart';
import 'package:http/http.dart' as http;


class MapService extends Api {
  var headers = {'Api-Key': 'service.bKw7hhrQwUDh2NS7z4JxxiiZ4VS0k6GYMLrjQGqB'};

  Future<ResponseModel> GetMapAddress(double lat, double lng) async {
    String url = 'https://api.neshan.org/v2/reverse?lat=${lat}&lng=${lng}';
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    var res = MapresponseGetter(ResponseEnum.ResponseModelEnum, response);
    if(res != null && res != null){
      res = NeshanAddress.fromJson(res);
      return ResponseModel(data: res , isSuccess: true , message: "",statusCode: "200");
    }else{
      return ResponseModel(data: "" , isSuccess: false , message: "مشکل در اتصال به نشان",statusCode: "500");
    }

  }

  MapresponseGetter<T>(ResponseEnum typeEnum, http.Response response) {
    try {
      switch (typeEnum) {
        case ResponseEnum.ResponseModelEnum:
          String data = utf8.decode(response.bodyBytes);

          if (data == null || data.isEmpty)
            return ResponseModel(
              statusCode: "555",
              isSuccess: false,
              data: null,
            );

          return json.decode(data);
        default:
          return response.bodyBytes;
      }
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }
}
