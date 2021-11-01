import 'RoutingBase.dart';

class RoutingOrder extends RoutingBase {
  static const BaseName = "Order";

  static const GET_GetWithDetail =
      "${RoutingBase.ApiUrl}/$BaseName/GetWithDetail";
  static const Post_ZarrinPayOrder =
      "${RoutingBase.ApiUrl}/$BaseName/ZarrinPayOrder";
  static const GET_GetConfirmedOrders =
      "${RoutingBase.ApiUrlV2}/$BaseName/ConfirmedOrdersV2";
  static const GET_GetSendingOrders =
      "${RoutingBase.ApiUrlV2}/$BaseName/SendingOrdersV2";
  static const GET_GetPendingOrders =
      "${RoutingBase.ApiUrlV2}/$BaseName/PendingOrdersV2";
  static const GET_GetAllMyCommissionOrders =
      "${RoutingBase.ApiUrl}/$BaseName/GetAllMyCommissionOrders";
  static const GET_FeedOrdersFilter =
      "${RoutingBase.ApiUrl}/$BaseName/FeedOrdersFilter";
  static const POST_OrdersFilter =
      "${RoutingBase.ApiUrl}/$BaseName/OrdersFilter";
  static const GET_Verify = "${RoutingBase.ApiUrl}/$BaseName/GetWithAuthoriy";

}
