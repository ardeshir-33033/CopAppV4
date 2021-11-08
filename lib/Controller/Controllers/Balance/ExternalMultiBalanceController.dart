import 'package:copapp/AppModel/Balance/FilterBox.dart';
import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Controllers/Balance/MultiBalanceController.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';

class ExternalMultiBalanceController extends MultiBalanceController {

  getBalanceExternal() async {
    getBalanceDataExternal(categoryId: 233, carId: 7).then((value) async {
      super.result = value;
      update(["sub&button", "multi"]);
    });
    getFiltersExternal(carId: 7, categoryId: 233).then((value) {
      update(["sub&button"]);
    });
  }

  Future getFiltersExternal(
      {required int categoryId, required int carId}) async {
    var response = await BalanceServiceV2().getBalanceFilterBox(
      categoryId,
      carId,
    );
    if (response.isSuccess) {
      super.subCategories = (response.data as FilterBox).subCategories;
      BalanceExtensions().setFilter((response.data as FilterBox).filters!);
    }
  }

  Future<List<Part>?> getBalanceDataExternal({categoryId, carId}) async {
    var selectedBalances = await BalanceServiceV2().getBalanceData(
      categoryId,
      // 233,
      carId,
      // BalanceServiceV2().getSelectedCar()?.id,
    );

    if (selectedBalances.isSuccess) {
      return (selectedBalances.data);
    } else {
      selectedBalances.showMessage();
      return [];
    }
  }
}
