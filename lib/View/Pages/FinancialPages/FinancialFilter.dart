import 'package:copapp/Controller/Controllers/FinFilterController.dart';
import 'package:copapp/Model/Order/OrderFilterModel.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/FullCheckBox.dart';
import 'package:copapp/View/Components/General/SearchInList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinancialFilter extends StatelessWidget {
  final Function? onSelect;
  int? id;
  final bool back;
  final OrdersFilterModel? filters;

  FinancialFilter(
      {Key? key, this.onSelect, this.id, this.filters, this.back = false})
      : super(key: key);

  FinFilterController filterController = Get.put(FinFilterController());

  @override
  Widget build(BuildContext context) {
    filterController.doInits(id, filters);
    return GetBuilder<FinFilterController>(builder: (_) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: SearchInList(
              key: ValueKey(id),
              list: filterController.allItems,
              initFocus: back,
              noTextEmpty: id == 2 ? true : false,
              getResult: (result) {
                filterController.getResult(result);
              },
            ),
          ),
          Expanded(
              child: filters == null ||
                      (id == 1 && filterController.items.isEmpty) ||
                      (filterController.items.isEmpty &&
                          filterController.allItems.isEmpty)
                  ? Center(child: Text('اطلاعاتی برای نمایش وجود ندارد'))
                  : filterController.items.isEmpty &&
                          filterController.allItems.isNotEmpty
                      ? Center(
                          child: Text('برای مشاهده موارد سرچ کنید'),
                        )
                      : ListView.builder(
                          itemCount: filterController.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: index == 0 ? 20 : 0,
                                  bottom:
                                      index == filterController.items.length - 1
                                          ? 20
                                          : 0),
                              padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: index == 0 ? 15 : 10,
                                  bottom:
                                      index == filterController.items.length - 1
                                          ? 20
                                          : 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(index == 0 ? 10 : 0),
                                    bottom: Radius.circular(index ==
                                            filterController.items.length - 1
                                        ? 10
                                        : 0)),
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 10.0, bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            margin: EdgeInsets.only(left: 15),
                                            child: FullCheckBox(
                                              value: filterController
                                                  .values[index],
                                            ),
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                  filterController.items[index],
                                                  style: TextStyle(
                                                    color: CBase()
                                                        .textPrimaryColor,
                                                    fontSize: CBase()
                                                        .getTitlefontSizeByScreen(),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      filterController.onTap(index,id,filters);
                                      String heading = filterController.items[index];
                                      onSelect!(heading, filterController.selected);
                                    },
                                  ),
                                  Divider(
                                    color: CBase().textLightPrimaryColor,
                                    thickness: 1,
                                    height: 1,
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
        ],
      );
    });
  }
}
