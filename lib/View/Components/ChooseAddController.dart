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
  ResponseModel<List<AllShippers>> ShipperResponse =
      ResponseModel<List<AllShippers>>();
  List<AllShippers> shipper = [];
  int radioVal = 1;
  List<bool> checkboxes = [true];
  // Address chosenAddress = Address();

  ResponseModel<List<Address>> AddressModel = ResponseModel<List<Address>>();

  List<Address>? addresses = [];

  Future initAddress() async {
    AddressModel = await ProfileServiceV2().GetAddresses();
  }

  Future<ResponseModel<List<AllShippers>>?> Shipper() async {
    ShipperResponse = await ShippingService().GetAllShippers();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Shipper().then((value) {
    //   shipper = ShipperResponse.data;
    //   update();
    // });
    addresses = null;
    initAddress().then((value) {
      addresses = AddressModel.data;
      for (int i = 0; i < addresses!.length; i++) {
        checkboxes.add(false);
      }
      checkboxSelect(0);
      update();
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
        await ProfileServiceV2().DeleteAddress(addresses![index].id!);
    if (!res.isSuccess) {
      res.showMessage();
    } else {
      initAddress().then((value) {
        addresses = AddressModel.data;
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
}
