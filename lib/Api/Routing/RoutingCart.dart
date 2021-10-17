import 'RoutingBase.dart';

class RoutingCart {
  static const BaseName = "Cart";

  static const GET_Get = "${RoutingBase.ApiUrl}/$BaseName/GetSimple";
  static const GET_GetCustomerOrderDetails =
      "${RoutingBase.ApiUrl}/$BaseName/GetCustomerOrderDetails";
  static const GET_GenerateOrderWithAddress =
      "${RoutingBase.ApiUrl}/$BaseName/GenerateOrderWithAddress";

  static const POST_PayOrder = "${RoutingBase.ApiUrl}/$BaseName/PayOrder";
  static const POST_AddProduct = "${RoutingBase.ApiUrl}/$BaseName/AddProductSimple";
  static const POST_UpdateAddress =
      "${RoutingBase.ApiUrl}/$BaseName/UpdateAddress";

  static const POST_SendCart = "${RoutingBase.ApiUrl}/$BaseName/SentCartToUser";

  static const DELETE_DeleteCart = "${RoutingBase.ApiUrl}/$BaseName/DeleteCart";
  static const DELETE_DeleteProduct =
      "${RoutingBase.ApiUrl}/$BaseName/DeleteProductSimple";
  static const DELETE_DeleteCartById =
      "${RoutingBase.ApiUrl}/$BaseName/DeleteCart";

  static const PUT_UpdateProduct =
      "${RoutingBase.ApiUrl}/$BaseName/UpdateProductSimple";
  static const GET_Payment =
      "${RoutingBase.ApiUrl}/$BaseName/GenerateOrderWithAddress";
  static const GET_PaymentZarinPal =
      "${RoutingBase.ApiUrl}/$BaseName/GenerateOrderWithAddressZarrin";

}
