import 'package:copapp/Controller/Controllers/ProfileController.dart';
import 'package:copapp/Model/Profile.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberInfoTabWidget extends StatelessWidget {

  ProfileController profileController = Get.find();
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
              kdivider(),
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
              kdivider(),
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
              kdivider(),
            ],
          ),
        ],
      ),
    );
  }
}

class kdivider extends StatelessWidget {
  const kdivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Divider(
        height: 1,
        thickness: 1,
        color: CBase().borderPrimaryColor,
      ),
    );
  }
}
