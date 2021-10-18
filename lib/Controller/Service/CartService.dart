import 'dart:convert';
import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingCart.dart';
import 'package:copapp/AppModel/Cart/CartHeader.dart';
import 'package:copapp/Controller/Controllers/Cart/CartLengthController.dart';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'OrderService.dart';

class CartServiceV2 extends GetxController with Api {
  static CartHeader? myCart;
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CartLengthController cartLengthController = Get.find();

  Future<ResponseModel> getCart() async {
    var response = await HTTPGET<CartHeader>(
      RoutingCart.Get_MyCart,
      [QueryModel(value: 'chairId', name: UserServiceV2.chairId!.toString())],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = CartHeader.fromJson(response.data);
      myCart = response.data;
      cartLengthController.setCartLength(myCart?.details?.length ?? 0);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> addProduct(int productId, int qty) async {
    // validation
    if (productId == 0)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    Map<String, int> map = {"product": productId, "qty": qty};

    String json = jsonEncode(map);

    var response = await HTTPPOST(
      RoutingCart.POST_Add2CartV2,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.data != null) {
      myCart = CartHeader.fromJson(response.data);
    }
    cartLengthController.setCartLength(myCart?.details?.length ?? 0);

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> updateProduct(int productId, int qty) async {
    // validation
    if (productId == 0)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    Map<String, int> map = {"product": productId, "qty": qty};

    String json = jsonEncode(map);

    var response = await HTTPPOST(
      RoutingCart.POST_Update2CartV2,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = CartHeader.fromJson(response.data);
      myCart = response.data;
      cartLengthController.setCartLength(myCart?.details?.length ?? 0);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> deleteCartById(int id) async {
    // validation
    if (id == 0)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPDELETE(
      RoutingCart.DELETE_DeleteCartById,
      [
        QueryModel(
          name: "id",
          value: id.toString(),
        )
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = CartHeader.fromJson(response.data);
      myCart = response.data;
      cartLengthController.setCartLength(myCart?.details?.length ?? 0);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> deleteCart() async {
    var response = await HTTPDELETE(
      RoutingCart.DELETE_DeleteCart,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = CartHeader.fromJson(response.data);

      myCart = response.data;
      cartLengthController.setCartLength(myCart?.details?.length ?? 0);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> deleteProduct(int id) async {
    // validation
    if (id == 0)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPDELETE(
      RoutingCart.DELETE_DeleteProduct,
      [
        QueryModel(
          name: "id",
          value: id.toString(),
        ),
        QueryModel(value: 'chairId', name: UserServiceV2.chairId!.toString())
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = CartHeader.fromJson(response.data);

      myCart = response.data;
      cartLengthController.setCartLength(myCart?.details?.length ?? 0);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<String>> generateOrderWithAddress(int addressId) async {
    // validation
    if (addressId == 0)
      return ResponseModel<String>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPGET(
      RoutingCart.GET_GenerateOrderWithAddress,
      [
        QueryModel(
          name: "addressId",
          value: addressId.toString(),
        )
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = response.data.toString();
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<String>>? payment(int addressId) async {
    //1078
    var response = await HTTPGET(
      RoutingCart.GET_PaymentZarinPal,
      [
        QueryModel(
          name: "addressId",
          value: addressId.toString(),
        ),
        QueryModel(name: "mobile", value: true.toString()),
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      var list = response.data.toString().split("/").toList();

      if (list.length > 0) OrderServiceV2().setAuthority(list.last);
    }

    return ResponseModel<String>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  CartHeader? getMyCart() {
    return myCart;
  }

  double getCartTotalPrice() {
    return myCart!.orderFinalPrice ?? 0;
  }

  int getCartTotalItems() {
    return myCart?.details!.length ?? 0;
  }

  bool cartHasProduct() {
    int index = myCart?.details?.length ?? 0;

    var result = myCart?.details != null && index > 0 ? true : false;

    return result;
  }

  int cartProductQTY(int? productId) {
    if (myCart?.details != null) {
      int product = myCart!.details!
          .indexWhere((element) => element.product?.productsId == productId);

      if (product >= 0) return myCart!.details![product].product!.detailQTY!;
    }

    return 0;
  }
}
