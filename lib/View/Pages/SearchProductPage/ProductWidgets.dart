import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Model/ProductImage.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class ProductWidgets {
  void showDialog(BuildContext context, GlobalKey<ScaffoldState> scaffold,
      List<ProductImage> images) {
    if (images.length == 0) {
      ResponseModel result = ResponseModel();
      result.isSuccess = false;
      result.message = "تصویری موجود نیست";

      result.showMessage();

      return;
    }
    slideDialog.showSlideDialog(
      context: context,
      child: Flexible(
        fit: FlexFit.tight,
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(images[index].path ?? ""),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              minScale: 0.4,
              maxScale: 0.8,
              heroAttributes:
                  PhotoViewHeroAttributes(tag: images[index].path!),
            );
          },
          itemCount: images.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 200.0,
              height: 200.0,
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(CBase().basePrimaryColor),
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
          backgroundDecoration: BoxDecoration(color: Colors.white),
          pageController: PageController(),
          onPageChanged: (index) {
            //
          },
        ),
      ),
    );
  }
}
