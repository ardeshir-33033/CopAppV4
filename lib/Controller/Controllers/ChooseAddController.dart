import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Controllers/AddAddressController.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Controller/Service/ShippingService.dart';
import 'package:copapp/Model/Address.dart';
import 'package:copapp/Model/Shipping/AllShippers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseAddressController extends GetxController {
  AddAddressController addAddressController = Get.put(AddAddressController());
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ResponseModel shipperResponse = ResponseModel();
  List<AllShippers> shipper = [];
  int radioVal = 1;
  List<bool> checkboxes = [true];
  bool isLoading = false;

  ResponseModel addressModel = ResponseModel();

  List<Address>? addresses = [];

  Future initAddress() async {
    addressModel = await ProfileServiceV2().getAddresses();
  }

  Future<ResponseModel<List<AllShippers>>?> getShipper() async {
    shipperResponse = await ShippingService().getAllShippers();
  }

  @override
  void onInit() {
    super.onInit();
    // Shipper().then((value) {
    //   shipper = ShipperResponse.data;
    //   update();
    // });
    addresses = null;
    initAddress().then((value) {
      if (addressModel.isSuccess) {
        addresses = addressModel.data;
        for (int i = 0; i < addresses!.length; i++) {
          checkboxes.add(false);
        }
        checkboxSelect(0);
        update();
      }
    });
  }

  void checkboxSelect(int index) {
    if (checkboxes[index] == false) {
      for (int i = 0; i <= addresses!.length; i++) checkboxes[i] = false;
      checkboxes[index] = true;
      // chosenAddress =  addresses![index];
    }
    update();
  }

  void delete(int index) async {
    ResponseModel res =
        await ProfileServiceV2().deleteAddress(addresses![index].id!);
    if (!res.isSuccess) {
      res.showMessage();
    } else {
      initAddress().then((value) {
        addresses = addressModel.data;
        update();
      });
    }
  }

  Address? getSelectedAddress() {
    if (checkboxes[0]) {
      return null;
    } else {
      for (int i = 1; i < checkboxes.length; i++) {
        if (checkboxes[i]) {
          return addresses![i - 1];
        }
      }
    }
  }

  void setLoading(bool bool) {
    isLoading = bool;
    update(['loading']);
  }
}
