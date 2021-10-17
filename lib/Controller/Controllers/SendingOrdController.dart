import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/Order/OrderDetail.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:get/get.dart';

class SendingOrdController extends GetxController {
  ResponseModel<List<OrderHeader>> orderResponse =
      ResponseModel<List<OrderHeader>>();
  List<OrderHeader>? sendingOrders;

  Future getSendingOrders() async {
    orderResponse = await OrderServiceV2().GetSendingOrder();
    if (!orderResponse.isSuccess) {
      orderResponse.showMessage();
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSendingOrders().then((value) {
      sendingOrders = [];
      if (orderResponse.data != null) sendingOrders = orderResponse.data;
      update();
    });
  }

  double getTotalPrice(List<OrderDetail>? orders) {
    double total = 0;
    orders!.forEach((element) {
      total += element.finalPrice!;
    });
    return total;
  }
}
