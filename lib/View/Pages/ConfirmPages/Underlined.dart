import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

class UnderlinedTextsWidget extends StatelessWidget {
  final String? title, detail;
  final Color dividerColor;
  final bool? lastItem;

  UnderlinedTextsWidget(
      {Key? key,
      @required this.title,
      @required this.detail,
      this.lastItem = false,
      this.dividerColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title!,
                  style: TextStyle(
                      color: Color(0xff7B7B7B),
                      fontFamily: 'Iransans',
                      fontSize: CBase().getTextfontSizeByScreen()),
                ),
                flex: 1,
              ),
              Expanded(
                child: Text(
                  detail!,
                  style: TextStyle(
                      color: Color(0xff7B7B7B),
                      fontFamily: 'Iransans',
                      fontSize: CBase().getTextfontSizeByScreen()),
                ),
                flex: 4,
              ),
            ],
          ),
          lastItem == true
              ? Divider(
                  color: dividerColor,
                )
              : Container()
        ],
      ),
    );
  }
}
