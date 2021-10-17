import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Pages/ConfirmPages/Underlined.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PreviousDataWidget extends StatelessWidget {
  final Map? items;
  PreviousDataWidget({@required this.items});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: CBase().getFullWidth(context),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
            )
          ]),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < items!.length; i++)
            UnderlinedTextsWidget(
              title: items!.keys.elementAt(i),
              detail: items!.values.elementAt(i),
              dividerColor: Color(0xffCBCBCB),
              lastItem: i == items!.length-1 ? false :true ,
            ),
        ],
      ),
    );
  }
}
