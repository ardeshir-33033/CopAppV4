import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/FormRegisterStep2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QC_RegisterPasswordPage extends StatefulWidget {
  // UserRegisterModel user = UserRegisterModel();
  String phoneNumber;

  QC_RegisterPasswordPage({
    // this.user,
    required this.phoneNumber,
  });

  @override
  _QC_RegisterPasswordPageState createState() =>
      _QC_RegisterPasswordPageState();
}

class _QC_RegisterPasswordPageState extends State<QC_RegisterPasswordPage> {
  // UserRegisterModel user = UserRegisterModel();

  // _QC_RegisterPasswordPageState({this.user});

  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(hasScrollBody: false,
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
                    FormRegisterStep2(
                      phoneNumber: widget.phoneNumber,
                      // user: user,
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
