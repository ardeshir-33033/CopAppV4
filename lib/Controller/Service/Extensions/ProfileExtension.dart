import 'dart:convert';
import 'dart:io';

import 'package:copapp/Model/Keyword.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/Utilities/SharedPreferencePath.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class ProfileExtensions {
  // consts
  static const String displayModeKey = "display-data";
  static const String displayPointKey = "point-data";
  static const String autoLoginKey = "auto-login-data";
  static const String myCarKey = "my-car";
  static double deviceWidth = 0.0;
  static double deviceHeight = 0.0;
  static String displayMode = "grid";
  static Function(dynamic result)? displayModeChangeCallback;
  static Function(dynamic result)? profileExtensionChanged;

  static Keyword? mycar;
  static bool displayPoint = false;
  static bool mechanicPanelOpened = false;
  static int selectedNavIndex = 0;

  static TextEditingController passwordController = TextEditingController();
  static String profileIconSvg =
      '<svg viewBox="10.5 8.0 13.5 9.0" ><path transform="translate(10.49, 7.99)" d="M 0 4.504886150360107 C 0 4.504886150360107 4.503236293792725 8.999323844909668 4.504886150360107 9.009772300720215 C 4.50653600692749 9.020220756530762 13.51465797424316 0 13.51465797424316 0" fill="none" stroke="#8d4399" stroke-width="3" stroke-miterlimit="4" stroke-linecap="round" /></svg>';


  // device
  setDeviceDimension(double w, double h) {
    deviceHeight = h;
    deviceWidth = w;
  }

  getDeviceDimension() {
    return deviceHeight * deviceWidth;
  }

  Future saveDisplayPointLocaly(bool point) async {
    await SharedPreferencePath()
        .setUserDataInSharePrefrences(point ? "1" : "0", displayPointKey);
  }

  Future<bool> loadDisplayPointLocaly() async {
    bool dp = await SharedPreferencePath()
                .getUserDataInSharePrefrences(displayPointKey) ==
            "1"
        ? true
        : false;

    return dp;
  }

  // Future saveMyCarLocaly(CarTipVM car) async {
  //   var json = jsonEncode(car);
  //   await SharedPrefrenceProvider()
  //       .setUserDataInSharePrefrences(json, myCarKey);
  // }

  // Future<CarTipVM> loadMyCarLocaly() async {
  //   var dm =
  //       await SharedPrefrenceProvider().getUserDataInSharePrefrences(myCarKey);

  //   var model = CarTipVM.fromJson(jsonDecode(dm));

  //   return model;
  // }

  Future saveDisplayModeLocaly(String mode) async {
    await SharedPreferencePath()
        .setUserDataInSharePrefrences(mode, displayModeKey);
  }

  Future<String> loadDisplayModeLocaly() async {
    var dm = await SharedPreferencePath()
        .getUserDataInSharePrefrences(displayModeKey);

    displayMode = dm ?? "grid";

    return dm ?? "grid";
  }

  void setDisplayMode(String mode) {
    displayMode = mode;
  }

  String getDisplayMode() {
    return displayMode;
  }

  bool isDisplayMode(String mode) {
    return displayMode == mode ? true : false;
  }

  setDisplayChangeCallback(Function(dynamic result) func) {
    displayModeChangeCallback = func;
  }

  setmyCar(Keyword car) {
    mycar = car;
  }

  Keyword getMyCar() {
    return mycar!;
  }

  bool haveCar() {
    return mycar != null ? true : false;
  }

  void setDisplayPoint(bool mode) {
    displayPoint = mode;
  }

  bool getDisplayPoint() {
    return displayPoint;
  }

  bool getMechanicPanelOpen() {
    return mechanicPanelOpened;
  }

  changeMechanicPanelOpen() {
    mechanicPanelOpened = mechanicPanelOpened ? false : true;
  }

}
