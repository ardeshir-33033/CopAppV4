import 'package:copapp/Controller/Service/CartService.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:get/get.dart';

class CartController extends GetxController {

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    if (CartServiceV2.myCart == null) {
      CartServiceV2().getCart().then((value) {
        isLoading = false;
        update();
        if(value.isSuccess == false){
          Snacki().GETSnackBar(value.isSuccess, value.message);
        }
      });
    }
  }
}
