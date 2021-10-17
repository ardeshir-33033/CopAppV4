import 'package:copapp/Controller/Controllers/EpcPartController.dart';
import 'package:copapp/View/Components/FullCheckBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpcItemsTable extends StatelessWidget {
  

  EpcPartController partController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EpcPartController>(builder: (_) {
      return Container(
        margin: EdgeInsets.only(left: 21, right: 21, top: 18, bottom: 18),
        width: double.infinity,
        height: MediaQuery.of(context).size.width * 0.135 * 5,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: ListView.builder(
              controller: partController.tableScrollController,
              // physics: NeverScrollableScrollPhysics(),

              itemCount: partController
                  .filteredPartGroups[partController.tabController!.index]
                  .parts!
                  .length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        partController.select(partController
                            .filteredPartGroups[
                                partController.tabController!.index]
                            .parts![i]
                            .code!);
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.133,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                (partController
                                    .filteredPartGroups[
                                        partController.tabController!.index]
                                    .parts![i]
                                    .code
                                    .toString()),
                                maxLines: 1,
                                style: TextStyle(
                                  color: partController.selected[partController
                                                  .tabController!.index] !=
                                              null &&
                                          partController
                                                  .selected[partController
                                                      .tabController!.index]!
                                                  .code ==
                                              partController
                                                  .filteredPartGroups[
                                                      partController
                                                          .tabController!.index]
                                                  .parts![i]
                                                  .code
                                      ? Color(0xffff0000)
                                      : Color(0xff5e5e5e),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  partController
                                          .filteredPartGroups[partController
                                              .tabController!.index]
                                          .parts![i]
                                          .englishName ??
                                      'بدون نام',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: partController
                                                        .selected[
                                                    partController
                                                        .tabController!
                                                        .index] !=
                                                null &&
                                            partController
                                                    .selected[partController
                                                        .tabController!.index]!
                                                    .code ==
                                                partController
                                                    .filteredPartGroups[
                                                        partController
                                                            .tabController!
                                                            .index]
                                                    .parts![i]
                                                    .code
                                        ? Color(0xffff0000)
                                        : Color(0xff5e5e5e),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FullCheckBox(
                              value: partController.selected[partController
                                          .tabController!.index] !=
                                      null &&
                                  partController
                                          .selected[partController
                                              .tabController!.index]!
                                          .code ==
                                      partController
                                          .filteredPartGroups[partController
                                              .tabController!.index]
                                          .parts![i]
                                          .code,
                            ),
                          ],
                        ),
                      ),
                    ),
                    i ==
                            partController
                                    .filteredPartGroups[
                                        partController.tabController!.index]
                                    .parts!
                                    .length -
                                1
                        ? SizedBox()
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Divider(
                              height: 1,
                              color: Color(0xff5e5e5e),
                            ),
                          )
                  ],
                );
              }),
        ),
      );
    });
  }
}
