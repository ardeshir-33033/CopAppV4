
import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/Routing/RoutingProductInfo.dart';

class ProductInfoService extends Api {
  double totalScore = 0;

  Future<double> getTotalScore() async {
    var response = await HTTPGET(
      RoutingProductInfo.GET_TotalScore,
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      totalScore = response.data;
    }
    return totalScore;
  }

}
