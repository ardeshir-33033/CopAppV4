import 'package:copapp/Controller/Controllers/General/ChoiceWidgController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceWidget extends StatelessWidget {
  final Function? onChoose;
  final String? title;
  final List<ChoiceWidgetItem> items;
  final int value;

  ChoiceWidget(
      {Key? key,
      this.onChoose,
      required this.items,
      this.title,
      required this.value})
      : super(key: key);

  ChoiceWidgController choiceWidgController = Get.put(ChoiceWidgController());

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) throw Exception('Empty List');
    if (value == null || value < 0) throw Exception('init is not in range');
    choiceWidgController.value = value;
    return GetBuilder<ChoiceWidgController>(
      
      builder: (_) {
        return PopupMenuButton<int>(
            offset: Offset(0, choiceWidgController.offsety),
            initialValue: choiceWidgController.value,
            onSelected: (int index) {
              choiceWidgController.select(index,items);
              onChoose!(index);
            },
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: Text(
                title! + items[value].title,
                style: TextStyle(
                  color: Color(0xff707070),
                  fontFamily: 'Iransans',
                  fontSize: CBase().getTextfontSizeByScreen(),
                ),
              ),
            ),
            itemBuilder: (context) {
              final list = <PopupMenuEntry<int>>[];
              list.add(PopupMenuItem(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    title!,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontFamily: 'Iransans',
                      fontSize: CBase().getTextfontSizeByScreen(),
                    ),
                  ),
                ),
                enabled: false,
                height: MediaQuery.of(context).size.height * 0.03,
              ));
              list.add(
                PopupMenuItem(
                  enabled: false,
                  height: 1,
                  child: Divider(
                    color: Color(0xff707070),
                    height: 1,
                  ),
                ),
              );
              for (int index = 0; index < items.length; index++) {
                list.add(PopupMenuItem(
                  height: MediaQuery.of(context).size.height * 0.04,
                  value: index,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        width: MediaQuery.of(context).size.height * 0.015,
                        height: MediaQuery.of(context).size.height * 0.015,
                        decoration: BoxDecoration(
                            color: index == value ? Colors.red : Colors.grey,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height * 0.015)),
                      ),
                      Text(
                        items[index].title,textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Color(0xff707070),
                          fontFamily: 'Iransans',
                          fontSize: CBase().getTextfontSizeByScreen(),
                        ),
                      ),
                    ],
                  ),
                ));
                list.add(
                  PopupMenuItem(
                    enabled: false,
                    height: 1,
                    child: Divider(
                      color: Color(0xff707070),
                      height: 1,
                    ),
                  ),
                );
              }
              return list;
            });
      }
    );
  }
}

class ChoiceWidgetItem {
  final int? id;
  final String title;

  ChoiceWidgetItem({this.id, required this.title});
}
