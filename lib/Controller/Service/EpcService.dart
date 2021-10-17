import 'package:copapp/Api/Api.dart';
import 'package:copapp/Api/Enums.dart';
import 'package:copapp/Api/QueryModel.dart';
import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Api/Routing/RoutingEpc.dart';
import 'package:copapp/Model/Epc/EpcGroup.dart';
import 'package:copapp/Model/Epc/EpcModelSerie.dart';
import 'package:copapp/Model/Epc/EpcPartGroup.dart';
import 'package:copapp/Model/Epc/EpcSubGroup.dart';

class EpcService extends Api {
  static EpcModelSerie? selectedModelSerie;
  static EpcGroup? selectedGroup;

  static EpcSubGroup? selectedSubGroup;
  Future<ResponseModel> getModelSeries() async {
    var result = await HTTPGET(
        RoutingEpc.Get_GetModelSeries,
        [QueryModel(name: 'modelId', value: '325')],
        HeaderEnum.BasicHeaderEnum,
        ResponseEnum.ResponseModelEnum);

    if (result.isSuccess) {
      result.data = EpcModelSerie().toList(result.data);
    }
    return ResponseModel(
      isSuccess: result.isSuccess,
      statusCode: result.statusCode,
      data: result.data,
      message: result.message,
    );
  }


  Future<ResponseModel> getIranCars() async {
    var result = await HTTPGET(
        RoutingEpc.Get_GetIranCars,
        [],
        HeaderEnum.BasicHeaderEnum,
        ResponseEnum.ResponseModelEnum);

    if (result.isSuccess) {
      result.data = EpcModelSerie().toList(result.data);
    }
    return ResponseModel(
      isSuccess: result.isSuccess,
      statusCode: result.statusCode,
      data: result.data,
      message: result.message,
    );
  }

  Future<ResponseModel<List<EpcGroup>>> getGroups(int modelSeriesId) async {
    var result = await HTTPGET(
        RoutingEpc.Get_GetGroups,
        [QueryModel(name: 'modelSeriesId', value: '$modelSeriesId')],
        HeaderEnum.BasicHeaderEnum,
        ResponseEnum.ResponseModelEnum);
    if (result.isSuccess) {
      result.data = EpcGroup().toList(result.data);
    }
    return ResponseModel<List<EpcGroup>>(
      isSuccess: result.isSuccess,
      statusCode: result.statusCode,
      data: result.data,
      message: result.message,
    );
  }

  Future<ResponseModel<List<EpcSubGroup>>> getSubGroups(int groupId) async {
    var result = await HTTPGET(
        RoutingEpc.Get_GetSubGroups,
        [QueryModel(name: 'groupId', value: '$groupId')],
        HeaderEnum.BasicHeaderEnum,
        ResponseEnum.ResponseModelEnum);

    if (result.isSuccess) {
      result.data = EpcSubGroup().toList(result.data);
    }
    return ResponseModel<List<EpcSubGroup>>(
      isSuccess: result.isSuccess,
      statusCode: result.statusCode,
      data: result.data,
      message: result.message,
    );
  }

  Future<ResponseModel<List<EpcPartGroup>>> getPartGroups(int subGroup) async {
    var result = await HTTPGET(
        RoutingEpc.Get_GetPartGroups,
        [QueryModel(name: 'subGroup', value: '$subGroup')],
        HeaderEnum.BasicHeaderEnum,
        ResponseEnum.ResponseModelEnum);

    if (result.isSuccess) {
      result.data = EpcPartGroup().toList(result.data);
    }

    return ResponseModel<List<EpcPartGroup>>(
      isSuccess: result.isSuccess,
      statusCode: result.statusCode,
      data: result.data,
      message: result.message,
    );
  }
}
