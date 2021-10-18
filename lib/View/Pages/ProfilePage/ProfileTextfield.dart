import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';


class ProfileTextField extends StatelessWidget {
  ProfileTextField({
    @required this.controller,
    this.hint,
  });

  final TextEditingController? controller;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 0),
      child: TextField(
        controller: controller,
        // onSubmitted: (value){
        //   controller.text = value;
        // },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: CBase().textPrimaryColor),
          labelStyle: TextStyle(color: Colors.blue),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CBase().textPrimaryColor),
          ),
        ),
        // textDirection: TextDirection.rtl,
      ),
    );
  }
}
