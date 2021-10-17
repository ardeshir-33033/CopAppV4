import 'dart:convert';
import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingCart.dart';
import 'package:copapp/Controller/Controllers/Cart/CartLengthController.dart';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Model/Cart.dart';
import 'package:copapp/Model/CartHeader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'OrderService.dart';

class CartServiceV2 extends GetxController with Api {
  static CartHeader? myCart;
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CartLengthController cartLengthController = Get.find();

  Future<ResponseModel<CartHeader>> GetCart() async {
    var response = await HTTPGET<CartHeader>(
      RoutingCart.GET_Get,
      [QueryModel(value: 'chairId', name: UserServiceV2.chairId!.toString())],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = CartHeader.fromJson(response.data);
      myCart = response.data;
      cartLengthController
          .setCartLength(myCart?.cart?.cartDetails?.length ?? 0);
    }

    return ResponseModel<CartHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> SendCart(
      {String? mobile,
      String? fullName,
      String? lastName,
      String? car,
      String? carIdentity}) async {
    List<QueryModel> data = [
      QueryModel(name: "mobile", value: mobile),
      QueryModel(name: "fullName", value: fullName),
      QueryModel(name: "firstName", value: "o"),
      QueryModel(name: "lastName", value: "o"),
      QueryModel(name: "car", value: car),
      QueryModel(name: "carIdentity", value: carIdentity),
      QueryModel(value: 'chairId', name: UserServiceV2.chairId!.toString())
    ];
    var response = await HTTPPOST(
      RoutingCart.POST_SendCart,
      data,
      "",
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

  Future<ResponseModel<CartHeader>> GetCustomerOrderDetails() async {
    var response = await HTTPGET<CartHeader>(
      RoutingCart.GET_GetCustomerOrderDetails,
      [QueryModel(value: 'chairId', name: UserServiceV2.chairId!.toString())],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = CartHeader.fromJson(response.data);

    return ResponseModel<CartHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<CartHeader>> AddProduct(int? productId, int qty) async {
    // validation
    if (productId == 0)
      return ResponseModel<CartHeader>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var map = {"productId": productId, "qty": qty};

    var json = jsonEncode(map);

    var response = await HTTPPOST(
      RoutingCart.POST_AddProduct,
      [],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.data != null) {
      // response.data = ;
      // myCart = CartHeader.fromJson(response.data["cartDetails"]);
      myCart?.cart = Cart.fromJson(response.data);
    }
    cartLengthController.setCartLength(myCart?.cart?.cartDetails?.length ?? 0);

    // notifyListeners();

    return ResponseModel<CartHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<CartHeader>> UpdateProduct(
      int? productId, int qty) async {
    // validation
    if (productId == 0)
      return ResponseModel<CartHeader>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var map = {"productId": productId, "qty": qty};

    var json = jsonEncode(map);

    var response = await HTTPPUT(
      RoutingCart.PUT_UpdateProduct,
      [QueryModel(value: 'chairId', name: UserServiceV2.chairId!.toString())],
      json,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = Cart.fromJson(response.data);

    myCart!.cart = response.data;
    cartLengthController.setCartLength(myCart?.cart?.cartDetails?.length ?? 0);

    return ResponseModel<CartHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<CartHeader>> DeleteCartById(int id) async {
    // validation
    if (id == 0)
      return ResponseModel<CartHeader>(
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

    response.data = CartHeader.fromJson(response.data);

    myCart = response.data;
    cartLengthController.setCartLength(myCart?.cart?.cartDetails?.length ?? 0);

    return ResponseModel<CartHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<CartHeader>> DeleteCart() async {
    var response = await HTTPDELETE(
      RoutingCart.DELETE_DeleteCart,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = CartHeader.fromJson(response.data);

    myCart = response.data;
    cartLengthController.setCartLength(myCart?.cart?.cartDetails?.length ?? 0);

    return ResponseModel<CartHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<CartHeader>> DeleteProduct(int? id) async {
    // validation
    if (id == 0)
      return ResponseModel<CartHeader>(
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

    // response.data = CartHeader.fromJson(response.data);

    myCart!.cart = Cart.fromJson(response.data);
    cartLengthController.setCartLength(myCart?.cart?.cartDetails?.length ?? 0);

    return ResponseModel<CartHeader>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<String>> GenerateOrderWithAddress(int addressId) async {
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

    response.data = response.data.toString();

    return ResponseModel<String>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<String>> UpdateAddress(int addressId) async {
    // validation
    if (addressId == 0)
      return ResponseModel<String>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var map = {"id": addressId};

    var json = jsonEncode(map);

    var response = await HTTPPOST(
      RoutingCart.POST_UpdateAddress,
      [],
      json,
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

  Future<ResponseModel<String>>? Payment(int addressId) async {
    //1078
    if (addressId != null) {
      var response = await HTTPGET(
        RoutingCart.GET_PaymentZarinPal,
        // RoutingCart.GET_Payment,
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

        if (list != null && list.length > 0)
          OrderServiceV2().setAuthority(list.last);
      }

      return ResponseModel<String>(
        isSuccess: response.isSuccess,
        statusCode: response.statusCode,
        data: response.data,
        message: response.message,
      );
    } else {
      return ResponseModel(
          isSuccess: false,
          statusCode: "",
          message: "سیستم با خطایی مواجه شده است.");
    }
  }

  CartHeader? getMyCart() {
    return myCart;
  }

  double getCartTotalPrice() {
    var total = 0.0;
    if (myCart?.cart?.cartDetails != null) {
      myCart!.cart!.cartDetails!.forEach((element) {
        total += element.finalPrice!;
      });
    } else {
      myCart?.cart?.cartDetails = [];
    }
    return total;
  }

  int getCartTotalItems() {
    return myCart?.cart?.cartDetails?.length ?? 0;
  }

  bool cartHasProduct() {
    final index = myCart?.cart?.cartDetails?.length;

    var result = myCart?.cart?.cartDetails != null && index! > 0 ? true : false;

    return result;
  }

  bool cartProductExist(int productId) {
    final index = myCart?.cart?.cartDetails
        ?.indexWhere((element) => element.productId == productId);

    if (myCart?.cart?.cartDetails != null && index! >= 0) return true;

    return false;
  }

  int cartProductQTY(int? productId) {
    if (myCart?.cart?.cartDetails != null) {
      var product = myCart!.cart!.cartDetails!
          .indexWhere((element) => element.productId == productId);

      if (product >= 0) return myCart!.cart!.cartDetails![product].qty!.toInt();
    }

    return 0;
  }
}
