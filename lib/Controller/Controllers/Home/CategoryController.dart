import 'package:copapp/Controller/Controllers/HomePageController.dart';
import 'package:copapp/Controller/Service/BalanceService.dart';
import 'package:copapp/Model/Balance/HomeModel.dart';
import 'package:copapp/Model/Category.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  List<Category>? categories;
  bool isLoading = true;
  HomeController homeController = Get.find();

  @override
  void onInit() {
    BalanceServiceV2()
        .GetShowAllParents()
        .then((value) {
      if (value.isSuccess) {
        isLoading = false;
        categories = (value.data as HomeModel).categories;

        update();
      } else {
        value.ShowMessage();
      }
    });
    super.onInit();
  }
}
