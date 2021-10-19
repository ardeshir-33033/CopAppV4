import 'package:copapp/Controller/Controllers/ProfileController.dart';
import 'package:copapp/Controller/Service/ProfileServiceV2.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalali_calendar/jalali_calendar.dart';

import 'ProfileTextfield.dart';

class EditingPersonalInfoTab extends StatefulWidget {
  @override
  _EditingPersonalInfoTabState createState() => _EditingPersonalInfoTabState();
}

class _EditingPersonalInfoTabState extends State<EditingPersonalInfoTab> {
  ProfileController profileController = Get.find();
  @override
  void initState() {
    super.initState();
    profileController.firstname.text = ProfileServiceV2.profile.firstName ?? '';
    profileController.lastname.text = ProfileServiceV2.profile.lastName ?? '';
    profileController.codemelli.text =
        ProfileServiceV2.profile.nationalCode ?? '';
    if (ProfileServiceV2.profile.yearBirthDate != null &&
        ProfileServiceV2.profile.monthBirthDate != null &&
        ProfileServiceV2.profile.dayBirthDate != null) {
      profileController.birthday.text =
          ProfileServiceV2.profile.yearBirthDate.toString() +
              '/' +
              ProfileServiceV2.profile.monthBirthDate.toString() +
              '/' +
              ProfileServiceV2.profile.dayBirthDate.toString();
    } else {
      profileController.birthday.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // profileController.setPersonalTextFeilds();
    return Column(
      children: [
        ProfileTextField(
          controller: profileController.firstname,
          hint: "نام",
        ),
        ProfileTextField(
          controller: profileController.lastname,
          hint: "نام خانوادگی",
        ),
        InkWell(
          onTap: () async {
            DatePicker.showDatePicker(context,
                maxYear: PersianDate().year!,
                initialDay: ProfileServiceV2.profile.dayBirthDate,
                initialMonth: ProfileServiceV2.profile.monthBirthDate,
                initialYear: ProfileServiceV2.profile.yearBirthDate,
                // title: Center(
                //     child: Text(
                //   'تاریخ تولد',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // )),
                onConfirm: (y, m, d) {
              profileController.birthday.text = '$y/$m/$d';
            });
          },
          child: AbsorbPointer(
            absorbing: true,
            child: ProfileTextField(
              controller: profileController.birthday,
              hint: "تاریخ تولد",
            ),
          ),
        ),
        ProfileTextField(
          controller: profileController.codemelli,
          hint: "کد ملی",
        ),
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            height: CBase().getFullHeight(context) / 12,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: profileController.isLoadingPersonal
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CBase().basePrimaryColor),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      profileController.confirmPersonalInfo();
                    },
                    child: Center(
                      child: Text(
                        "ثبت",
                        style: TextStyle(
                          fontSize: CBase().getLargefontSizeByScreen(),
                          fontFamily: CBase().fontFamily,
                          color: Color(0xffff0000),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
