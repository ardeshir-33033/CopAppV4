import 'package:copapp/AppModel/MultiBalance/Part.dart';
import 'package:copapp/Controller/Service/BalanceExtension.dart';
import 'package:copapp/Model/Balance/Filter.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CategoryItems extends StatefulWidget {
  CategoryItems({
    required this.item,
  });

  final Part? item;

  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  List<Filter> filters = [];

  @override
  void initState() {
    super.initState();
    filters = BalanceExtensions().getFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: CBase().getFullHeight(context) / 5.4 - 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // InkWell(
          //   child:
          Container(
            height: CBase().getFullHeight(context) / 19,
            // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            margin: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Color(0xffff0000),
                width: 2,
              )),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        // "",
                        "${nameGenerator(widget.item)}",
                        style: TextStyle(
                            fontSize: CBase().getTitlefontSizeByScreen(),
                            color: CBase().textPrimaryColor,
                            letterSpacing: -0.065,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.item!.vehiclePersianName!.toPersianDigit(),
                  // PersianNumbers.toPersian(widget.item.vehiclesPersianName),
                  style: TextStyle(
                    fontSize: CBase().getTitlefontSizeByScreen() * 0.95,
                    color: CBase().textPrimaryColor,
                    letterSpacing: -0.065,
                  ),
                ),
              ],
            ),
          ),
          //   onTap: () {
          //     // widget.onCloseCallback();
          //   },
          // ),
        ],
      ),
    );
  }

  String? nameGenerator(Part? item) {
    if (widget.item!.family == null
    //  && widget.item!.join == null
     ) {
      return widget.item!.name ?? "--";
    }
    if (widget.item!.family != null) {
      if (widget.item!.familyTitle == "") {
        return "تایتل فامیلی وارد نشده";
      } else {
        return widget.item!.familyTitle;
      }
    }
    // if (widget.item!.join != null) {
    //   if (widget.item!.joinTitle == "") {
    //     return "تایتل جوین وارد نشده";
    //   } else {
    //     return widget.item!.joinTitle;
    //   }
    // }
  }
}
