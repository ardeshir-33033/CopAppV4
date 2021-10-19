import 'dart:ui';

import 'package:copapp/Controller/Controllers/ProfileController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'NumberInfoTab.dart';
import 'PersonalInfoTab.dart';

class UserInformationPage extends StatefulWidget {
  @override
  _UserInformationPageState createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ProfileController profileController = Get.put(ProfileController());
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),
        appBar: CustomAppBar(
          scaffoldKey: scaffoldKey,
        ),
        // bottomNavigationBar: Visibility(
        //   visible: !profileController.editingBool,
        //   child: FooterNavigationBar(
        //     routeName: this.runtimeType.toString(),
        //   ),
        // ),
        body: SafeArea(
          child: GetBuilder<ProfileController>(builder: (_) {
            return profileController.isLoadingMain
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xffff0000),
                      ),
                    ),
                  )
                :
                    SingleChildScrollView(
                      child: Container(
                        height: CBase().getFullHeight(context),
                        child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: CBase().getFullHeight(context) / 18,
                              ),
                              profileController.uploadImage == false
                                  ? Container(
                                      height: CBase().getFullHeight(context) / 4.2,
                                      width: CBase().getFullWidth(context) / 2,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 18,
                                        child: ClipOval(
                                            child: profileController
                                                        .profileData.imageAddress !=
                                                    null
                                                ? Image.network(
                                                    'https://copserver.dinavision.org/' +
                                                        profileController
                                                            .profileData
                                                            .imageAddress!,
                                                  )
                                                : Image.asset("images/user.png")),
                                      ),
                                    )
                                  : AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        height: CBase().getFullHeight(context) / 3,
                                        width: CBase().getFullWidth(context) / 2,
                                        child: ClipOval(
                                          child: Image.file(
                                            profileController.image!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.dialog(
                                    WillPopScope(
                                      onWillPop: () async {
                                        if (profileController.isUploading)
                                          return false;
                                        else {
                                          Get.back();
                                          return false;
                                        }
                                      },
                                      child:
                                          GetBuilder<ProfileController>(builder: (_) {
                                        return profileController.isUploading
                                            ? Container(
                                                width: CBase().getFullWidth(context),
                                                height: CBase().getFullHeight(context),
                                                color: Colors.transparent,
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<Color>(
                                                            Color(0xffff0000)),
                                                  ),
                                                ),
                                              )
                                            : AlertDialog(
                                                elevation: 0,
                                                backgroundColor: Colors.transparent,
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      InkWell(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius.circular(
                                                                      15)),
                                                          onTap: () {
                                                            profileController
                                                                .getPicture(2);
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius:
                                                                      BorderRadius.vertical(
                                                                          top: Radius
                                                                              .circular(
                                                                                  15))),
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical: 12,
                                                                      horizontal: 10),
                                                              child: Text(
                                                                  "انتخاب از گالری"))),

                                                      // Divider(
                                                      //   height: 1,
                                                      //   thickness: 1,
                                                      //   color: CBase().borderPrimaryColor,
                                                      // ),
                                                      InkWell(
                                                          onTap: () {
                                                            profileController
                                                                .getPicture(1);
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                              ),
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical: 12,
                                                                      horizontal: 10),
                                                              child:
                                                                  Text("گرفتن عکس"))),

                                                      InkWell(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  bottom:
                                                                      Radius.circular(
                                                                          15)),
                                                          onTap: () {
                                                            profileController
                                                                .removeProfilePic();
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius:
                                                                      BorderRadius.vertical(
                                                                          bottom: Radius
                                                                              .circular(
                                                                                  15))),
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical: 12,
                                                                      horizontal: 10),
                                                              child: Text("حذف عکس")))
                                                    ],
                                                  ),
                                                ),
                                              );
                                      }),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "ویرایش عکس",
                                        style: TextStyle(
                                          fontSize: CBase().mtextfontSize,
                                        ),
                                      ),
                                    ),
                                    SvgPicture.asset("images/pencil.svg"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: CBase().getFullHeight(context) / 15,
                              ),
                              Expanded(
                                flex: 5,
                                child: DefaultTabController(
                                    initialIndex: 1,
                                    length: 2,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: CBase().getFullHeight(context) / 15,
                                          margin: EdgeInsets.symmetric(horizontal: 15),
                                          child: TabBar(
                                              controller: tabController,
                                              indicator: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.transparent,
                                              ),

                                              // indicatorSize: TabBarIndicatorSize.tab,
                                              unselectedLabelColor: Color(0xff5E5E5E),
                                              labelColor: Color(0xffff0000),
                                              // indicatorColor: Colors.white,
                                              unselectedLabelStyle: TextStyle(
                                                  color: Color(0xff5E5E5E),
                                                  fontFamily: CBase().fontFamily),
                                              labelStyle: TextStyle(
                                                  fontFamily: CBase().fontFamily),
                                              tabs: [
                                                Tab(
                                                  child: AnimatedContainer(
                                                    duration:
                                                        Duration(milliseconds: 200),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(10.0),
                                                        // boxShadow: [
                                                        //   BoxShadow(
                                                        //       color: Colors.black12,
                                                        //       spreadRadius: 3.0,
                                                        //       blurRadius: 5.0)
                                                        // ],
                                                        color: Colors.white),
                                                    alignment: Alignment.center,
                                                    width:
                                                        CBase().getFullWidth(context) /
                                                            2,
                                                    child: Text("اطلاعات کاربری"),
                                                  ),
                                                ),
                                                Tab(
                                                  child: AnimatedContainer(
                                                    duration:
                                                        Duration(milliseconds: 200),
                                                    decoration: BoxDecoration(
                                                        // boxShadow: [
                                                        //   BoxShadow(
                                                        //       color: Colors.black12,
                                                        //       spreadRadius: 3.0,
                                                        //       blurRadius: 5.0)
                                                        // ],
                                                        borderRadius:
                                                            BorderRadius.circular(10.0),
                                                        color: Colors.white),
                                                    alignment: Alignment.center,
                                                    width:
                                                        CBase().getFullWidth(context) /
                                                            2,
                                                    child: Text("اطلاعات تماس"),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            // height: CBase().getFullHeight(context) / 3,
                                            child: TabBarView(
                                                controller: tabController,
                                                children: [
                                                  PersonalInfoTab(),
                                                  NumberInfoTab(),
                                                ]),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                      ),
                    );

          }),
        ),
      ),
    );
  }
}
