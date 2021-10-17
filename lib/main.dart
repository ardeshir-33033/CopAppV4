import 'dart:io';
import 'package:copapp/View/Pages/LoginPages/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'Utilities/Base.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarColor: CBase().baseBlackColor,
    statusBarColor: CBase().baseBlackColor,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(Platform.isIOS){
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Platform.isIOS? Locale("en", "US"):Locale("fa","IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: Platform.isIOS? Locale("en", "US"):Locale("fa","IR"),
        home: MyHomePage(),
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder()}),
          canvasColor: Colors.transparent,
          // brightness: Brightness.dark,
          primaryColor: CBase().basePrimaryColor,
          accentColor: CBase().textPrimaryColor,
          fontFamily: CBase().fontFamily,
          scaffoldBackgroundColor: CBase().backgroundColor,
          primaryColorLight: CBase().basePrimaryLightColor,
          indicatorColor: CBase().basePrimaryColor,
          textSelectionColor: CBase().textPrimaryColor,
          primaryColorDark: CBase().textPrimaryColor,
          tabBarTheme: TabBarTheme(
            labelStyle: TextStyle(
              fontFamily: CBase().fontFamily,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: CBase().fontFamily,
            ),
          ),

          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                fontFamily: CBase().fontFamily,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    CBase().setDeviceDimension(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return LoginPage();
  }
}
