import 'package:copapp/Api/Routing/RoutingBase.dart';

class RoutingInquiry extends RoutingBase {
  static const BaseName = "Inquiry";

  static const GetInquiry = "${RoutingBase.ApiUrl}/$BaseName/Get";
  static const Post_AddProduct = "${RoutingBase.ApiUrl}/$BaseName/AddProduct";
  static const Put_UpdateProduct =
      "${RoutingBase.ApiUrl}/$BaseName/UpdateProduct";
  static const DeleteProduct = "${RoutingBase.ApiUrl}/$BaseName/DeleteProduct";
  static const GenerateOrderWithAddress =
      "${RoutingBase.ApiUrl}/$BaseName/GenerateOrderWithAddress";
  static const GenerateManualPreOrder =
      "${RoutingBase.ApiUrl}/$BaseName/GenerateManualPreOrder";
}
