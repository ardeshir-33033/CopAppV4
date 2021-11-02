import 'dart:convert';
import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingOrder.dart';
import 'package:copapp/Model/FilterResponseModel.dart';
import 'package:copapp/Model/Order/OrderFilterModel.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';

class OrderServiceV2 extends Api {
  static String paymentAuthority = "";

  Future<ResponseModel<OrderHeader>> getWithDetail(int orderId) async {
    // validation
    if (orderId == 0)
      return ResponseModel<OrderHeader>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    ResponseModel response = await HTTPGET(
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
    if (response.isSuccess) {
      response.data = OrderHeader.fromJson(response.data);
    }

    return ResponseModel<OrderHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> getAllCommissionOrders() async {
    ResponseModel response = await HTTPGET(
      RoutingOrder.GET_GetAllMyCommissionOrders,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = OrderHeader().listFromJson(response.data);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> getPendingOrders() async {
    ResponseModel response = await HTTPGET(
      RoutingOrder.GET_GetPendingOrders,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = OrderHeader().listFromJson(response.data);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> getSendingOrders() async {
    ResponseModel response = await HTTPGET(
      RoutingOrder.GET_GetSendingOrders,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = OrderHeader().listFromJson(response.data);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<OrderHeader>>> getConfirmedOrders() async {
    ResponseModel response = await HTTPGET(
      RoutingOrder.GET_GetConfirmedOrders,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = OrderHeader().listFromJson(response.data);
    }
    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<OrderHeader>>> getOrderInfo(int orderId) async {
    ResponseModel response = await HTTPGET(
      RoutingOrder.GET_GetOrderInfo,
      [QueryModel(name: "orderId", value: orderId.toString())],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = OrderHeader.fromJson(response.data);
    }
    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> getFeedOrdersFilter() async {
    ResponseModel response = await HTTPGET(
      RoutingOrder.GET_FeedOrdersFilter,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = OrdersFilterModel.fromJson(response.data);
    }

    return ResponseModel<OrdersFilterModel>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<FilterResponseModel>> postOrdersFilter(
      Map<String, dynamic> data) async {
    var json = jsonEncode(data);

    var response = await HTTPPOST(
      RoutingOrder.POST_OrdersFilter,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = FilterResponseModel().listFromJson(response.data);
    }
    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> verify() async {
    if (getAuthority() != "") {
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
    return paymentAuthority;
  }

  void setAuthority(String auth) {
    paymentAuthority = auth;
  }

  Future<ResponseModel<String>>? zarrinPayOrder(int orderId,
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
