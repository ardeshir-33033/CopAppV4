import 'RoutingBase.dart';

class RoutingBalance extends RoutingBase {
  static const BaseName = "Balance";

  static const GET_Home = "${RoutingBase.ApiUrl}/$BaseName/Home";
  static const GET_Search = "${RoutingBase.ApiUrl}/$BaseName/Search";
  static const GET_QuickSearch = "${RoutingBase.ApiUrl}/$BaseName/QuickSearch";
  static const GET_ShowCategory =
      "${RoutingBase.ApiUrl}/$BaseName/ShowCategory";
  static const GET_ShowAllParents =
      "${RoutingBase.ApiUrl}/$BaseName/ShowAllParents";
  static const POST_SearchByPartNumbers =
      "${RoutingBase.ApiUrl}/$BaseName/SearchByPartNumbers"; //"https://192.168.10.91:5000/api/v1/$BaseName/SearchByPartNumbersN";

}
