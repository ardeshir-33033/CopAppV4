import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

class KDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        height: 1,
        thickness: 1,
        color: CBase().borderPrimaryColor,
      ),
    );
  }
}

class WDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.white,
      ),
    );
  }
}
