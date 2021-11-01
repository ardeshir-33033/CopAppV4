import 'package:copapp/Controller/Controllers/ProfileController.dart';
import 'package:copapp/View/Components/General/Divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoTabWidget extends StatelessWidget {
  final ProfileController profileController = Get.find();
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
              GDivider(),
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
              GDivider(),
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
              GDivider(),
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
              GDivider(),
            ],
          ),
        ],
      ),
    );
  }
}
