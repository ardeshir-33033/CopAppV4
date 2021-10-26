import 'package:copapp/Controller/Controllers/Balance/BalanceItemController.dart';
import 'package:copapp/Controller/Controllers/Cart/CartController.dart';
import 'package:copapp/Controller/Controllers/Home/CategoryController.dart';
import 'package:copapp/Controller/Controllers/HomePageController.dart';
import 'package:copapp/Controller/Controllers/Inquiry/InquiryController.dart';
import 'package:copapp/Controller/Controllers/Inquiry/InquiryItemController.dart';
import 'package:copapp/Controller/Service/UserServiceV2.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Components/General/MainFooter.dart';
import 'package:copapp/View/Components/General/PointCounter.dart';
import 'package:copapp/View/Components/General/SearchBox.dart';
import 'package:copapp/View/Components/HomeWidgets/CatGridView.dart';
import 'package:copapp/View/Components/SelectCar/SelectCarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Controllers/Cart/CartLengthController.dart';
import '../../Controller/Controllers/General/ScoreService.dart';

// ignore: must_be_immutable
class HomePageV4 extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  CartLengthController cartLengthController = Get.put(CartLengthController());
  CategoryController categoryController = Get.put(CategoryController());
  CartController cartController = Get.put(CartController());
  ScoreService scoreServiceController = Get.put(ScoreService());
  BalanceItemController balanceItemController =
      Get.put(BalanceItemController());
  InquiryItemController inquiryItemController =
      Get.put(InquiryItemController());
  InquiryCartController inquiryController = Get.put(InquiryCartController());

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () => homeController.backPress(),
        child: Scaffold(
          key: homeController.scaffoldKey,
          bottomNavigationBar: MainFooterNavigation(
            currentPage: this.runtimeType.toString(),
          ),
          drawer: AppDrawer(
            scaffoldKey: homeController.scaffoldKey,
          ),
          appBar: CustomAppBar(
            scaffoldKey: homeController.scaffoldKey,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 20.0,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: CBase().getFullWidth(context),
                              margin: EdgeInsets.only(bottom: 16),
                              child: UserServiceV2.user!.fullName!.length < 20
                                  ? Text(UserServiceV2.user?.fullName ?? "",
                                      style: TextStyle(
                                          fontSize: CBase()
                                                  .getTextfontSizeByScreen() *
                                              1.5))
                                  : Text(
                                      UserServiceV2.user!.fullName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: CBase()
                                                  .getTextfontSizeByScreen() *
                                              1.2),
                                    ),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: PointCounter()),
                          ],
                        ),
                      ),
                    ),
                    GetBuilder<HomeController>(
                        id: 'animate',
                        builder: (_) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            height: homeController.carNotSelected
                                ? MediaQuery.of(context).size.height / 5
                                : MediaQuery.of(context).size.height / 15,
                          );
                        }),
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: GetBuilder<HomeController>(
                              id: 'animate',
                              builder: (_) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5.0),
                                      child: SelectCarWidget(),
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 400),
                                      height: homeController.carNotSelected
                                          ? 0.0
                                          : null,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                        ),
                                        child: CatGridView(),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 70, 20, 15),
                    child: Column(
                      children: [
                        GetBuilder<HomeController>(
                            id: 'animate',
                            builder: (_) {
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                height: homeController.carNotSelected
                                    ? MediaQuery.of(context).size.height / 9
                                    : 0,
                              );
                            }),
                        SizedBox(
                          height: 10.0,
                        ),
                        SearchboxV2(
                          scaffoldKey: homeController.scaffoldKey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
