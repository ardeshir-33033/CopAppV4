import 'dart:convert';

import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingOrderPartial.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';



class PartialService extends Api {
  Future<ResponseModel<OrderHeader>> PartialAddProduct(
      int productId, double qty) async {
    var map = {"productId": productId, "rowNumber": 0, "qty": qty};

    var json = jsonEncode(map);

    var response = await HTTPPOST(
      RoutingPartial.Post_PartialAddProduct,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    // response.data = OrderHeader.fromJson(response.data);

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<OrderHeader>> PartialUpdateProduct(
      int productId, double qty, int orderId) async {
    var map = {"productId": productId, "rowNumber": 0, "qty": qty};

    var json = jsonEncode(map);

    var response = await HTTPPOST(
      RoutingPartial.Post_PartialAddProduct,
      [QueryModel(name: "orderId", value: "$orderId")],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader.fromJson(response.data);

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<OrderHeader>> PartialDeleteProduct(
      int productId, int orderId) async {
    var response = await HTTPDELETE(
      RoutingPartial.Post_PartialAddProduct,
      [
        QueryModel(name: 'id', value: '$productId'),
        QueryModel(name: 'orderId', value: '$productId')
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader.fromJson(response.data);

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }
}
