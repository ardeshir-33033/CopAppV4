import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/material.dart';

class NewDropDown extends StatefulWidget {
  NewDropDown({
    Key? key,
    this.boxDecoration,
    this.listDecoration,
    this.itemDecoration,
    this.listWidth,
    this.title,
    required this.value,
    required this.items,
    this.divider,
    this.onChanged,
    this.style,
    this.alignment,
    this.height,
    this.iconColor,
    this.itemDivider,
  }) : super(key: key);
  final BoxDecoration? boxDecoration, listDecoration, itemDecoration;
  final double? listWidth, height;
  final String? title;
  final TextStyle? style;
  final dynamic value;
  final Alignment? alignment;
  final List<DropdownMenuItem> items;
  final Color? iconColor;
  final Widget? divider, itemDivider;
  final void Function(dynamic)? onChanged;

  @override
  _NewDropDownState createState() => _NewDropDownState();
}

class _NewDropDownState extends State<NewDropDown> {
  GlobalKey key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            double y = key.globalPaintBounds!.top;
            if (widget.items.isNotEmpty)
              showDialog(
                  context: context,
                  barrierColor: null,
                  builder: (_) => GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: widget.height != null
                                  ? widget.items.length < 11
                                      ? y -
                                          (widget.items.length *
                                              widget.height! /
                                              2)
                                      : (10 * widget.height! / 2)
                                  : y,
                              bottom: 8),
                          child: AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            titlePadding: EdgeInsets.zero,
                            buttonPadding: EdgeInsets.zero,
                            actionsPadding: EdgeInsets.zero,
                            elevation: 0.0,
                            content: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                decoration: widget.listDecoration ??
                                    BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                width: widget.listWidth != null
                                    ? widget.listWidth
                                    : CBase().getFullWidth(context) * 0.7,
                                child: ClipRRect(
                                  borderRadius: widget.listDecoration == null
                                      ? BorderRadius.circular(0.0)
                                      : widget.listDecoration!.borderRadius!
                                          .resolve(TextDirection.rtl),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        for (int i = 0;
                                            i < widget.items.length;
                                            i++)
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // widget.items[i].onTap!;
                                                  widget.onChanged!(
                                                      widget.items[i].value);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 12),
                                                  child: Align(
                                                      alignment:
                                                          widget.alignment ??
                                                              Alignment.center,
                                                      child: widget
                                                          .items[i].child),
                                                  decoration:
                                                      widget.itemDecoration,
                                                ),
                                              ),
                                              widget.itemDivider ?? SizedBox()
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ));
          },
          child: Container(
            key: key,
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: widget.height,
            decoration: widget.boxDecoration,
            child: Row(
              children: [
                widget.alignment == null
                    ? SizedBox()
                    : widget.alignment!.x < 0
                        ? Icon(
                            Icons.arrow_drop_down,
                            color: widget.iconColor,
                          )
                        : SizedBox(),
                Expanded(
                  child: Container(
                    height: widget.height,
                    child: Align(
                      alignment: widget.alignment ?? Alignment.center,
                      child: widget.value != null
                          ? widget.items
                              .firstWhere(
                                  (element) => element.value == widget.value)
                              .child
                          : Text(
                              widget.title != null
                                  ? widget.title!
                                  : 'انتخاب کنید...',
                              style: widget.style,
                            ),
                    ),
                  ),
                ),
                widget.alignment == null
                    ? Icon(
                        Icons.arrow_drop_down,
                        color: widget.iconColor,
                      )
                    : widget.alignment!.x > 0
                        ? Icon(
                            Icons.arrow_drop_down,
                            color: widget.iconColor,
                          )
                        : SizedBox()
              ],
            ),
          ),
        ),
        widget.divider ?? SizedBox()
      ],
    );
  }
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject != null) {
      return renderObject.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}
