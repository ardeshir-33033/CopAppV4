// import 'package:copapp/Utilities/Base.dart';
// import 'package:flutter/material.dart';
//
// class CustomDropdownButton extends StatefulWidget {
//   dynamic value;
//   final String? hint;
//   final List<DropdownMenuItem>? items;
//   final Function? onChanged;
//   final Color? dropdownColor;
//
//   CustomDropdownButton({
//     this.value,
//     this.hint,
//     this.items,
//     this.onChanged,
//     this.dropdownColor,
//   });
//
//   @override
//   CustomDropdownButtonState createState() => CustomDropdownButtonState();
// }
//
// class CustomDropdownButtonState<T> extends State<CustomDropdownButton> {
//   /// This is the global key, which will be used to traverse [DropdownButton]s widget tree
//   GlobalKey _dropdownButtonKey = GlobalKey();
//
//   // void openDropdown() {
//   //   GestureDetector? detector;
//   //   void searchForGestureDetector(BuildContext element) {
//   //     element.visitChildElements((element) {
//   //       if (element.widget != null && element.widget is GestureDetector) {
//   //         detector = element.widget as GestureDetector;
//   //         // return false;
//   //       } else {
//   //         searchForGestureDetector(element);
//   //       }
//   //
//   //       // return true;
//   //     });
//   //   }
//   //
//   //   searchForGestureDetector(_dropdownButtonKey.currentContext!);
//   //   assert(detector != null);
//   //
//   //   detector!.onTap!();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final dropdown = DropdownButtonHideUnderline(
//         child: DropdownButton<dynamic>(
//           key: _dropdownButtonKey,
//           value: widget.value,
//           items: widget.items,
//           dropdownColor: widget.dropdownColor,
//           isExpanded: false,
//           onChanged: (dynamic value) {
//             widget.value = value;
//             widget.onChanged!(value);
//           },
//         ));
//
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Offstage(child: dropdown),
//         FlatButton(
//             padding: EdgeInsets.all(0.0),
//             onPressed: openDropdown,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 widget.value != null
//                     ? widget.items![widget.value].child
//                     : Text(
//                   widget.hint ?? "",
//                   style: TextStyle(
//                       fontSize: CBase().getTextfontSizeByScreen(),
//                       color: CBase().textPrimaryColor,
//                       fontWeight: FontWeight.normal),
//                 ),
//                 Icon(Icons.arrow_drop_down)
//               ],
//             )),
//       ],
//     );
//   }
// }
