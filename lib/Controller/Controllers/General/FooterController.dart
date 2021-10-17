import 'dart:ui';
import 'package:get/get.dart';

class FooterController extends GetxController {
  Color homeColor = Color(0xff878787);
  Color basketColor = Color(0xff878787);
  Color deliveryColor = Color(0xff878787);

  int cartTotal = 0;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  cartPress() {
    basketColor = Color(0xffca1237);
    homeColor = Color(0xff878787);
    deliveryColor= Color(0xff878787);
    update(['1']);
  }

  homePress(){
    homeColor = Color(0xffca1237);
    deliveryColor= Color(0xff878787);
    basketColor = Color(0xff878787);
    update(['1']);
  }

  deliveryPress(){
    deliveryColor = Color(0xffca1237);
    basketColor = Color(0xff878787);
    homeColor = Color(0xff878787);
    update(['1']);
  }
}
