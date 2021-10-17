import 'package:copapp/Controller/Controllers/Home/CategoryController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CatItem.dart';


class CatGridView extends StatelessWidget {
  CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (_) {
      return categoryController.isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor:
          AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
        ),
      )
          : Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 10.0, right: 5),
              child: Text(
                'دسته بندی ها',
                style: TextStyle(
                  fontSize: CBase().getTitlefontSizeByScreen(),
                  shadows: [
                    Shadow(
                        color: Color(0xff5E5E5E), offset: Offset(0, -5))
                  ],
                  color: Colors.transparent,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xffff0000),
                  decorationThickness: 2,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
            ),
          ),
          for (int i = 0;
          i < categoryController.categories!.length / 3 + 1;
          i++)
            Row(
              children: <Widget>[
                for (int j = 0; j < 3; j++)
                  i * 3 + j < categoryController.categories!.length
                      ? Expanded(
                    child: CatItem(
                      category:
                      categoryController.categories![i * 3 + j],
                    ),
                  )
                      : Expanded(child: SizedBox()),
              ],
            ),
          SizedBox(
            height: 20.0,
          )
        ],
      );
    });
  }
}

// class CatGridView extends StatefulWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   int? parentCategoryId;
//   // CategoryController category = Get.put(CategoryController(scaffoldKey));
//
//   CatGridView({required this.scaffoldKey});
//
//   @override
//   _CatGridViewState createState() => _CatGridViewState();
// }
//
// class _CatGridViewState extends State<CatGridView> {
//   List<Category>? categories;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     BalanceServiceV2()
//         .GetShowAllParents()
//         .then((value) {
//       if (value.isSuccess) {
//         isLoading = false;
//         categories = (value.data as GetAllParentModel).categories;
//
//         setState(() {});
//       } else {
//         value.ShowMessage(widget.scaffoldKey);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? Center(
//             child: CircularProgressIndicator(
//               valueColor:
//                   AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
//             ),
//           )
//         : Column(
//             children: <Widget>[
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 5.0, top: 10.0, right: 5),
//                   child: Text(
//                     'دسته بندی ها',
//                     style: TextStyle(
//                       fontSize: CBase().getTitlefontSizeByScreen(),
//                       shadows: [
//                         Shadow(color: Color(0xff5E5E5E), offset: Offset(0, -5))
//                       ],
//                       color: Colors.transparent,
//                       decoration: TextDecoration.underline,
//                       decorationColor: Color(0xffff0000),
//                       decorationThickness: 2,
//                       decorationStyle: TextDecorationStyle.solid,
//                     ),
//                   ),
//                 ),
//               ),
//               for (int i = 0; i < categories!.length / 3 + 1; i++)
//                 Row(
//                   children: <Widget>[
//                     for (int j = 0; j < 3; j++)
//                       i * 3 + j < categories!.length
//                           ? Expanded(
//                               child: CatItem(
//                                 category: categories![i * 3 + j],
//                               ),
//                             )
//                           : Expanded(child: SizedBox()),
//                   ],
//                 ),
//               SizedBox(
//                 height: 20.0,
//               )
//             ],
//           );
//   }
// }
