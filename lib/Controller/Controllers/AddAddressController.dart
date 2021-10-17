import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Controllers/AddressController.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Controller/Service/ShippingService.dart';
import 'package:copapp/Model/Address.dart';
import 'package:copapp/Model/Neshan/NeshanModel.dart';
import 'package:copapp/Model/Shipping/CountryNameModel.dart';
import 'package:copapp/Model/Shipping/ProvinceCityModel.dart';
import 'package:copapp/Model/Shipping/ProvinceModel.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:copapp/View/Components/ChooseAddController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class AddAddressController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool stateVis = false;
  bool cityVis = false;
  LatLng? mapPosition;
  bool mapUpdate = false;
  NeshanAddress mapAddress = NeshanAddress();
  int? dropdownProvincevalue, dropdownCityvalue;
  Address? currentAddress;
  TextEditingController titleController = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController recieverNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController completeAddressController = TextEditingController();

  List<DropdownMenuItem> provincesItems = [];
  List<DropdownMenuItem> citiesItems = [];
  List<ProvinceModel> provinces = [];
  List<CountryName> countries = [];

  List<ProvinceCities> cities = [];

  bool isSendingCart=true;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading = true;
    update();
    initAddComp(currentAddress, mapAddress);
  }

  void initAddComp(Address? address, NeshanAddress mapAddress) {
    if (address == null) {
      currentAddress = null;
      titleController.text = '';
      postalCode.text = '';
      recieverNameController.text = '';
      phoneNumberController.text = '';
      mobileNumberController.text = '';
      completeAddressController.text = '';
      dropdownProvincevalue = null;
      dropdownCityvalue = null;
    }
    getCountries().then((value) {
      if (address != null) {
        for (int i = 0; i < provinces.length; i++) {
          if (provinces[i].name == address.province) dropdownProvincevalue = i;
        }
        setCities(dropdownProvincevalue!);
        for (int i = 0; i < cities.length; i++) {
          if (cities[i].persianName == address.city) dropdownCityvalue = i;
        }
        update();
      }
    });
    if (address != null) {
      currentAddress = address;
      titleController.text = address.title ?? '';
      postalCode.text = address.postalCode ?? '';
      recieverNameController.text = address.receiverName ?? '';
      phoneNumberController.text = address.phoneNumber ?? '';
      mobileNumberController.text = address.mobileNumber ?? '';
      completeAddressController.text = address.completeAddress ?? '';
    }
    setNeshanAddress(mapAddress);
    isLoading = false;
    update();
  }

  Future getCountries() async {
    try {
      ResponseModel<List<CountryName>> result =
          await ShippingService().GetAllCountries();

        countries = result.data;
        provinces = countries[0].countryProvinces!;
        provincesItems = [];
        for (int i = 0; i < provinces.length; i++) {
          provincesItems.add(DropdownMenuItem(
            value: i,
            child: Text(
              provinces[i].persianName!,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            ),
          ));
        }
        if (provinces.isNotEmpty && currentAddress != null) {
          for (int i = 0; i < provinces.length; i++) {
            if (provinces[i].persianName == currentAddress!.province)
              dropdownProvincevalue = i;
          }
          setCities(dropdownProvincevalue!);
          for (int i = 0; i < cities.length; i++) {
            if (cities[i].persianName == currentAddress!.city)
              dropdownCityvalue = i;
          }
        }
        update();

    } catch (e) {
      // ignore: deprecated_member_use
      scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text('مشکلی در دریافت اطلاعات رخ داده است'),
      ));
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    }
  }

  setCities(int i) {
    cities = provinces[i].provinceCities!;
    citiesItems = [];
    dropdownCityvalue = null;
    for (int i = 0; i < cities.length; i++) {
      citiesItems.add(DropdownMenuItem(
        value: i,
        child: Text(
          cities[i].persianName!,
          style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ));
    }
  }

  void onProvinceChange(value) {
    dropdownProvincevalue = value;
    setCities(value);
    update();
  }

  void onCityChange(value) {
    dropdownCityvalue = value;
    update();
  }

  void onConfirm(
    LatLng? mapMark,
  ) async {
    if (phoneNumberController.text.isNotEmpty &&
        completeAddressController.text.isNotEmpty &&
        mobileNumberController.text.isNotEmpty &&
        postalCode.text.isNotEmpty &&
        recieverNameController.text.isNotEmpty &&
        titleController.text.isNotEmpty &&
        dropdownCityvalue != null &&
        dropdownProvincevalue != null) {
      if (mapMark == null) {
        Snacki().GETSnackBar(false, 'لطفا موقعیت مکانی را مشخص کنید');

      } else {
        isLoading = true;
        update();
        phoneNumberController.text =
            phoneNumberController.text.toEnglishDigit();
        mobileNumberController.text =
            mobileNumberController.text.toEnglishDigit();
        postalCode.text = postalCode.text.toEnglishDigit();
        Address address = Address(
            id: currentAddress != null ? currentAddress!.id : null,
            locationLat: mapMark.latitude,
            locationLng: mapMark.longitude,
            province: provinces[dropdownProvincevalue!].persianName ?? "",
            mobileNumber: mobileNumberController.text,
            city: cities[dropdownCityvalue!].persianName,
            phoneNumber: phoneNumberController.text,
            completeAddress: completeAddressController.text,
            title: titleController.text,
            postalCode: postalCode.text,
            receiverName: recieverNameController.text);

        ResponseModel result = await ProfileServiceV2().SetAddresses(address);
        if (result.isSuccess) {
          // widget.onDataChange!();

          if (isSendingCart) {
            ChooseAddressController chAddressController = Get.find();
            chAddressController.onInit();
          } else {
            AddressController addressController = Get.find();
            addressController.onInit();
          }
          isLoading = false;
          update();
          Get.back();
        } else {
          result.showMessage();
          isLoading = false;
          update();
        }
      }
    } else {
      // ignore: deprecated_member_use
      scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text('لطفا تمام فیلد ها را پر کنید'),
      ));
    }
  }

  void setNeshanAddress(NeshanAddress mapAddress) {
    if (mapAddress.status == "OK") {
      completeAddressController.text = mapAddress.formattedAddress!;
      if (mapAddress.state != null && mapAddress.state!.isNotEmpty) {
        for (int p = 0; p < provinces.length; p++) {
          if (mapAddress.state!.contains(provinces[p].persianName!)) {
            dropdownProvincevalue = p;
            setCities(p);
            break;
          }
        }
        if (mapAddress.city != null && mapAddress.city!.isNotEmpty) {
          for (int c = 0; c < cities.length; c++) {
            if (mapAddress.city!.contains(cities[c].persianName!)) {
              dropdownCityvalue = c;
              break;
            }
          }
        }
      }
      update();
    }
  }
}
