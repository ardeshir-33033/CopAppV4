import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingShippingBox.dart';
import 'package:copapp/Model/Shipping/AllShippers.dart';
import 'package:copapp/Model/Shipping/CountryNameModel.dart';

class ShippingService extends Api {
  static List<AllShippers>? shippers;

  Future<ResponseModel<List<AllShippers>>> GetAllShippers() async {
    var response = await HTTPGET<AllShippers>(
      RoutingShipping.GET_GetAllShippers,
      [],
      HeaderEnum.EmptyHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    response.data = AllShippers().listFromJson(response.data);

    shippers = response.data;

    return ResponseModel<List<AllShippers>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel<List<CountryName>>> GetAllCountries() async {
    var response = await HTTPGET<CountryName>(
        RoutingShipping.GET_GetAllCountries,
        [],
        HeaderEnum.EmptyHeaderEnum,
        ResponseEnum.ResponseModelEnum);

    response.data = CountryName().listFromJson(response.data);

    return ResponseModel<List<CountryName>>(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }
}
