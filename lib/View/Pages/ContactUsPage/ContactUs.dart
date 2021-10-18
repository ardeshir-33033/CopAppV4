import 'dart:io';

import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:copapp/View/Components/General/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  bool initPicker = false;
  File? chosen;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: scaffoldKey,
        ),
        drawer: AppDrawer(
          scaffoldKey: scaffoldKey,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: CBase().getFullWidth(context) - 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: CBase().getFullWidth(context) * 0.287,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: SvgPicture.asset('images/copapp_farsi.svg'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ('آدرس : تهران - خیابان وزراء کوچه ششم پلاک 14 واحد 10')
                              .toPersianDigit(),
                          style: TextStyle(
                              color: Color(0xff5e5e5e),
                              fontSize: CBase().getTextfontSizeByScreen() * 1.2),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ('آدرس دفتر فروش : تهران - خیابان ملت کوچه اشراقی پلاک 17 واحد 2')
                              .toPersianDigit(),
                          style: TextStyle(
                              color: Color(0xff5e5e5e),
                              fontSize: CBase().getTextfontSizeByScreen() * 1.2),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: Colors.black,
                        height: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ('تماس رایگان با : 3516-021').toPersianDigit(),
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Color(0xff313131),
                                fontWeight: FontWeight.bold,
                                fontSize: CBase().getTitlefontSizeByScreen()),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              launch('tel://0213516');
                            },
                            backgroundColor: Color(0xff65D36E),
                            child: Icon(Icons.call),
                            mini: true,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: FittedBox(
                              child: Text(
                                ('داخلی : 111 - 211').toPersianDigit(),
                                style: TextStyle(
                                    color: Color(0xff5e5e5e),
                                    fontWeight: FontWeight.bold,
                                    fontSize: CBase().getTextfontSizeByScreen()),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: FittedBox(
                              child: Text(
                                ('| هفت روز هفته، 24 ساعت شبانه روز پاسخگویی شما هستیم.')
                                    .toPersianDigit(),
                                style: TextStyle(
                                    color: Color(0xff5e5e5e),
                                    fontSize: CBase().getTextfontSizeByScreen()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: CBase().getFullWidth(context) - 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ('فرم تماس').toPersianDigit(),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Color(0xff5e5e5e),
                              fontWeight: FontWeight.bold,
                              fontSize: CBase().getTitlefontSizeByScreen()),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ('برای پیگیری یا سوال درباره سفارش بهتر است از فرم زیر استفاده کنید')
                              .toPersianDigit(),
                          style: TextStyle(
                              color: Color(0xff5e5e5e),
                              fontSize: CBase().getTextfontSizeByScreen()),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: double.infinity,
                          child: TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              filled: true,
                              fillColor: Color(0xfff9f9f9),
                              hintText: 'نام و نام خانوادگی',
                              hintStyle: TextStyle(
                                  color: Color(0xff5e5e5e),
                                  fontSize: CBase().getTextfontSizeByScreen()),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: double.infinity,
                          child: TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              filled: true,
                              fillColor: Color(0xfff9f9f9),
                              hintText: 'تلفن تماس',
                              hintStyle: TextStyle(
                                  color: Color(0xff5e5e5e),
                                  fontSize: CBase().getTextfontSizeByScreen()),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: double.infinity,
                          child: TextField(
                            minLines: 4,
                            maxLines: 10,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              filled: true,
                              fillColor: Color(0xfff9f9f9),
                              hintText: 'متن پیام',
                              hintStyle: TextStyle(
                                  color: Color(0xff5e5e5e),
                                  fontSize: CBase().getTextfontSizeByScreen()),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () {
                          initPicker = true;
                          showDialog(
                              context: context,
                              builder: (_) {
                                return Dialog(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: CBase().getFullWidth(context) / 2,
                                    height:
                                        CBase().getFullHeight(context) / 15 * 2 +
                                            21,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _pick(1);
                                          },
                                          child: Container(
                                            height:
                                                CBase().getFullHeight(context) /
                                                    15,
                                            width:
                                                CBase().getFullWidth(context) / 2,
                                            child: Row(
                                              children: [
                                                Text(
                                                  ('عکس').toPersianDigit(),
                                                  style: TextStyle(
                                                      color: Color(0xff5e5e5e),
                                                      fontSize: CBase()
                                                              .getTextfontSizeByScreen() *
                                                          1.2),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _pick(2);
                                          },
                                          child: Container(
                                            height:
                                                CBase().getFullHeight(context) /
                                                    15,
                                            width:
                                                CBase().getFullWidth(context) / 2,
                                            child: Row(
                                              children: [
                                                Text(
                                                  ('ویدیو').toPersianDigit(),
                                                  style: TextStyle(
                                                      color: Color(0xff5e5e5e),
                                                      fontSize: CBase()
                                                              .getTextfontSizeByScreen() *
                                                          1.2),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: double.infinity,
                          height: (CBase().getFullWidth(context) - 140) * 0.177,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0xfff9f9f9)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ('آپلود عکس یا ویدیو').toPersianDigit(),
                                style: TextStyle(
                                    color: Color(0xff5e5e5e),
                                    fontSize: CBase().getTextfontSizeByScreen()),
                              ),
                              initPicker
                                  ? Icon(
                                      chosen != null
                                          ? Icons.check
                                          : Icons.close,
                                      color: Color(0xff5e5e5e),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pick(int i) async {
    chosen = null;
    PickedFile file;
    if (i == 1) {
      file = (await picker.getImage(source: ImageSource.gallery))!;
    } else {
      file = (await picker.getVideo(source: ImageSource.gallery))!;
    }
    chosen = File.fromUri(Uri.parse(file.path));
    Navigator.pop(context);

    setState(() {});
  }
}
