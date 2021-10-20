import 'package:copapp/Api/Routing/RoutingBase.dart';

class RoutingInquiry extends RoutingBase {
  static const BaseName = "Inquiry";

  static const GetInquiry = "${RoutingBase.ApiUrlV2}/$BaseName/GetInquiry";
  static const Post_AddProduct = "${RoutingBase.ApiUrlV2}/$BaseName/AddProductToInquiry";
  static const Post_UpdateProduct =
      "${RoutingBase.ApiUrlV2}/$BaseName/UpdateProductInquiry";
  static const DeleteProduct = "${RoutingBase.ApiUrl}/$BaseName/DeleteProdutFromInquiry";
  static const GenerateOrderWithAddress =
      "${RoutingBase.ApiUrl}/$BaseName/GenerateOrderWithAddress";
  static const GenerateManualPreOrder =
      "${RoutingBase.ApiUrl}/$BaseName/GenerateManualPreOrder";
}
