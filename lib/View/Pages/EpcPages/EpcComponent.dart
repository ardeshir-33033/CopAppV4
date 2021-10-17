import 'package:copapp/Controller/Controllers/EpcPartController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/NewDropDown.dart';
import 'package:copapp/View/Pages/EpcPages/ItemsTable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpcComponent extends StatelessWidget {
  int? selected;

  EpcPartController partController = Get.find();
  TransformationController transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    return partController.isLoading
        ? Center(
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
          ))
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              partController.partGroups[partController.tabController!.index]
                          .group!.partCategoryValues!.length <=
                      1
                  ? SizedBox()
                  : Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      height: 60,
                      width: CBase().getFullWidth(context),
                      child: NewDropDown(
                        height: 50,
                        alignment: Alignment.centerRight,
                        title: 'انتخاب فیلتر',
                        style: TextStyle(
                          fontSize: CBase().getTextfontSizeByScreen(),
                          fontFamily: 'IRANSans',
                          color: CBase().textPrimaryColor,
                        ),
                        boxDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        listDecoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 5)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        iconColor: CBase().textPrimaryColor,
                        listWidth: (CBase().getFullWidth(context) - 40) / 3 * 2,
                        value: partController
                            .dropValue[partController.tabController!.index],
                        items: partController
                            .dropItems[partController.tabController!.index],
                        onChanged: (v) {
                          partController.selectedFilter(v);
                          partController
                              .init(partController.tabController!.index);
                          partController.setFilter();
                        },
                      ),
                    ),
              Container(
                width: CBase().getFullWidth(context),
                height:
                    partController.height[partController.tabController!.index],
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GetBuilder<EpcPartController>(builder: (_) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: partController
                            .height[partController.tabController!.index],
                        maxWidth: CBase().getFullWidth(context)),
                    child: GestureDetector(
                      onTapDown: (d) {
                        partController.setZooming(true);
                      },
                      onTapUp: (d) {
                        partController.setZooming(false);
                      },
                      child: InteractiveViewer(
                        panEnabled: true,
                        minScale: 1.0,
                        maxScale: 5.0,
                        // transformationController: transformationController,
                        onInteractionUpdate: (d) {
                          // partController.localScale = transformationController
                          //     .value
                          //     .getMaxScaleOnAxis();
                        },
                        onInteractionEnd: (d) {


                          partController.setZooming(false);
                        },
                        onInteractionStart: (d) {
                          partController.setZooming(true);
                        },
                        child: Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(
                              width: CBase().getFullWidth(context),
                              height: partController
                                  .height[partController.tabController!.index],
                              child: Image.network(partController
                                  .filteredPartGroups[
                                      partController.tabController!.index]
                                  .imageUrl!),
                            ),
                            for (int i = 0;
                                i <
                                    partController
                                        .filteredPartGroups[
                                            partController.tabController!.index]
                                        .imageCoordinates!
                                        .length;
                                i++)
                              Positioned(
                                width: partController
                                        .filteredPartGroups[
                                            partController.tabController!.index]
                                        .imageCoordinates![i]
                                        .srcwidth! /
                                    partController.m[0],
                                height: partController
                                        .filteredPartGroups[
                                            partController.tabController!.index]
                                        .imageCoordinates![i]
                                        .srcheight! /
                                    partController.m[0],
                                left: partController
                                        .filteredPartGroups[
                                            partController.tabController!.index]
                                        .imageCoordinates![i]
                                        .srcleft! /
                                    partController.m[0],
                                top: partController
                                        .filteredPartGroups[
                                            partController.tabController!.index]
                                        .imageCoordinates![i]
                                        .srcTop! /
                                    partController.m[0],
                                child: Container(
                                  width: partController
                                          .filteredPartGroups[partController
                                              .tabController!.index]
                                          .imageCoordinates![i]
                                          .srcwidth! /
                                      partController.m[0],
                                  height: partController
                                          .filteredPartGroups[partController
                                              .tabController!.index]
                                          .imageCoordinates![i]
                                          .srcheight! /
                                      partController.m[0],
                                  child: InkWell(
                                    onTap: () {
                                      partController.select(partController
                                          .filteredPartGroups[partController
                                              .tabController!.index]
                                          .imageCoordinates![i]
                                          .code!);
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: partController.selected[partController
                                                          .tabController!
                                                          .index] !=
                                                      null &&
                                                  partController
                                                          .selected[partController
                                                              .tabController!
                                                              .index]!
                                                          .code ==
                                                      partController
                                                          .filteredPartGroups[
                                                              partController.tabController!.index]
                                                          .imageCoordinates![i]
                                                          .code
                                              ? Colors.red
                                              : Colors.grey,
                                          width: 0.75)),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              EpcItemsTable()
            ],
          );
  }

  // void goToNewPage(String src) {
  //   EpcService.selectedCode = 'null';
  //   isLoading = true;
  //   setState(() {});
  //   EpcService().getPartMap(widget.partMapId, srcnum: src).then((value) {
  //     partMap = value.data;
  //     setWidthHeight().then((v) {
  //       getInfo();
  //     });
  //   });
  //   widget.partSelected();
  // }
}
