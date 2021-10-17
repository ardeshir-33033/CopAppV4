import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CBase {
  static double deviceHeight = 0.0;
  static double deviceWidth = 0.0;
  Color baseYellowColor = Color(0xffffd400);
  Color baseBlackColor = Color(0xff262626);
  Color baseGrey = Color(0xff464646);
  Color basePrimaryColor = Color(0xffca1237);
  Color basePrimaryLightColor = Color(0xfff3728c);
  Color borderPrimaryColor = Color(0xffcbcbcb);
  Color pureBlack = Color(0xff000000);
  Color pureWhite = Color(0xffffffff);
  Color iconColor = Color(0xffBFBFBF);
  Color lightTitleColor = Color(0xff8D8D8D);
  static const Color textYellowColor = Color(0xffFFC400);
  Color textPrimaryColor = Color(0xff878787);
  Color textLightPrimaryColor = Color(0xffF9F9F9);
  Color backgroundColor = Color(0xfff4f4f4);
  Color linkColor = Colors.blueAccent;
  Color successColor = Colors.greenAccent;
  String fontFamily = "IRANSans";

  // final AudioCache audioCache =  AudioCache(
  //   prefix: 'assets/audio/',
  //   fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
  // );


  // global variables
  double searchSpacer = 70.0;

  // small
  double slargefontSize = 18;
  double stitlefontSize = 14;
  double ssubTitlefontSize = 9;
  double stextfontSize = 9;
  double ssmallTextfontSize = 9;

  // medium
  double mlargefontSize = 19;
  double mtitlefontSize = 15;
  double msubTitlefontSize = 10;
  double mtextfontSize = 10;
  double msmallTextfontSize = 10;

  // large
  double llargefontSize = 20;
  double ltitlefontSize = 17;
  double lsubTitlefontSize = 13;
  double ltextfontSize = 11;
  double lsmallTextfontSize = 10;

  double borderPrimarySize = 0.5;
  double boxHeight = 60.0;
  double radius = 10.0;
  TextAlign textAlignRight = TextAlign.right;
  TextDirection rtl = TextDirection.rtl;
  EdgeInsets smallEdge = EdgeInsets.all(5.0);
  EdgeInsets normallEdge = EdgeInsets.all(10.0);
  EdgeInsets largeEdge = EdgeInsets.all(15.0);
  EdgeInsets exLargeEdge = EdgeInsets.all(20.0);
  EdgeInsets contentEdge = EdgeInsets.only(top: 70.0);
  BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
  BoxDecoration titleBoxDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(
        width: 0.5,
        color: Color(0xffcbcbcb),
      ),
    ),
  );

  double getFullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getFullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  setDeviceDimension(double w, double h) {
    deviceHeight = h;
    deviceWidth = w;
  }

  getDeviceDimension() {
    return deviceHeight * deviceWidth;
  }

  double getHugefontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return slargefontSize * 2;
    } else if (size <= 350000.0) {
      return mlargefontSize * 2;
    } else {
      return llargefontSize * 2;
    }
  }

  double getLargefontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return slargefontSize;
    } else if (size <= 350000.0) {
      return mlargefontSize;
    } else {
      return llargefontSize;
    }
  }

  double getTitlefontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return stitlefontSize;
    } else if (size <= 350000.0) {
      return mtitlefontSize;
    } else {
      return ltitlefontSize;
    }
  }

  double getSubTitlefontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return ssubTitlefontSize;
    } else if (size <= 350000.0) {
      return msubTitlefontSize;
    } else {
      return lsubTitlefontSize;
    }
  }

  double getTextfontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return stextfontSize;
    } else if (size <= 350000.0) {
      return mtextfontSize;
    } else {
      return ltextfontSize;
    }
  }

  double getSmallfontSizeByScreen() {
    var size = getDeviceDimension();

    if (size <= 270000.0) {
      return ssmallTextfontSize;
    } else if (size <= 350000.0) {
      return msmallTextfontSize;
    } else {
      return lsmallTextfontSize;
    }
  }

  String getCleanedTitleText(String text, int length) {
    try {
      var words = text.split(" ").toList();

      if (words.length <= 1) words = text.split("_");

      String result = "";

      for (int i = 0; i < words.length; i++) {
        result += " " + words[i];

        if (i + 1 < words.length &&
            result.length + words[i + 1].length > length) {
          result += " ...";
          break;
        }
      }

      return result;
    } catch (e) {}
    return "";
  }
}
