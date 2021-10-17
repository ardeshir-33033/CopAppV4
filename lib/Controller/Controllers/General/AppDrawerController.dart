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
    UserServiceV2().saveUserDataLocaly(null);
    UserServiceV2().saveJWTDataLocaly(null);
    UserServiceV2().saveAutoLoginDataLocaly(false);
    Get.back();
  }
}
