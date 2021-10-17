import 'package:copapp/Model/Order/OrderFilterModel.dart';
import 'package:get/get.dart';

class FinFilterController extends GetxController {
  List<String> items = [];
  List<String> allItems = [];

  List<bool> values = [];
  dynamic selected;

  doInits(int? _id, OrdersFilterModel? _filters) {
    if (_id == 1) {
      items = [];
      _filters!.customers!.forEach((v) {
        print(v);
        items.add(v);
      });
    } else if (_id == 2) {
      items = [];
      _filters!.products!.forEach((v) {
        items.add(v.productsName!);
      });
    }
    items.forEach((v) {
      values.add(false);
    });
    allItems = items;
    if (_id == 2) {
      items = [];
    }
  }

  void setSelected(int i) {
    if (values[i]) {
      values[i] = false;
      selected = null;
    } else {
      for (int j = 0; j < values.length; j++) {
        values[j] = false;
      }
      values[i] = true;
    }
    update();
  }

  void getResult(result) {
    items = result;
    update();
  }

  void onTap(int index, int? _id, OrdersFilterModel? _filters) {
    if (_id == 1) {
      selected = items[index];
    } else if (_id == 2) {
      for (int j = 0; j < _filters!.products!.length; j++) {
        if (_filters.products![j].productsName == items[index])
          selected = _filters.products![j].productsId;
      }
    }
    setSelected(index);
  }
}
