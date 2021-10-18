import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Controllers/EpcSubGroupController.dart';
import 'package:copapp/Controller/Service/EpcService.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/Balance/CategoryItems.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'PartPage.dart';

class EpcSubGroupPage extends StatelessWidget {
  EpcSubGroupPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final EpcSubGroupController subGroupController = Get.put(EpcSubGroupController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: scaffoldKey,
          title: '',
        ),
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),
        body: GetBuilder<EpcSubGroupController>(
          builder: (_) {
            return subGroupController.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CBase().basePrimaryColor),
                    ),
                  )
                : Column(
                    children: [
                      CategoryItems(
                        item: Part(
                            name: 'انتخاب قطعه',
                            vehiclePersianName:
                                EpcService.selectedModelSerie!.englishName ??
                                    ''
                                        .replaceAll(RegExp('[0-9]*'), '')
                                        .replaceAll(' ', '')
                                        .replaceAll('-', '')
                                        .replaceAll('(IRAN)', '')),
                      ),
                      Expanded(
                          child: GridView.builder(
                        itemCount: subGroupController.subGroups.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              EpcService.selectedSubGroup =
                                  subGroupController.subGroups[index];
                              Get.to(() => EpcPartPage());
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: index % 2 == 1 ? 20 : 8,
                                  right: index % 2 == 0 ? 20 : 8,
                                  bottom: 8,
                                  top: 8),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(5.0, 12.0),
                                        blurRadius: 12)
                                  ]),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      subGroupController
                                          .subGroups[index].imageUrl!,
                                    ),
                                  ),
                                  Container(
                                    height:
                                        CBase().getFullHeight(context) * 0.05,
                                    width: double.infinity,
                                    child: Center(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          subGroupController
                                                      .subGroups[index]
                                                      .persianName!
                                                      .isNotEmpty &&
                                                  subGroupController
                                                          .subGroups[index]
                                                          .persianName !=
                                                      null
                                              ? subGroupController
                                                      .subGroups[index]
                                                      .persianName! +
                                                  ' ' +
                                                  subGroupController
                                                      .subGroups[index].code!
                                                      .replaceAll(' ', '')
                                              : subGroupController
                                                      .subGroups[index]
                                                      .englishName ??
                                                  '',
                                          style: TextStyle(
                                              fontSize: CBase()
                                                  .getTitlefontSizeByScreen(),
                                              color: CBase().textPrimaryColor),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ))
                    ],
                  );
          },
        ),
      ),
    );
  }
}
