import 'dart:convert';
import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingBalance.dart';
import 'package:copapp/AppModel/Balance/FilterBox.dart';
import 'package:copapp/AppModel/Balance/SearchPart.dart';
import 'package:copapp/AppModel/Home/Category.dart';
import 'package:copapp/AppModel/Home/HomeModel.dart';
import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'BalanceExtension.dart';
import 'UserServiceV2.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class BalanceServiceV2 extends BalanceExtensions with Api {
  static HomeModel? myHomeData;
  static List<Part>? currentParts;
  static List<Category> categories = [];

  // static List<Part>? selectedParts;
  bool? sortBool;

  // Future<ResponseModel<HomeModel>> GetHome() async {
  //   var response = await HTTPGET<HomeModel>(
  //     RoutingBalance.GET_Home,
  //     [],
  //     HeaderEnum.EmptyHeaderEnum,
  //     ResponseEnum.ResponseModelEnum,
  //   );
  //
  //   response.data = HomeModel.fromJson(response.data);
  //
  //   myHomeData = response.data;
  //
  //   return ResponseModel<HomeModel>(
  //       isSuccess: response.isSuccess,
  //       statusCode: response.statusCode,
  //       data: response.data,
  //       message: response.message,
  //     );
  // }
  Future<ResponseModel<HomeModel>> getHomeData() async {
    if (myHomeData != null) {
      return ResponseModel<HomeModel>(
        data: myHomeData!,
        isSuccess: true,
        statusCode: "200",
        message: "",
      );
    } else {
      var response = await HTTPGET<HomeModel>(
        RoutingBalance.GET_ShowAllParents,
        [
          // QueryModel(
          //   name: "keywordId",
          //   value: keywordId,
          // ),
          // QueryModel(
          //   name: "charSort",
          //   value: sortBool.toString(),
          // )
          QueryModel(value: 'chairId', name: UserServiceV2.chairId!.toString())
        ],
        HeaderEnum.EmptyHeaderEnum,
        ResponseEnum.ResponseModelEnum,
      );
      if (response.isSuccess) {
        response.data = HomeModel.fromJson(response.data);

        categories = response.data.categories;
        myHomeData = response.data;
      }

      return ResponseModel<HomeModel>(
        isSuccess: response.isSuccess,
        statusCode: response.statusCode,
        data: response.data,
        message: response.message,
      );
    }
  }

  Future<ResponseModel> getBalanceData(int? category, int? vehicle,
      {int? filterId}) async {
    Map<String, dynamic> json = {
      "category": category,
      // "page": "<integer>",
      // "pageSize": "<integer>",
      "vehicles": [vehicle],
      "filter": filterId,
      "chair": UserServiceV2.chairId,
      // "username": "09111351530"
    };
    var body = jsonEncode(json);
    ResponseModel response = await HTTPPOST(
      RoutingBalance.Post_GetBalanceData,
      [],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = Part().listFromJson(response.data);
      // BalanceData.fromJson(response.data);
    }
    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<FilterBox>> getBalanceFilterBox(int? id, int? keywordId,
      {int? pageSize, int? page, int? filterId}) async {
    if (id == 0 && pageSize == 0 && page == 0 && filterId == 0)
      return ResponseModel(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );
    Map<String, dynamic> json = {
      "categoryId": id,
      "keyWord": "$keywordId",
      "pageSize": pageSize,
      "page": page,
      "filterId": filterId,
      "chairId": UserServiceV2.chairId
    };
    String body = jsonEncode(json);
    ResponseModel response = await HTTPPOST(
      RoutingBalance.GET_GetBalanceFilterBox,
      [
        // QueryModel(
        //   name: "id",
        //   value: id.toString(),
        // ),
        // QueryModel(
        //   name: "keywordId",
        //   value: keywordId == 0 ? null : keywordId.toString(),
        // ),
        // QueryModel(
        //   name: "pageSize",
        //   value: pageSize.toString(),
        // ),
        // QueryModel(
        //   name: "page",
        //   value: page.toString(),
        // ),
        // QueryModel(
        //   name: "filterId",
        //   value: filterId.toString(),
        // ),
        // QueryModel(
        //   name: "chairId",
        //   value: UserServiceV2.chairId.toString(),
        // ),
      ],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = FilterBox.fromJson(response.data);
    }
    return ResponseModel<FilterBox>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<Part>>> searchByPartNumbers(List<String> num
      // ,int carId
      ) async {
    var json = jsonEncode(num);

    var response = await HTTPPOST(
        RoutingBalance.POST_SearchByPartNumbers,
        [
          // QueryModel(name: 'modelSeriesId',value: carId.toString())
        ],
        json,
        HeaderEnum.BasicHeaderEnum,
        ResponseEnum.ResponseModelEnum);
    if (response.isSuccess) {
      response.data = Part().listFromJsonOld(response.data['parts']);
    }
    return ResponseModel(
        data: response.data,
        isSuccess: response.isSuccess,
        message: response.message,
        statusCode: response.statusCode);
  }

  Future<ResponseModel<List<Part>>> searchByEPCPartNumbers(
      List<String> num, int carId) async {
    Map<String, dynamic> map = {"numbers": num, "modelSeriesId": carId};
    var json = jsonEncode(map);
    var response = await HTTPPOST(RoutingBalance.POST_SearchByEPCPartNumbers,
        [], json, HeaderEnum.BearerHeaderEnum, ResponseEnum.ResponseModelEnum);
    if (response.isSuccess) {
      response.data = Part().listFromJson(response.data['parts']);
    }
    return ResponseModel(
        data: response.data,
        isSuccess: response.isSuccess,
        message: response.message,
        statusCode: response.statusCode);
  }

  Future<ResponseModel> quickSearch(String search, int? keywordId) async {
    Map<String, String> map = {};
    ResponseModel response = await HTTPPOST(
      RoutingBalance.POST_GetBalanceQuickSearchV2,
      [
        QueryModel(name: "search", value: search),
        QueryModel(name: "keywordId", value: keywordId.toString())
      ],
      json.encode(map),
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = SearchPart().listFromJson(response.data);
    }
    return response;
  }

  Future<ResponseModel<Part>> getBalanceDataSearch(
      {int? page,
      int? pageSize,
      int? filterId,
      int? keywordId,
      int? categoryId,
      String? search}) async {
    // validation
    if (search!.isEmpty &&
        page == 0 &&
        pageSize == 0 &&
        filterId == 0 &&
        categoryId == 0)
      return ResponseModel<Part>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );
    List<int> keywords = [];
    if (keywordId != null) {
      keywords.add(keywordId);
    }
    Map<String, dynamic> json = {
      "search": search.toEnglishDigit(),
      "vehicles": keywords,
    };
    String body = jsonEncode(json);
    ResponseModel response = await HTTPPOST(
      RoutingBalance.POST_BalanceDataSearch,
      [],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) response.data = Part().listFromJson(response.data);

    return ResponseModel<Part>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  setSortBool(bool result) {
    sortBool = result;
  }

  bool getSortBool() {
    return sortBool ?? false;
  }

  List<Category> getCategories() {
    return categories;
  }

// setSelectedPart(Part p) {
//   if (selectedParts == null) selectedParts = [];
//
//   selectedParts!.add(p);
// }

// selectAllParts() {
//   if (currentParts != null && currentParts!.length > 0)
//     selectedParts = currentParts!.toList();
// }

// removeSelectedPart(int? id) {
//   selectedParts =
//       selectedParts!.where((element) => element.id != id).toList();
// }
//
// List<Part>? getSelectedParts() {
//   return selectedParts == null ? [] : selectedParts;
// }
//
// clearSelectedParts() {
//   selectedParts = [];
// }
//
// bool isSelectedParts(int? id) {
//   if (selectedParts == null) selectedParts = [];
//
//   var index = selectedParts!.indexWhere((element) => element.id == id);
//
//   return index >= 0 ? true : false;
// }

// updateSelectedParts(Part part) {
//   var iss = isSelectedParts(part.id);
//
//   if (iss)
//     removeSelectedPart(part.id);
//   else
//     setSelectedPart(part);
// }
}
