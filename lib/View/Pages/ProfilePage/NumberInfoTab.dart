import 'package:copapp/Controller/Controllers/ProfileController.dart';
import 'package:copapp/Model/Profile.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'EditingNumberTab.dart';
import 'NumberInfoTabWidget.dart';

class NumberInfoTab extends StatelessWidget {
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: profileController.editingBool
          ? EditingNumberTab()
          : Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              "ویرایش اطلاعات",
                              style: TextStyle(
                                fontSize: CBase().mtextfontSize,
                              ),
                            ),
                          ),
                          onTap: () {
                            profileController.setEditingBool(true);
                          },
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset("images/pencil.svg"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  NumberInfoTabWidget(),
                ],
              ),
            ),
    );
  }
}
