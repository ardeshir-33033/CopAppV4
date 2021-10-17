import 'package:copapp/Controller/Service/EpcService.dart';
import 'package:copapp/Model/Epc/EpcSubGroup.dart';
import 'package:get/get.dart';

class EpcSubGroupController extends GetxController {
  bool isLoading = false;
  List<EpcSubGroup> subGroups = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading = true;
    update();
    EpcService().getSubGroups(EpcService.selectedGroup!.id!).then((value) {
      if (value.isSuccess) {
        subGroups = value.data;
      } else {
        value.showMessage();
      }
      isLoading = false;
      update();
    });
  }
}
