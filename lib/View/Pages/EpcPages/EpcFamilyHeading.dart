import 'package:flutter/material.dart';

class EpcFamilyHeading extends StatelessWidget {
  const EpcFamilyHeading({Key? key,required this.familyName,required this.carType})
      : super(key: key);
  final String familyName, carType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 21, right: 21, bottom: 18,),
      padding: EdgeInsets.all(15.0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
          color: Color(0xffe5e5e5), borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            familyName,
            maxLines: 1,
            style: TextStyle(
              color: Color(0xff5e5e5e),
            ),
          ),
          Text(
            carType,
            maxLines: 1,
            style: TextStyle(
              color: Color(0xff5e5e5e),
            ),
          ),
        ],
      ),
    );
  }
}
