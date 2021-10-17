import 'package:copapp/View/Pages/FinancialPages/ChoiceWidget.dart';
import 'package:get/get.dart';

class ChoiceWidgController extends GetxController {
  int? value;
  double offsety = 0;


  void select(int index, List<ChoiceWidgetItem> items,) {
              value = index;
            offsety = value!.toDouble() * (300 / items.length);
          update();
  }
}
