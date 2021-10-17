import 'package:get/get.dart';

class CartLengthController extends GetxController{
  int cartLength = 0;

  setCartLength(int lCart){
    cartLength = lCart;
    update();
  }
}