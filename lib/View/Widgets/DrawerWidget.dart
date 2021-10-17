import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  DrawerWidget({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          scaffoldKey.currentState!.openDrawer();
        },
        child: Padding(
          padding:
              EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0, right: 20),
          child: SvgPicture.asset(
            "images/DrawerIcon2.svg",
            height: MediaQuery.of(context).size.height * 0.018,
          ),
        ),
      ),
    );
    ;
  }
}

