import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/EpcPages/HomePage.dart';
import 'package:copapp/View/Pages/HomePage.dart';
import 'package:copapp/View/Widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({required this.scaffoldKey, this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? title;
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title == null
                  ? InkWell(
                  onTap: () {
                    Get.to(() => EpcHome());
                  },
                  child: Text(
                    "EPC",
                    style: TextStyle(
                        color: CBase().textPrimaryColor,
                        fontSize: CBase().getLargefontSizeByScreen() - 3),
                  ))
                  : Text(
                title!,
                style: TextStyle(
                    color: CBase().textPrimaryColor,
                    fontSize: CBase().getTextfontSizeByScreen()),
              ),
              InkWell(
                  onTap: () {
                    String route = Get.currentRoute;
                    if (route != "" || route.isNotEmpty) {
                      if (route.substring(7) != "HomePageV4") {
                        Get.to(HomePageV4());
                      }
                    } else {
                      // Navigator.popUntil(
                      //     context, ModalRoute.withName("HomePageV4"));
                      Navigator.of(context).popUntil((route) => route.isFirst);

                      // Navigator.popUntil(
                      //   context,
                      //       (route) =>
                      //   route ==
                      //       MaterialPageRoute(
                      //           builder: (context) => HomePageV4()),
                      // );
                    }
                  },
                  child: SvgPicture.asset("images/CopAppTitle.svg")),
            ],
          )),
      leading: DrawerWidget(scaffoldKey: scaffoldKey),
    );
  }
}
