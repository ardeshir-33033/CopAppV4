import 'package:copapp/Controller/Service/EpcService.dart';
import 'package:copapp/Model/Epc/EpcGroup.dart';
import 'package:get/get.dart';

class EpcGroupController extends GetxController {
  bool isLoading = false;
  List<EpcGroup> groups = [];
  @override
  void onInit() {
    super.onInit();
    isLoading = true;
    update();
    EpcService().getGroups(EpcService.selectedModelSerie!.id!).then((value) {
      if (value.isSuccess) {
        groups = value.data;
      } else {
        value.showMessage();
      }
      isLoading = false;
      update();
    });
  }
}
