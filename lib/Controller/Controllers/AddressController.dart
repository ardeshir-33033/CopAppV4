import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Controllers/AddAddressController.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Controller/Service/ShippingService.dart';
import 'package:copapp/Model/Address.dart';
import 'package:copapp/Model/Neshan/NeshanModel.dart';
import 'package:copapp/Model/Shipping/CountryNameModel.dart';
import 'package:copapp/Model/Shipping/ProvinceCityModel.dart';
import 'package:copapp/Model/Shipping/ProvinceModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class AddressController extends GetxController {

  ResponseModel<List<Address>> AddressModel = ResponseModel<List<Address>>();
  List<Address> Addresses = [];
  bool isLoading = false;
  AddAddressController addAddressController = Get.put(AddAddressController());

  Future<ResponseModel> initAddress() async {
    AddressModel = await ProfileServiceV2().GetAddresses();
    addAddressController.isSendingCart = false;
    return AddressModel;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading = true;
    update();
    Addresses = [];
    initAddress().then((value) {
      if(!value.isSuccess){
        value.ShowMessage();
      }
      Addresses = AddressModel.data;
      isLoading = false;
      update();
    });
  }

  void deleteAddress(int index) async {
    ResponseModel res =
        await ProfileServiceV2().DeleteAddress(Addresses[index].id!);
    if (!res.isSuccess) {
      res.ShowMessage();
    } else {
      initAddress().then((value) {
        Addresses = AddressModel.data;
        update();
      });
    }
  }
}
