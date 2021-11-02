import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:get/get.dart';

class OrderInfoController extends GetxController {
  bool isLoading = false;
  OrderHeader? order;
  
  getOrder(orderId) async {
    try {
      isLoading = false;
      update(['loading']);
      await OrderServiceV2().GetOrderInfo(orderId).then((value) {
        order = value.data;
      });
    } finally {
      isLoading = false;
      update(['loading']);
    }
  }
}
