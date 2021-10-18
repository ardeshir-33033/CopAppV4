import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/FormRegisterStep1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatelessWidget {
  final bool vis = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController family = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // UserRegisterModel user = UserRegisterModel();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: CBase().getFullHeight(context) / 2.8,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: CBase().getFullHeight(context) / 3,
                              decoration: BoxDecoration(
                                  // color: Colors.black,
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                        "images/LoginPic.png",
                                      ))),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: SvgPicture.asset(
                              "images/CopAppLogin.svg",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormRegisterStep1(
                      scaffoldKey: _scaffoldKey,
                      // user: user,
                    ),
                    Container(
                      child: Visibility(
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: vis,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            accentColor: CBase().basePrimaryColor,
                          ),
                          child: vis
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      CBase().basePrimaryColor),
                                )
                              : Text(""),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
