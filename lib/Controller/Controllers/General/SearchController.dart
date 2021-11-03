import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  String hintText = "";
  String errorText = '';
  List<Part> searchedItems = [];

  Future searchItems({
    String search = '',
  }) async {
    if (search.isNotEmpty) {
      errorText = '';
      searchedItems = [];
      update(['error']);
      ResponseModel<Part> result = await BalanceServiceV2()
          .getBalanceDataSearch(
              search: search,
              keywordId: BalanceServiceV2().getSelectedCar()?.id);

      if (result.isSuccess == false) {
        errorText = result.message;
        update(['error']);
      } else {
        searchedItems = result.data;
        if (searchedItems.isEmpty) {
          errorText = 'موردی یافت نشد';
          update(['error']);
        }
        update(['item']);
      }
    } else {
      errorText = 'عبارت مورد نظر را در کادر بالا تایپ کنید';
      update(['error']);
    }
  }

  textfieldTapped() {
    hintText = "";
    update(['text']);
  }
}
