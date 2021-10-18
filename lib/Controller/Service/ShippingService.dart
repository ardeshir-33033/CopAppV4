import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingShippingBox.dart';
import 'package:copapp/Model/Shipping/AllShippers.dart';
import 'package:copapp/Model/Shipping/CountryNameModel.dart';

class ShippingService extends Api {
  static List<AllShippers>? shippers;

  Future<ResponseModel> getAllShippers() async {
    var response = await HTTPGET<AllShippers>(
      RoutingShipping.GET_GetAllShippers,
      [],
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = AllShippers().listFromJson(response.data);
      shippers = response.data;
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> getAllCountries() async {
    var response = await HTTPGET<CountryName>(
        RoutingShipping.GET_GetAllCountries,
        [],
        HeaderEnum.EmptyHeaderEnum,
        ResponseEnum.ResponseModelEnum,
    );

    if(response.isSuccess){
      response.data = CountryName().listFromJson(response.data);
    }

    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }
}
