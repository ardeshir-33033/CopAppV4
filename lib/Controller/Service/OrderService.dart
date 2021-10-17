import 'dart:convert';

import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingOrder.dart';
import 'package:copapp/Model/Create/CreateOrder.dart';
import 'package:copapp/Model/Create/CreateProductModel.dart';
import 'package:copapp/Model/Create/UpdateProductModel.dart';
import 'package:copapp/Model/FilterResponseModel.dart';
import 'package:copapp/Model/Order/OrderFilterModel.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';

class OrderServiceV2 extends Api {
  static String PaymentAuthority = "";

  Future<ResponseModel<OrderHeader>> Get() async {
    var response = await HTTPGET(
      RoutingOrder.GET_Get,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader.fromJson(response.data);

    return ResponseModel<OrderHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<OrderHeader>> GetWithDetail(int orderId) async {
    // validation
    if (orderId == 0)
      return ResponseModel<OrderHeader>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPGET(
      RoutingOrder.GET_GetWithDetail,
      [
        QueryModel(
          name: "orderId",
          value: orderId.toString(),
        )
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader.fromJson(response.data);

    return ResponseModel<OrderHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<OrderHeader>>> GetAllCommissionOrders() async {
    var response = await HTTPGET(
      RoutingOrder.GET_GetAllMyCommissionOrders,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader().listFromJson(response.data);

    return ResponseModel<List<OrderHeader>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<OrderHeader>> Create(CreateOrder order) async {
    // validation
    if (order == null)
      return ResponseModel<OrderHeader>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var json = jsonEncode(order.toJson());

    var response = await HTTPPOST<CreateOrder>(
      RoutingOrder.GET_GetWithDetail,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader.fromJson(response.data);

    return ResponseModel<OrderHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<OrderHeader>> AddProduct(
      CreateProductModel product) async {
    // validation
    if (product == null)
      return ResponseModel<OrderHeader>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var json = jsonEncode(product.toJson());

    var response = await HTTPPOST<CreateOrder>(
      RoutingOrder.POST_AddProduct,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader.fromJson(response.data);

    return ResponseModel<OrderHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<OrderHeader>> UpdateProduct(
      UpdateProductModel product) async {
    // validation
    if (product == null)
      return ResponseModel<OrderHeader>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var json = jsonEncode(product.toJson());

    var response = await HTTPPOST<CreateOrder>(
      RoutingOrder.POST_AddProduct,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader.fromJson(response.data);

    return ResponseModel<OrderHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> DeleteOrder(int id) async {
    // validation
    if (id == 0)
      return ResponseModel<OrderHeader>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPDELETE(
      RoutingOrder.DELETE_DeleteOrder,
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

  Future<ResponseModel<OrderHeader>> DeleteProduct(int id, int orderId) async {
    // validation
    if (id == 0 && orderId == 0)
      return ResponseModel<OrderHeader>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPDELETE(
      RoutingOrder.DELETE_DeleteProduct,
      [
        QueryModel(
          name: "id",
          value: id.toString(),
        ),
        QueryModel(
          name: "orderId",
          value: orderId.toString(),
        ),
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader.fromJson(response.data);

    return ResponseModel<OrderHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<OrderHeader>>> GetAllMyOrder() async {
    var response = await HTTPGET(
      RoutingOrder.GET_GetAllMyOrder,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader().listFromJson(response.data);

    return ResponseModel<List<OrderHeader>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<OrderHeader>> GetPendingToPayOrder() async {
    var response = await HTTPGET(
      RoutingOrder.GET_GetPendingToPayOrder,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader.fromJson(response.data);

    return ResponseModel<OrderHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<OrderHeader>> GetPendingToPayOrderById(
      int orderId) async {
    // validation
    if (orderId == 0)
      return ResponseModel<OrderHeader>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPGET(
      RoutingOrder.GET_GetPendingToPayOrderById,
      [
        QueryModel(
          name: "orderId",
          value: orderId.toString(),
        )
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader.fromJson(response.data);

    return ResponseModel<OrderHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<OrderHeader>>> GetFailedToPayOrders() async {
    var response = await HTTPGET(
      RoutingOrder.GET_GetFailedToPayOrders,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader().listFromJson(response.data);

    return ResponseModel<List<OrderHeader>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<OrderHeader>>> GetAllPendingOrders() async {
    var response = await HTTPGET(
      RoutingOrder.GET_GetAllPendingOrders,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader().listFromJson(response.data);

    return ResponseModel<List<OrderHeader>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<OrderHeader>>> GetSendingOrder() async {
    var response = await HTTPGET(
      RoutingOrder.GET_GetSendingOrder,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader().listFromJson(response.data);

    return ResponseModel<List<OrderHeader>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<OrderHeader>>> GetReturnedOrder() async {
    var response = await HTTPGET(
      RoutingOrder.GET_GetReturnedOrder,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader().listFromJson(response.data);

    return ResponseModel<List<OrderHeader>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<OrderHeader>>> GetCanceledOrder() async {
    var response = await HTTPGET(
      RoutingOrder.GET_GetCanceledOrder,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader().listFromJson(response.data);

    return ResponseModel<List<OrderHeader>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<OrderHeader>>> GetConfirmedPayOrders() async {
    var response = await HTTPGET(
      RoutingOrder.GET_GetConfirmedPayOrders,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = OrderHeader().listFromJson(response.data);

    return ResponseModel<List<OrderHeader>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<String>> ClearWaitingOrders() async {
    var response = await HTTPGET(
      RoutingOrder.GET_ClearWaitingOrders,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = response.data.toString();

    return ResponseModel<String>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<String>> PayOrder(int orderId) async {
    // validation
    if (orderId == 0)
      return ResponseModel<String>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPPOST<CreateOrder>(
      RoutingOrder.POST_PayOrder,
      [
        QueryModel(
          name: "orderId",
          value: orderId.toString(),
        )
      ],
      "",
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = response.data.toString();

    return ResponseModel<String>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<OrdersFilterModel>> GetFeedOrdersFilter() async {
    var response = await HTTPGET(RoutingOrder.GET_FeedOrdersFilter, [],
        HeaderEnum.BearerHeaderEnum, ResponseEnum.ResponseModelEnum);
    if (response.isSuccess)
      response.data = OrdersFilterModel.fromJson(response.data);

    return ResponseModel<OrdersFilterModel>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<FilterResponseModel>> PostOrdersFilter(
      Map<String, dynamic> data) async {
    var json = jsonEncode(data);
    var response = await HTTPPOST(RoutingOrder.POST_OrdersFilter, [], json,
        HeaderEnum.BearerHeaderEnum, ResponseEnum.ResponseModelEnum);
    response.data = FilterResponseModel().listFromJson(response.data);

    return ResponseModel<FilterResponseModel>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<OrderHeader>> Verify() async {
    if (getAuthority() != null && getAuthority() != "") {
      var response = await HTTPGET(
        RoutingOrder.GET_Verify,
        [
          QueryModel(
            name: "authority",
            value: getAuthority(),
          ),
        ],
        HeaderEnum.BearerHeaderEnum,
        ResponseEnum.ResponseModelEnum,
      );

      return ResponseModel<OrderHeader>(
        isSuccess: response.isSuccess,
        statusCode: response.statusCode,
        data: response.data,
        message: response.message,
      );
    } else {
      return ResponseModel<OrderHeader>(
        isSuccess: false,
        statusCode: "",
        // data: response.data,
        message: "مشکلی در سیستم پیش آمده لطفا بعدا امتحان کنید.",
      );
    }
  }

  String getAuthority() {
    return PaymentAuthority;
  }

  void setAuthority(String auth) {
    PaymentAuthority = auth;
  }

  Future<ResponseModel<String>>? ZarrinPayOrder(int orderId,
      {int? addressId}) async {
    var response = await HTTPPOST(
      RoutingOrder.Post_ZarrinPayOrder,
      addressId != null
          ? [
              QueryModel(name: 'orderId', value: orderId.toString()),
              QueryModel(name: 'addressId', value: addressId.toString())
            ]
          : [QueryModel(name: 'orderId', value: orderId.toString())],
      '',
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    // if (response.isSuccess) {
    //   var list = response.data.toString().split("/").toList();

    //   if (list != null && list.length > 0)
    //     OrderServiceV2().setAuthority(list.last);
    // }

    return ResponseModel<String>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }
}
