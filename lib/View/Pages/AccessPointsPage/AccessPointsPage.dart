import 'package:copapp/Controller/Controllers/AccessPointController.dart';
import 'package:copapp/Controller/Controllers/General/ScoreService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'NewPassword.dart';
import 'PointsRoundedButton.dart';

class AccessPointsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final AccessPointController accessPointController =
      Get.put(AccessPointController());

  final ScoreService scoreServiceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xffF6F6F6),
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: scaffoldKey,
        ),
        body: GetBuilder<AccessPointController>(

          builder: (_) {
            return accessPointController.type == 4
                ? Center(
                    child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
                  ))
                : Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 9.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            accessPointController.type == 2
                                ? InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PointsNewPassword(),
                                        ),
                                      ).then((value) {
                                        accessPointController.newPass(value);
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 5, left: 10, bottom: 5),
                                      child: Text(
                                        "رمز جدید",
                                        style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize:
                                                CBase().getTextfontSizeByScreen()),
                                      ),
                                    ),
                                  )
                                : Text(""),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Container(
                                  height: 20.0,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'بازگشت',
                                        style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize:
                                                CBase().getTextfontSizeByScreen()),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 10.0,
                                        color: Color(0xffEB5151),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              accessPointController.type == 3
                                  ? 'رمز جدید'
                                  : accessPointController.type == 2
                                      ? 'بخش فنی'
                                      : accessPointController.type == 1
                                          ? "رمز جدید"
                                          : '',
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: CBase().getTitlefontSizeByScreen()),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                            bottom: MediaQuery.of(context).size.height * 0.05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.1,
                                  child: TextField(
                                    enabled: false,
                                    controller:
                                        accessPointController.textEditingController4,
                                    textAlign: TextAlign.center,
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.1,
                                  child: TextField(
                                    enabled: false,
                                    controller:
                                        accessPointController.textEditingController3,
                                    textAlign: TextAlign.center,
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.1,
                                  child: TextField(
                                    controller:
                                        accessPointController.textEditingController2,
                                    enabled: false,
                                    textAlign: TextAlign.center,
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.1,
                                  child: TextField(
                                    enabled: false,
                                    controller:
                                        accessPointController.textEditingController1,
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            keyPad(context),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: CBase().getFullWidth(context) * 0.3),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all<TextStyle>(
                                    TextStyle(
                                        color: Color(0xff5E5E5E),
                                        fontFamily: CBase().fontFamily,
                                        fontSize: CBase().getLargefontSizeByScreen()),
                                  ),
                                  elevation: MaterialStateProperty.all<double>(0.0),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ))),
                              onPressed: () {
                                bool res =
                                    scoreServiceController.getShowScore() == false
                                        ? true
                                        : false;
                                scoreServiceController.setShowScore(res);
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        accessPointController.submit();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 8.0),
                                        child: Center(
                                          child: accessPointController.isLoading
                                              ? Center(
                                                  child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<Color>(
                                                            CBase().basePrimaryColor),
                                                  ),
                                                )
                                              : Text(
                                                  'ادامه',
                                                  style: TextStyle(
                                                      color: Color(0xff5E5E5E),
                                                      fontSize: CBase()
                                                          .getLargefontSizeByScreen()),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  );
          }
        ),
      ),
    );
  }

  Widget keyPad(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i <= 3; i++)
          Row(
            children: <Widget>[
              for (int j = 1; j < 4; j++)
                if (j + (i * 3) + (4 - 2 * j) < 10)
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: PointsRoundButton(
                      child: Text(
                        '${j + (i * 3) + (4 - 2 * j)}',
                        style: TextStyle(
                            color: Color(0xff707070),
                            fontSize: CBase().getLargefontSizeByScreen() * 1.5),
                      ),
                      color: Color(0xffF3F3F3),
                      onTap: () {
                        accessPointController.enter(j + (i * 3) + (4 - 2 * j));
                      },
                      size: MediaQuery.of(context).size.width * 0.2,
                    ),
                  )
                else if (j + (i * 3) + (4 - 2 * j) == 11)
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: PointsRoundButton(
                      child: Text(
                        '${0}',
                        style: TextStyle(
                            color: Color(0xff707070),
                            fontSize: CBase().getLargefontSizeByScreen() * 1.5),
                      ),
                      color: Color(0xffF3F3F3),
                      onTap: () {
                        accessPointController.enter(0);
                      },
                      size: MediaQuery.of(context).size.width * 0.2,
                    ),
                  )
                else if (j + (i * 3) + (4 - 2 * j) == 12)
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: PointsRoundButton(
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.backspace,
                          color: Color(0xff707070),
                        ),
                      ),
                      color: Color(0xffF3F3F3),
                      onTap: () {
                        accessPointController.clearAll();
                      },
                      size: MediaQuery.of(context).size.width * 0.2,
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.2,
                    ),
                  )
            ],
          )
      ],
    );
  }
}
