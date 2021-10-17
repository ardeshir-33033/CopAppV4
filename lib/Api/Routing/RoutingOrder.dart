import 'RoutingBase.dart';

class RoutingOrder extends RoutingBase {
  static const BaseName = "Order";

  static const GET_Get = "${RoutingBase.ApiUrl}/$BaseName/Get";
  static const GET_GetAllMyOrder =
      "${RoutingBase.ApiUrl}/$BaseName/GetAllMyOrder";
  static const GET_GetWithDetail =
      "${RoutingBase.ApiUrl}/$BaseName/GetWithDetail";
  static const GET_GetSendingOrder =
      "${RoutingBase.ApiUrl}/$BaseName/GetSendingOrder";
  static const GET_GetReturnedOrder =
      "${RoutingBase.ApiUrl}/$BaseName/GetReturnedOrder";
  static const GET_GetCanceledOrder =
      "${RoutingBase.ApiUrl}/$BaseName/GetCanceledOrder";
  static const GET_ClearWaitingOrders =
      "${RoutingBase.ApiUrl}/$BaseName/ClearWaitingOrders";
  static const GET_GetAllPendingOrders =
      "${RoutingBase.ApiUrl}/$BaseName/GetAllPendingOrders";
  static const GET_GetFailedToPayOrders =
      "${RoutingBase.ApiUrl}/$BaseName/GetFailedToPayOrders";
  static const GET_GetPendingToPayOrder =
      "${RoutingBase.ApiUrl}/$BaseName/GetPendingToPayOrder";
  static const GET_GetPendingToPayOrderById =
      "${RoutingBase.ApiUrl}/$BaseName/GetPendingToPayOrderById";
  static const GET_GetConfirmedPayOrders =
      "${RoutingBase.ApiUrl}/$BaseName/GetConfirmedPayOrders";
  static const GET_GetAllMyCommissionOrders =
      "${RoutingBase.ApiUrl}/$BaseName/GetAllMyCommissionOrders";
  static const GET_Verify = "${RoutingBase.ApiUrl}/$BaseName/GetWithAuthoriy";

  static const GET_FeedOrdersFilter =
      "${RoutingBase.ApiUrl}/$BaseName/FeedOrdersFilter";
  static const POST_OrdersFilter =
      "${RoutingBase.ApiUrl}/$BaseName/OrdersFilter";

  static const POST_Create = "${RoutingBase.ApiUrl}/$BaseName/Create";
  static const POST_PayOrder = "${RoutingBase.ApiUrl}/$BaseName/PayOrder";
  static const POST_AddProduct = "${RoutingBase.ApiUrl}/$BaseName/AddProduct";

  static const DELETE_DeleteOrder =
      "${RoutingBase.ApiUrl}/$BaseName/DeleteOrder";
  static const DELETE_DeleteProduct =
      "${RoutingBase.ApiUrl}/$BaseName/DeleteProduct";

  static const PUT_UpdateProduct =
      "${RoutingBase.ApiUrl}/$BaseName/UpdateProduct";
  static const Post_ZarrinPayOrder =
      "${RoutingBase.ApiUrl}/$BaseName/ZarrinPayOrder";
}
