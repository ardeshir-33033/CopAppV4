import 'package:copapp/Controller/Controllers/ProfileController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'EditingPersonalInfoTab.dart';
import 'PersonalInfoTabWidget.dart';

class PersonalInfoTab extends StatelessWidget {
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: profileController.editingBool
          ? EditingPersonalInfoTab()
          : Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      profileController.setEditingBool(true);
                    },
                    child: Container(
                      // color: Colors.blue,
                      margin: EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              "ویرایش اطلاعات",
                              style: TextStyle(
                                fontSize: CBase().mtextfontSize,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          SvgPicture.asset("images/pencil.svg"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  PersonalInfoTabWidget(),
                ],
              ),
            ),
    );
  }
}
