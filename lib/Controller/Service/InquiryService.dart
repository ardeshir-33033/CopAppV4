import 'dart:convert';

import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingInquiry.dart';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Model/Inquiry/InquiryCart.dart';

class InquiryService with Api {
  static InquiryCart? inquiryCart;

  InquiryCart? getInquiryCart() {
    return inquiryCart;
  }

  Future<ResponseModel<InquiryCart>> getInquiry() async {
    ResponseModel response = await HTTPGET(
      RoutingInquiry.GetInquiry,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = InquiryCart.fromJson(response.data);
      inquiryCart = response.data;
    }

    return ResponseModel<InquiryCart>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<InquiryCart>> addInquiryProduct(
      {required int productId, required int qty, required int supplier}) async {
    Map<String, dynamic> map = {
      "productId": productId,
      "qty": qty,
      "supplierId": supplier
    };

    var response = await HTTPPOST(
      RoutingInquiry.Post_AddProduct,
      [],
      jsonEncode([map]),
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = InquiryCart.fromJson(response.data);
      inquiryCart = response.data;
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<InquiryCart>> updateProduct(
      int productId, int qty, int supplierId) async {
    Map<String, dynamic> map = {
      "productId": productId,
      "qty": qty,
      "supplierId": supplierId
    };

    var response = await HTTPPOST(
      RoutingInquiry.Post_UpdateProduct,
      [],
      jsonEncode([map]),
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = InquiryCart.fromJson(response.data);
      InquiryService().changeProductQTY(productId, qty);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<InquiryCart>> deleteProduct(
      int productId, int vendorId) async {
    var response = await HTTPDELETE(
      RoutingInquiry.DeleteProduct,
      [
        QueryModel(name: "productId", value: "$productId"),
        QueryModel(name: "vendorId", value: "$vendorId")
      ],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = InquiryCart.fromJson(response.data);
      changeProductQTY(productId, 0);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<InquiryCart>> deleteInquiry() async {
    var response = await HTTPDELETE(
      RoutingInquiry.DeleteProduct,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = InquiryCart.fromJson(response.data);
      inquiryCart = response.data;
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  int inquiryProductQTY(int? productId) {
    if (inquiryCart?.details != null) {
      var product = inquiryCart!.details
          .indexWhere((element) => element.product!.productsId == productId);

      if (product >= 0)
        return inquiryCart!.details[product].product!.detailQTY!.toInt();
    }

    return 0;
  }

  changeProductQTY(int productId, int qty) {
    if (inquiryCart?.details != null) {
      int index = inquiryCart!.details
          .indexWhere((element) => element.product!.productsId == productId);

      if (qty == 0) {
        inquiryCart!.details.removeAt(index);
      } else {
        inquiryCart!.details[index].product!.detailQTY = qty;
      }
    }
  }

  Future<ResponseModel> generateManualPreOrder() async {
    int profileId = UserServiceV2.profileId!;

    ResponseModel response = await HTTPGET(
      RoutingInquiry.GenerateManualPreOrder,
      [QueryModel(name: "sellerProfileId", value: "$profileId")],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }
}
