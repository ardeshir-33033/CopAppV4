import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:get/get.dart';

class AppDrawerController extends GetxController {
  bool profileVis = false;
  bool sefareshVis = false;

  profileSelected() {
    profileVis = !profileVis;
    update([1]);
  }

  ordersSelected() {
    sefareshVis = !sefareshVis;
    update([2]);
  }

  exitPressed() async {
    UserServiceV2().saveUserDataLocal(null);
    UserServiceV2().saveJWTDataLocal(null);
    UserServiceV2().saveAutoLoginDataLocal(false);
    Get.back();
  }
}
