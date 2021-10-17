import 'package:copapp/Controller/Controllers/EpcGroupController.dart';
import 'package:copapp/Controller/Service/EpcService.dart';
import 'package:copapp/Model/Part.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/Balance/CategoryItems.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:copapp/View/Pages/EpcPages/SubGroupPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpcGroupPage extends StatelessWidget {
  EpcGroupPage({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  EpcGroupController groupController = Get.put(EpcGroupController());
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
          title: '',
        ),
        body: GetBuilder<EpcGroupController>(
          builder: (_) {
            return groupController.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
                    ),
                  )
                : Column(
                    children: [
                      CategoryItems(
                        item: Part(
                            name: 'انتخاب دسته بندی',
                            vehiclesPersianName: EpcService
                                .selectedModelSerie!.englishName??''
                                .replaceAll(RegExp('[0-9]*'), '')
                                .replaceAll(' ', '')
                                .replaceAll('-', '')
                                .replaceAll('(IRAN)', '')),
                      ),
                      Expanded(
                          child: GridView.builder(
                        itemCount: groupController.groups.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              EpcService.selectedGroup =
                                  groupController.groups[index];
                              Get.to(() => EpcSubGroupPage());
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
                                        groupController.groups[index].imageUrl!),
                                  ),
                                  Container(
                                    height: CBase().getFullHeight(context) * 0.05,
                                    width: double.infinity,
                                    child: Center(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          groupController.groups[index]
                                                  .persianName!.isNotEmpty
                                              ? groupController
                                                  .groups[index].persianName!
                                              : groupController
                                                  .groups[index].englishName!,
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
