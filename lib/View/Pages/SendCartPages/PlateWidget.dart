import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlateWidget extends StatefulWidget {
  final TextEditingController textEditingController1,
      textEditingController2,
      textEditingController3,
      textEditingController4;

  const PlateWidget(
      {Key? key,
      required this.textEditingController1,
      required this.textEditingController2,
      required this.textEditingController3,
      required this.textEditingController4})
      : super(key: key);
  @override
  _PlateWidgetState createState() => _PlateWidgetState();
}

class _PlateWidgetState extends State<PlateWidget> {
  // List<DropdownMenuItem<String>> dropDownItems = [
  //   DropdownMenuItem(
  //     child: Text('الف'),
  //     value: 'الف',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ب'),
  //     value: 'ب',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('پ'),
  //     value: 'پ',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ت'),
  //     value: 'ت',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ث'),
  //     value: 'ث',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ج'),
  //     value: 'ج',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('چ'),
  //     value: 'چ',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ح'),
  //     value: 'ح',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('خ'),
  //     value: 'خ',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('د'),
  //     value: 'د',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ذ'),
  //     value: 'ذ',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ر'),
  //     value: 'ر',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ز'),
  //     value: 'ز',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ژ'),
  //     value: 'ژ',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('س'),
  //     value: 'س',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ش'),
  //     value: 'ش',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ص'),
  //     value: 'ص',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ض'),
  //     value: 'ض',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ط'),
  //     value: 'ط',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ظ'),
  //     value: 'ظ',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ع'),
  //     value: 'ع',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('غ'),
  //     value: 'غ',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ف'),
  //     value: 'ف',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ق'),
  //     value: 'ق',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ک'),
  //     value: 'ک',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('گ'),
  //     value: 'گ',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ل'),
  //     value: 'ل',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('م'),
  //     value: 'م',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ن'),
  //     value: 'ن',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('و'),
  //     value: 'و',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('هـ'),
  //     value: 'هـ',
  //   ),
  //   DropdownMenuItem(
  //     child: Text('ی'),
  //     value: 'ی',
  //   ),
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.textEditingController1.addListener(() {
      if (widget.textEditingController1.text.length > 2) {
        widget.textEditingController1.text =
            widget.textEditingController1.text.substring(0, 2);
      }
    });
    widget.textEditingController2.addListener(() {
      if (widget.textEditingController2.text.length > 3) {
        widget.textEditingController2.text =
            widget.textEditingController2.text.substring(0, 3);
      }
    });
    widget.textEditingController3.addListener(() {
      if (widget.textEditingController3.text.length > 1 &&
          widget.textEditingController3.text != 'الف') {
        if (widget.textEditingController3.text.contains("ا") &&
            widget.textEditingController3.text.contains("ل") &&
            widget.textEditingController3.text.contains("ف")) {
          String a = widget.textEditingController3.text.replaceFirst('ا', '');
          String b = a.replaceFirst('ل', '');
          String c = b.replaceFirst('ف', '');
          widget.textEditingController3.value = TextEditingValue(
            text: c,
            selection: TextSelection.collapsed(
                offset:
                    widget.textEditingController3.text.substring(0, 1).length),
          );
        } else {
          widget.textEditingController3.value = TextEditingValue(
            text: widget.textEditingController3.text.substring(1, 2),
            selection: TextSelection.collapsed(
                offset:
                    widget.textEditingController3.text.substring(0, 1).length),
          );
        }
      }
      if (widget.textEditingController3.text == 'آ' ||
          widget.textEditingController3.text == 'ا') {
        widget.textEditingController3.value = TextEditingValue(
          text: 'الف',
          selection: TextSelection.collapsed(offset: 'الف'.length),
        );
      }
    });
    widget.textEditingController4.addListener(() {
      if (widget.textEditingController4.text.length > 2) {
        widget.textEditingController4.text =
            widget.textEditingController4.text.substring(0, 2);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    double parentWidth = MediaQuery.of(context).size.width * 0.38;
    double parentHeight = parentWidth * 0.206;
    return Container(
      width: parentWidth,
      height: parentHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/Plate.png'), fit: BoxFit.fill),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: parentHeight,
            width: parentWidth * 0.1932,
            child: Center(
              child: TextField(
                controller: widget.textEditingController1,
                textAlign: TextAlign.center,
                style: TextStyle(color: CBase().textPrimaryColor),
                maxLength: 2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  hintText: '11',
                  hintStyle: TextStyle(color: Colors.black26),
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                ),
              ),
            ),
          ),
          Container(
            height: parentHeight,
            width: parentWidth * 0.322,
            child: Center(
              child: TextField(
                controller: widget.textEditingController2,
                textAlign: TextAlign.center,
                style: TextStyle(color: CBase().textPrimaryColor),
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  hintText: '111',
                  hintStyle: TextStyle(color: Colors.black26),
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                ),
              ),
            ),
          ),
          Container(
            height: parentHeight,
            width: parentWidth * 0.161,
            child: Align(
              alignment: Alignment.topCenter,
              child: TextField(
                controller: widget.textEditingController3,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                // maxLength: 1,

                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"^[آ-ی]*"))
                ],
                style: TextStyle(color: CBase().textPrimaryColor),

                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 8),
                  counterText: '',
                  hintText: 'د',
                  hintStyle: TextStyle(color: Colors.black26),
                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(5.0),
                  //     borderSide:
                  //         BorderSide(width: 1, color: Color(0xff707070)))
                ),
              ),
            ),
          ),
          Container(
            height: parentHeight,
            width: parentWidth * 0.2254,
            child: Center(
              child: TextField(
                controller: widget.textEditingController4,
                textAlign: TextAlign.center,
                style: TextStyle(color: CBase().textPrimaryColor),
                maxLength: 2,
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                    counterText: '',
                    hintText: '11',
                    hintStyle: TextStyle(color: Colors.black26)),
              ),
            ),
          ),
          Container(
            width: parentWidth * 0.0966,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
