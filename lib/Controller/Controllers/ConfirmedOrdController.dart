import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:get/get.dart';

class ConfirmedOrdController extends GetxController {
  ResponseModel confirmedResponse =
      ResponseModel();
  List<OrderHeader>? confirmedOrders;

  Future getPendingOrders() async {
    confirmedResponse = await OrderServiceV2().getConfirmedOrders();
    if (!confirmedResponse.isSuccess) {
      confirmedResponse.showMessage();
      Future.delayed(Duration(seconds: 2), () {
          Get.back();
        });
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPendingOrders().then((value) {
      confirmedOrders = [];

      if (confirmedResponse.data != null)
        confirmedOrders = confirmedResponse.data;
      update();
    });
  }
}
