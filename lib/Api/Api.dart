import 'dart:convert';
import 'dart:developer';
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
      case HeaderEnum.BearerHeaderEnum:
        return bearerHeader;
      case HeaderEnum.FormDataHeaderEnum:
        return formDataHeader;
      case HeaderEnum.BasicHeaderEnum:
        return basicHeader;
      case HeaderEnum.EmptyHeaderEnum:
        return null;
      default:
        return basicHeader;
    }
  }

  String generateQuery(List<QueryModel> queries) {
    String query = "";
    if (queries.length > 0) {
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

  String urlGenerator(String url, List<QueryModel> query) {
    var queryPart = generateQuery(query);

    return "$url$queryPart";
  }

  responseGetter<T>(ResponseEnum typeEnum, http.Response response) {
    if (response.statusCode != 200) {
      printError('Url: ${response.request!.url.path}');
      printError('StatusCode: ${response.statusCode}');
    }
    try {
      switch (typeEnum) {
        case ResponseEnum.ResponseModelEnum:
          String data = utf8.decode(response.bodyBytes);
          ResponseModel result = ResponseModel().fromJson(
            json.decode(data),
          );
          if (!result.isSuccess ||
              (result.statusCode != '200' && result.statusCode != 'success') ||
              result.data == null) {
            printError('Url: ${response.request!.url.path}');
            printError('StatusCode: ${result.statusCode}');
            printError('IsStatus: ${result.isSuccess}');
            printError('Data: ${result.data.toString()}');
            printError('Message: ${result.message}');
          }
          if (data.isEmpty) {
            printError('Url: ${response.request!.url.path}');
            printError('Data: $data');
            return ResponseModel(
                statusCode: "555",
                isSuccess: false,
                data: null,
                message: "?????????? ???? ???????????? ???? ???????? ?????????? ???????? ??????.");
          }

          return result;
        // ResponseModel().fromJson(
        //   json.decode(data),
        // );
        default:
          return response.bodyBytes;
      }
    } catch (e) {
        printError('Url: ${response.request!.url}');
      printError('StatusCode: ${response.statusCode}');
      printError('Error: ${e.toString()}');
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "?????????? ???? ???????????? ???? ???????? ??????");
    }
  }

  void printError(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  responseDynamicGetter<T>(ResponseEnum typeEnum, Response<dynamic> response) {
    if (response.statusCode != 200) {
      printError('Url: ${response.realUri}');
      printError('StatusCode: ${response.statusCode}');
      printError('StatusMessage: ${response.statusMessage}');
      printError('Data: ${response.data.toString()}');
    }
    try {
      switch (typeEnum) {
        case ResponseEnum.ResponseModelEnum:
          ResponseModel result = ResponseModel().fromJson(response.data);
          if (!result.isSuccess ||
              (result.statusCode != '200' && result.statusCode != 'success') ||
              result.data == null) {
            printError('Url: ${response.realUri}');
            printError('StatusCode: ${result.statusCode}');
            printError('IsStatus: ${result.isSuccess}');
            printError('Data: ${result.data.toString()}');
            printError('Message: ${result.message}');
          }
          return result;
        default:
          return response.data.bodyBytes;
      }
    } catch (e) {
      printError('Url: ${response.realUri}');
      printError('StatusCode: ${response.statusCode}');
      printError('StatusMessage: ${response.statusMessage}');
      printError('Data: ${response.data.toString().substring(0, 100)}');
      printError('Error: ${e.toString()}');
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "?????????? ???? ???????????? ???? ???????? ??????");
    }
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPGET<T>(
    String url,
    List<QueryModel> query,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      var response = await http.get(
        Uri.parse(urlGenerator(url, query)),
        headers: headerGetter(headerType),
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "?????????? ???? ???????????? ???? ???????? ??????");
    }
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPDELETE<T>(
    String url,
    List<QueryModel> query,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      var response = await http.delete(
        Uri.parse(urlGenerator(url, query)),
        headers: headerGetter(headerType),
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "?????????? ???? ???????????? ???? ???????? ??????");
    }
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPPOST<T>(String url, List<QueryModel> query,
      var body, HeaderEnum headerType, ResponseEnum responseType) async {
    try {
      var response = await http.post(
        Uri.parse(urlGenerator(url, query)),
        headers: headerGetter(headerType),
        body: body,
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "?????????? ???? ???????????? ???? ???????? ??????");
    }
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPPUT<T>(
    String url,
    List<QueryModel> query,
    var body,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      var response = await http.put(
        Uri.parse(urlGenerator(url, query)),
        headers: headerGetter(headerType),
        body: body,
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "?????????? ???? ???????????? ???? ???????? ??????");
    }
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPPUTFILE<T>(
    String url,
    List<QueryModel> query,
    FormData body,
    ResponseEnum responseType,
  ) async {
    try {
      Dio dio = Dio();

      var response = await dio.put(
        urlGenerator(url, query),
        data: body,
      );

      return responseGetter<T>(responseType, response.data);
    } catch (e) {
      return ResponseModel(
          isSuccess: false,
          statusCode: "500",
          data: null,
          message: "?????????? ???? ???????????? ???? ???????? ??????");
    }
  }

  // ignore: non_constant_identifier_names
  Future<ResponseModel> HTTPPOSTFORM<T>(
    String url,
    List<QueryModel> query,
    FormData body,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      Dio dio = Dio();

      var response = await dio.post(urlGenerator(url, query),
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
          message: "?????????? ???? ???????????? ???? ???????? ??????");
    }
  }
}
