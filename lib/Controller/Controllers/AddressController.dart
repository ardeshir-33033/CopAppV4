import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Controllers/AddAddressController.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Model/Address.dart';
import 'package:get/get.dart';


class AddressController extends GetxController {

  ResponseModel<List<Address>> addressModel = ResponseModel<List<Address>>();
  List<Address> addresses = [];
  bool isLoading = false;
  AddAddressController addAddressController = Get.put(AddAddressController());

  Future<ResponseModel> initAddress() async {
    addressModel = await ProfileServiceV2().getAddresses();
    addAddressController.isSendingCart = false;
    return addressModel;
  }

  @override
  void onInit() {
    super.onInit();
    isLoading = true;
    update();
    addresses = [];
    initAddress().then((value) {
      if(!value.isSuccess){
        value.showMessage();
      }
      addresses = addressModel.data;
      isLoading = false;
      update();
    });
  }

  void deleteAddress(int index) async {
    ResponseModel res =
        await ProfileServiceV2().deleteAddress(addresses[index].id!);
    if (!res.isSuccess) {
      res.showMessage();
    } else {
      initAddress().then((value) {
        addresses = addressModel.data;
        update();
      });
    }
  }
}
