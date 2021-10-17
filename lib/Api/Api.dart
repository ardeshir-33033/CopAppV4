import 'dart:convert';
import 'dart:io';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'Enums.dart';
import 'QueryModel.dart';
import 'ResponseModel.dart';

class Api {
  Map<String, String> imageHeader = {
    HttpHeaders.authorizationHeader:
        "Bearer ${UserServiceV2.jwt?.accessToken ?? ""}",
    "Accept": "multipart/byteranges",
    "content-type": "image/jpeg; charset=utf-8",
  };

  Map<String, String> bearerHeader = {
    HttpHeaders.authorizationHeader:
        "Bearer ${UserServiceV2.jwt?.accessToken ?? ""}",
    "Accept": "application/json",
    "content-type": "application/json; charset=utf-8",
  };

  Map<String, String> formDataHeader = {
    "Accept": "multipart/form-data",
    "content-type": "application/json; charset=utf-8",
  };

  Map<String, String> basicHeader = {
    "Accept": "application/json",
    "content-type": "application/json; charset=utf-8",
  };

  Map<String, String>? headerGetter(HeaderEnum typeEnum) {
    switch (typeEnum) {
      case HeaderEnum.ImageHeaderEnum:
        return imageHeader;
        break;
      case HeaderEnum.BearerHeaderEnum:
        return bearerHeader;
        break;
      case HeaderEnum.FormDataHeaderEnum:
        return formDataHeader;
        break;
      case HeaderEnum.BasicHeaderEnum:
        return basicHeader;
        break;
      case HeaderEnum.EmptyHeaderEnum:
        return null;
        break;
      default:
        return basicHeader;
    }
  }

  String GenerateQuery(List<QueryModel> queries) {
    String query = "";
    if (queries != null && queries.length > 0) {
      query += "?";
      queries.forEach((element) {
        if (element.value != null && element.value != "null") {
          String? nm = element.name;
          String? vl = element.value;

          query += "$nm=$vl&";
        }
      });
    }

    return query;
  }

  String UrlGenerator(String url, List<QueryModel> query) {
    var queryPart = GenerateQuery(query);

    return "$url$queryPart";
  }

  responseGetter<T>(ResponseEnum typeEnum, http.Response response) {
    try {
      switch (typeEnum) {
        case ResponseEnum.ResponseModelEnum:
          String data = utf8.decode(response.bodyBytes);

          if (data == null || data.isEmpty)
            return ResponseModel(
              statusCode: "555",
              isSuccess: false,
              data: null,
              message: "مشکلی در ارتباط با سرور بوجود آمده است."
            );

          return ResponseModel().fromJson(
            json.decode(data),
          );
        default:
          return response.bodyBytes;
      }
    } catch (e) {
      return  ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }

  responseDynamicGetter<T>(ResponseEnum typeEnum, Response<dynamic> response) {
    try {
      switch (typeEnum) {
        case ResponseEnum.ResponseModelEnum:
          return ResponseModel().fromJson(response.data);
          break;
        default:
          return response.data.bodyBytes;
      }
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }

  Future<ResponseModel> HTTPGET<T>(
    String url,
    List<QueryModel> query,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      var response = await http.get(
        Uri.parse(UrlGenerator(url, query)),
        headers: headerGetter(headerType),
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }

  Future<ResponseModel> HTTPDELETE<T>(
    String url,
    List<QueryModel> query,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      var response = await http.delete(
        Uri.parse(UrlGenerator(url, query)),
        headers: headerGetter(headerType),
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }

  Future<ResponseModel> HTTPPOST<T>(String url, List<QueryModel> query,
      var body, HeaderEnum headerType, ResponseEnum responseType) async {
    try {
      var response = await http.post(
        Uri.parse(UrlGenerator(url, query)),
        headers: headerGetter(headerType),
        body: body,
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }

  Future<ResponseModel> HTTPPUT<T>(
    String url,
    List<QueryModel> query,
    var body,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      var response = await http.put(
        Uri.parse(UrlGenerator(url, query)),
        headers: headerGetter(headerType),
        body: body,
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }

  Future<ResponseModel> HTTPPUTFILE<T>(
    String url,
    List<QueryModel> query,
    FormData body,
    ResponseEnum responseType,
  ) async {
    try {
      Dio dio = Dio();

      var response = await dio.put(
        UrlGenerator(url, query),
        data: body,
      );

      return responseGetter<T>(responseType, response.data);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }

  Future<ResponseModel> HTTPPOSTFORM<T>(
    String url,
    List<QueryModel> query,
    FormData body,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      Dio dio = Dio();

      var response = await dio.post(UrlGenerator(url, query),
          data: body,
          options: Options(
            headers: headerGetter(headerType),
          ));

      return responseDynamicGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "خطایی در عملیات رخ داده است");
    }
  }
}
