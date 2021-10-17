import 'package:copapp/Controller/Service/CartService.dart';
import 'package:get/get.dart';

class ScoreService extends GetxController {
  static bool showScore = false;

  bool getShowScore() {
    if (showScore != null) {
      return showScore;
    } else {
      return true;
    }
  }

  void setShowScore(bool res) {
    showScore = res;
    update();
  }

  double getCartTotalPrice() {
    var totalScore = 0.0;
    CartServiceV2().getMyCart()?.cart?.cartDetails?.forEach((element) {
      totalScore += element.product!.productInfos!.first.score! * element.qty!;
    });
    return totalScore;
  }

  void clear() {
    showScore = false;
  }
}
