import 'package:copapp/Controller/Service/OrderService.dart';
import 'package:copapp/Model/Order/OrderHeader.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:get/get.dart';

class OrderInfoController extends GetxController {
  bool isLoading = false;
  OrderHeader? order;

  getOrder(orderId) async {
    try {
      isLoading = false;
      update(['loading']);
      await OrderServiceV2().GetOrderInfo(orderId).then((value) {
        if (value.isSuccess)
          order = value.data;
        else
          value.showMessage();
      });
    } catch (e) {
      Snacki().GETSnackBar(false, 'مشکلی در ارتباط با سرور بوجود آمده است');
    } finally {
      isLoading = false;
      update(['loading']);
    }
  }
}
