import 'package:copapp/Controller/Service/EpcService.dart';
import 'package:copapp/Model/Epc/EpcModelSerie.dart';
import 'package:get/get.dart';

class EpcHomeController extends GetxController {
  bool isLoading = false;
  List<EpcModelSerie> modelSeries = [];
  @override
  void onInit() {
    super.onInit();
    isLoading = true;
    update();

    EpcService().getIranCars().then((value) {
      if (value.isSuccess) {
        modelSeries = value.data;
      } else {
        value.showMessage();
      }
      isLoading = false;
      update();
    });
  }
}
