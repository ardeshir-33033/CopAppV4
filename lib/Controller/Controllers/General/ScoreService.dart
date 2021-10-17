import 'package:copapp/Controller/Service/CartService.dart';
import 'package:get/get.dart';

class ScoreService extends GetxController {
  static bool showScore = false;

  bool getShowScore() {
      return showScore;
  }

  void setShowScore(bool res) {
    showScore = res;
    update();
  }

  double getCartTotalPrice() {
    var totalScore = 0.0;
    CartServiceV2().getMyCart()?.details?.forEach((element) {
      totalScore += element.product!.score! * element.product!.detailQTY!;
    });
    return totalScore;
  }

  void clear() {
    showScore = false;
  }
}
