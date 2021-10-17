import 'dart:convert';
import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingBalance.dart';
import 'package:copapp/AppModel/Home/Car.dart';
import 'package:copapp/AppModel/Home/Category.dart';
import 'package:copapp/AppModel/Home/HomeModel.dart';
import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Model/Balance/QuickSearchModel.dart';
import 'package:copapp/Model/Balance/ShowCategoryModel.dart';
import 'package:copapp/Model/Part.dart';
import 'package:copapp/Model/Shopping/Product/FilterV2.dart';

import 'BalanceExtension.dart';
import 'UserServiceV2.dart';

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

  Future<ResponseModel<List<Car>>> GetCars() async {
    if (BalanceExtensions().getSelectedCar() == null)
      BalanceExtensions()
          .setSelectedCar(Car(id: 0, engName: "همه", name: "All"));

    if (myHomeData?.cars != null && myHomeData!.cars!.length > 0) {
      return ResponseModel<List<Car>>(
        data: myHomeData!.cars,
        isSuccess: true,
        statusCode: "200",
        message: "",
      );
    }

    var response = await HTTPGET<HomeModel>(
      RoutingBalance.GET_Home,
      [],
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = HomeModel.fromJson(response.data);

    myHomeData = response.data;

    // myHomeData.keywords.add(Keyword(id: 0, keyWord: "همه", name: "All"));

    return ResponseModel<List<Car>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: myHomeData!.cars,
      message: response.message,
    );
  }

  Future<ResponseModel<List<Category>>> GetCategories() async {
    var response = await HTTPGET<HomeModel>(
      RoutingBalance.GET_Home,
      [
        QueryModel(
          name: "charSort",
          value: sortBool.toString(),
        )
      ],
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = HomeModel.fromJson(response.data);

    myHomeData = response.data;

    var cats = (response.data as HomeModel).categories;

    return ResponseModel<List<Category>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: cats,
      message: response.message,
    );
  }

  Future<ResponseModel<HomeModel>> GetShowAllParents() async {
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

      response.data = HomeModel.fromJson(response.data);

      categories = response.data.categories;
      myHomeData = response.data;

      return ResponseModel<HomeModel>(
        isSuccess: response.isSuccess,
        statusCode: response.statusCode,
        data: response.data,
        message: response.message,
      );
    }
  }

  Future<ResponseModel<RShowCategoryModel>> GetShowCategory(
      int? id, int? keywordId, int? pageSize, int? page, int? filterId) async {
    // validation
    if (id == 0 && pageSize == 0 && page == 0 && filterId == 0)
      return ResponseModel<RShowCategoryModel>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPGET<RShowCategoryModel>(
      RoutingBalance.GET_ShowCategory,
      [
        QueryModel(
          name: "id",
          value: id.toString(),
        ),
        QueryModel(
          name: "keywordId",
          value: keywordId == 0 ? null : keywordId.toString(),
        ),
        QueryModel(
          name: "pageSize",
          value: pageSize.toString(),
        ),
        QueryModel(
          name: "page",
          value: page.toString(),
        ),
        QueryModel(
          name: "filterId",
          value: filterId.toString(),
        ),
      ],
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (!response.isSuccess)
      return ResponseModel<RShowCategoryModel>(
        isSuccess: false,
        statusCode: "500",
        message: "موردی یافت نشد",
      );

    var scm = RShowCategoryModel.fromJson(response.data);
    response.data = scm;

    currentParts = scm.parts!.cast<Part>();

    return ResponseModel<RShowCategoryModel>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<QuickSearchModel>> GetQuickSearch(String search) async {
    // validation
    if (search.isEmpty)
      return ResponseModel<QuickSearchModel>(
        isSuccess: false,
        statusCode: "500",
        data: null,
        message: "پارامتر های ورودی خالی هستند",
      );

    var response = await HTTPGET<QuickSearchModel>(
      RoutingBalance.GET_QuickSearch,
      [
        QueryModel(
          name: "search",
          value: search,
        ),
      ],
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    // response.data = QuickSearchModel.fromJson(response.data);

    return ResponseModel<QuickSearchModel>(
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
      response.data = Part().listFromJson(response.data['parts']);
    }
    return ResponseModel(
        data: response.data,
        isSuccess: response.isSuccess,
        message: response.message,
        statusCode: response.statusCode);
  }

  Future<ResponseModel<Part>> GetSearch(
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

    var response = await HTTPGET<FilterV2>(
      RoutingBalance.GET_Search,
      [
        QueryModel(
          name: "search",
          value: search,
        ),
        QueryModel(
          name: "keywordId",
          value: keywordId == 0 ? null : keywordId.toString(),
        ),
        QueryModel(
          name: "page",
          value: 1.toString(),
        ),
        QueryModel(
          name: "pageSize",
          value: 20.toString(),
        ),
      ],
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.data != null && response.data["parts"] != null)
      response.data = Part().listFromJson(response.data["parts"]);

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
