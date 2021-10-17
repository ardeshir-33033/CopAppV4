import 'package:copapp/Controller/Controllers/HomePageController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'SelectCarItemWidget.dart';
import 'SelectItemWidget.dart';

class SelectCarWidget extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: '2',
        builder: (_) {
          return Container(
            child: homeController.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CBase().basePrimaryColor),
                    ),
                  )
                : Column(
                    children: [
                      AnimatedContainer(
                        margin: EdgeInsets.only(
                            bottom: CBase().getFullHeight(context) / 30),
                        duration: Duration(milliseconds: 400),
                        height: homeController.isuzuApear
                            ? MediaQuery.of(context).size.height * 0.03
                            : 0,
                        child: Image.asset('images/Isuzu.png'),
                      ),
                      Visibility(
                        visible: !homeController.isLoading,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          height: homeController.titleHeight,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 0.0),
                              child: Text(
                                'انتخاب خودرو',
                                style: TextStyle(
                                  fontSize: CBase().getTitlefontSizeByScreen(),
                                  shadows: [
                                    Shadow(
                                        color: Color(0xff5E5E5E),
                                        offset: Offset(0, -5))
                                  ],
                                  color: Colors.transparent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: homeController.carNotSelected
                                      ? Color(0xffff0000)
                                      : Color(0xffff0000),
                                  decorationThickness: 2,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        height: homeController.carNotSelected ? 32 : 0,
                      ),
                      AnimatedSwitcher(
                          duration: Duration(milliseconds: 400),
                          child: homeController.carNotSelected
                              ? notSelected(context)
                              : selected(context)),
                    ],
                  ),
          );
        });
  }

  Widget selected(BuildContext context) {
    return SelectedCarItemWidget(
      width: MediaQuery.of(context).size.width - 40,
      height: MediaQuery.of(context).size.height * 0.16,
      cars: homeController.cars,
      year: homeController.selectedYear,
      onCancel: () {
        homeController.onCancelCar();
      },
    );
  }

  Widget notSelected(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (int i = homeController.cars.length - 1; i >= 0; i--)
            CarItemWidget(
              year: homeController.years[i].toPersianDigit(),
              ontap: () {
                homeController.onSelectCar(i);
              },
              car: homeController.cars[i],
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.height * 0.2,
            )
        ],
      ),
    );
  }
}
