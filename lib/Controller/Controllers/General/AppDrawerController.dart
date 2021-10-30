import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:get/get.dart';

class AppDrawerController extends GetxController {
  bool profileVis = false;
  bool sefareshVis = false;

  profileSelected() {
    profileVis = !profileVis;
    update(["profile"]);
  }

  ordersSelected() {
    sefareshVis = !sefareshVis;
    update(["order"]);
  }

  exitPressed() async {
    UserServiceV2().saveUserDataLocal(null);
    UserServiceV2().saveJWTDataLocal(null);
    UserServiceV2().saveAutoLoginDataLocal(false);
    Get.back();
  }
}
