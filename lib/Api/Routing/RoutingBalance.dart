import 'RoutingBase.dart';

class RoutingBalance extends RoutingBase {
  static const BaseName = "Balance";

  static const GET_Home = "${RoutingBase.ApiUrl}/$BaseName/Home";
  static const POST_BalanceDataSearch = "${RoutingBase.ApiUrlV2}/$BaseName/GetBalanceDataSearch";
  static const GET_QuickSearch = "${RoutingBase.ApiUrl}/$BaseName/QuickSearch";
  static const GET_ShowCategory =
      "${RoutingBase.ApiUrl}/$BaseName/ShowCategory";
  static const GET_ShowAllParents =
      "${RoutingBase.ApiUrl}/$BaseName/ShowAllParents";
  static const POST_SearchByPartNumbers =
      "${RoutingBase.ApiUrl}/$BaseName/SearchByPartNumbers"; //"https://192.168.10.91:5000/api/v1/$BaseName/SearchByPartNumbersN";
        static const POST_SearchByEPCPartNumbers =
      "${RoutingBase.ApiUrlV2}/$BaseName/SearchByEPCPartNumbers"; 
  static const Post_GetBalanceData =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetBalanceData";
        static const GET_GetBalanceFilterBox =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetBalanceFilterBox";
}
