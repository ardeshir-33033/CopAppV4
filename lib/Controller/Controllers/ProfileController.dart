import 'dart:io';

import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Model/Profile.dart';
import 'package:copapp/Utilities/Snacki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    isLoadingMain = true;
    update();
    getPersonalInfo().then((isSuccess) {
      if (isSuccess) {
        profileData = profileResponse.data;
        isLoadingMain = false;
        update();
      }
    });
  }

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController codemelli = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController teleNumber = new TextEditingController();
  TextEditingController email = TextEditingController();

  bool isLoadingPersonal = false,
      isLoadingNumber = false,
      isLoadingMain = false,
      isUploading = false;
  ResponseModel<Profile> profileResponse = ResponseModel<Profile>();
  Profile profileData = Profile();
  bool editingBool = false;

  File? image;
  final picker = ImagePicker();
  bool uploadImage = false;

  Future<bool> getPersonalInfo() async {
    profileResponse = await ProfileServiceV2().getPersonalInformation();
    profileResponse.showMessage();
    return profileResponse.isSuccess;
  }

  confirmNumber() {
    isLoadingNumber = true;
    update();
    if (teleNumber.text != "") {
      ProfileServiceV2.profile.telePhoneNumber =
          teleNumber.text.toEnglishDigit();
    }
    if (phoneNumber.text != "") {
      ProfileServiceV2.profile.phoneNumber = phoneNumber.text.toEnglishDigit();
    }
    if (email.text != "") {
      ProfileServiceV2.profile.emailAddress = email.text;
    }
    ProfileServiceV2().editPersonalInformation().then((v) {
      v.showMessage();

      isLoadingNumber = false;
      editingBool = false;
      update();
    });
  }

  confirmPersonalInfo() {
    isLoadingPersonal = true;
    update();

    if (lastname.text != "") {
      // ProfileServiceV2().setPhoneNumber(controller2.text);
      ProfileServiceV2.profile.lastName = lastname.text;
    }
    if (firstname.text != "") {
      ProfileServiceV2.profile.firstName = firstname.text;
    }
    if (birthday.text != "") {
      List<String> date = birthday.text.split('/');
      ProfileServiceV2.profile.yearBirthDate = int.parse(date[0]);
      ProfileServiceV2.profile.monthBirthDate = int.parse(date[1]);
      ProfileServiceV2.profile.dayBirthDate = int.parse(date[2]);
    }
    if (codemelli.text != "") {
      ProfileServiceV2.profile.nationalCode = codemelli.text;
    }
    ProfileServiceV2().editPersonalInformation().then((v) {
      v.showMessage();

      isLoadingPersonal = false;

      editingBool = false;
      update();
    });
  }

  getPicture(int i) async {
    var pickedFile;
    if (i == 1) {
      pickedFile = await picker.getImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxHeight: 500.0,
          maxWidth: 500);
    }
    if (i == 2) {
      pickedFile = await picker.getImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxHeight: 500.0,
          maxWidth: 500);
    }
    if (pickedFile != null) {
      File? croppedFile = await ImageCropper.cropImage(
          compressQuality: 100,
          sourcePath: pickedFile.path,
          // aspectRatioPresets: [
          //   CropAspectRatioPreset.square,
          //   CropAspectRatioPreset.ratio3x2,
          //   CropAspectRatioPreset.original,
          //   CropAspectRatioPreset.ratio4x3,
          //   CropAspectRatioPreset.ratio16x9
          // ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'CopApp',
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colors.black,
              hideBottomControls: true,
              initAspectRatio: CropAspectRatioPreset.original,
              activeControlsWidgetColor: Colors.white,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      uploadImage = true;

      image = File(croppedFile!.path);
      update();
      ProfileServiceV2.uploadPic = true;
      ProfileServiceV2.profile.imageAddress = image!.path;
      isUploading = true;
      update();
      await ProfileServiceV2().upload(image!).then((v) {
        if (v) {
          isUploading = false;
          update();
          Get.back();
        } else {
          Get.back();
          Snacki().GETSnackBar(false, 'عملیات با شکست مواج شد.');
        }
      });
    }
  }

  void removeProfilePic() {
    isUploading = true;

    update();
    if (ProfileServiceV2.profile.imageAddress != null)
      ProfileServiceV2()
          .editPersonalInformation(isImageDeleted: true)
          .then((value) {
        if (value.isSuccess) {
          profileData = value.data;
          isUploading = false;
          image = null;
          uploadImage = false;
          update();
          Get.back();
        } else {
          Get.back();
          value.showMessage();
        }
      });
  }

  setEditingBool(bool v) {
    editingBool = v;
    update();
  }

  void setPersonalTextFeilds() {
    firstname.text = ProfileServiceV2.profile.firstName!;
    lastname.text = ProfileServiceV2.profile.lastName!;
    codemelli.text = ProfileServiceV2.profile.nationalCode!;
    birthday.text = ProfileServiceV2.profile.yearBirthDate!.toString() +
        '/' +
        ProfileServiceV2.profile.monthBirthDate!.toString() +
        '/' +
        ProfileServiceV2.profile.dayBirthDate!.toString();
    update();
  }

  void setNumberTextFields() {
    phoneNumber.text = ProfileServiceV2.profile.phoneNumber ?? "";
    teleNumber.text = ProfileServiceV2.profile.telePhoneNumber ?? "";
    email.text = ProfileServiceV2.profile.emailAddress ?? "";
  }
}
