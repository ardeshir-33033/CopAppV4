import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:get/get.dart';

class PendingOrdController extends GetxController {
  ResponseModel orderResponse =
      ResponseModel<List<OrderHeader>>();
  List<OrderHeader>? pendingOrders;

  Future getPendingOrders() async {
    orderResponse = await OrderServiceV2().getPendingOrders();
    if (!orderResponse.isSuccess) {
      orderResponse.showMessage();
      Future.delayed(Duration(seconds: 2), () {
          Get.back();
        });
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPendingOrders().then((value) {
      pendingOrders = [];
      if (orderResponse.data != null)
        pendingOrders = orderResponse.data;

      update();
    });
  }

  double getOrderFinalPrice(int orderId) {
    return pendingOrders!
        .firstWhere((element) => element.id == orderId)
        .finalPrice!;
  }
}
