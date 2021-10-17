import 'package:copapp/Controller/Controllers/ProfileController.dart';
import 'package:copapp/Model/Profile.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoTabWidget extends StatelessWidget {

  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: CBase().getFullHeight(context) / 4.4,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Row(
                  children: [
                    Text("نام:"),
                    SizedBox(
                      width: 20,
                    ),
                    Text(profileController.profileData.firstName ?? ""),
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
                    Text("نام خانوادگی:"),
                    SizedBox(
                      width: 20,
                    ),
                    Text(profileController.profileData.lastName ?? ""),
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
                    Text("تاریخ تولد:"),
                    SizedBox(
                      width: 20,
                    ),
                    profileController.profileData.yearBirthDate != null
                        ? Text(
                            "${profileController.profileData.yearBirthDate}/${profileController.profileData.monthBirthDate}/${profileController.profileData.dayBirthDate}")
                        : Text("وارد نشده است")
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
                    Text("کد ملی:"),
                    SizedBox(
                      width: 20,
                    ),
                    Text(profileController.profileData.nationalCode ?? ""),
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
