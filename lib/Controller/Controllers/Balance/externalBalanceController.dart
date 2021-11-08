import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Controllers/Balance/BalanceController.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';

class ExternalBalanceController extends BalanceController {
  bool isLoadingExternal = true;
  int? categoryId = 233, vehicleId = 7;

  @override
  init(List<Part>? part) {
    if (part != null) {
      super.items = part;
      update(["Load"]);
    } else {
      getParts().then((value) {
        if (value.isSuccess) {
          super.items = value.data;
        } else {
          super.items = [];
          value.showMessage();
        }
        isLoadingExternal = false;
        update(["Load"]);
      });
    }
  }

  Future<ResponseModel> getParts() async {
    ResponseModel result =
        await BalanceServiceV2().getBalanceData(categoryId, vehicleId);
    return result;
  }
}
