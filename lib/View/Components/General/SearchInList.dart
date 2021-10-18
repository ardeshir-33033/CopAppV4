import 'dart:io';

import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/Search/SearchSpeech.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import  'package:persian_number_utility/persian_number_utility.dart';


class SearchInList extends StatefulWidget {
  final List<String> list;
  final Function ?getResult;
  final bool noTextEmpty;
  final String hint;
  final Function? onTap;
  final bool enable, initFocus;

  SearchInList(
      {Key? key,
    required  this.list,
      this.getResult,
      this.noTextEmpty = false,
      this.hint = '',
      this.enable = true,
      this.initFocus = false, this.onTap})
      : super(key: key);

  @override
  _SearchInListState createState() => _SearchInListState();
}

class _SearchInListState extends State<SearchInList> {
  TextEditingController controller = TextEditingController();

  List<String> results = [];
  FocusNode textFocusNode = new FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initFocus) FocusScope.of(context).requestFocus(textFocusNode);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 8.05,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/searchbox.png'))),
      child: Row(
        children: [
          Expanded(
            flex: 260,
            child: InkWell(
              onTap: () {
                
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.search,
                    color: Color(0xff808080),
                    size: CBase().getTitlefontSizeByScreen(),
                  ),
                  Text(
                    'سرچ',
                    style: TextStyle(
                        color: Color(0xff808080),
                        fontSize: CBase().getTextfontSizeByScreen() * 1.5),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 842,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: Center(
                child: TextField(
                  controller: controller,
                  enableInteractiveSelection: widget.enable,
                  focusNode:
                      widget.enable ? textFocusNode : AlwaysDisabledFocusNode(),
                  onTap: () {
                    widget.onTap!();
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                        color: CBase().basePrimaryColor,
                        fontSize: CBase().getTextfontSizeByScreen(),
                      )),
                  style: TextStyle(
                    fontSize: CBase().getSmallfontSizeByScreen(),
                    color: CBase().basePrimaryColor,
                  ),
                  onChanged: (value) {
                    results = [];
                    widget.list.forEach((v) {
                      if ((v.toPersianDigit()).contains((value.toPersianDigit()))) results.add(v);
                    });
                    if (widget.noTextEmpty && value.isEmpty) results = [];
                    widget.getResult!(results);
                  },
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 260,
            child: Visibility(
              visible: !Platform.isIOS,
              child: Container(
                child: Center(
                  child: SearchSpeech(
                    speechTextCallBack: (result) {
                      controller.text = result;
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
