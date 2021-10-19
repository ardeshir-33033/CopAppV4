import 'package:get/get.dart';

class CustomSliderController extends GetxController {
  double min = 0, max = 50000000;
  double? start, end;
  @override
  void onInit() {
    super.onInit();
    start = min;
    end = max;
  }

  void onDrag(double s,double e) {
    start = s;
    end = e;
    update();
  }
}
