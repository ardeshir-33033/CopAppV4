import 'package:copapp/Controller/Controllers/ProfileController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/Divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberInfoTabWidget extends StatelessWidget {

  final ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: CBase().getFullHeight(context) / 4.5,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Row(
                  children: [
                    Text("شماره همراه:"),
                    SizedBox(
                      width: 20,
                    ),
                    Text(profileController.profileData.phoneNumber ?? ""),
                  ],
                ),
              ),
              KDivider(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Row(
                  children: [
                    Text("تلفن:"),
                    SizedBox(
                      width: 20,
                    ),
                    Text(profileController.profileData.telePhoneNumber ?? ""),
                  ],
                ),
              ),
              KDivider(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Row(
                  children: [
                    Text("ایمیل:"),
                    SizedBox(
                      width: 20,
                    ),
                    Text(profileController.profileData.emailAddress ?? ""),
                  ],
                ),
              ),
              KDivider(),
            ],
          ),
        ],
      ),
    );
  }
}
