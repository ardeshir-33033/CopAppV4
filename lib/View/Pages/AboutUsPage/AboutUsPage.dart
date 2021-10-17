import 'package:copapp/Controller/Controllers/AboutUsController.dart';
import 'package:copapp/Utilities/Base.dart';
import 'package:copapp/View/Components/General/AppDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class AboutUsPage extends StatelessWidget {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AboutUsController aboutUsController = Get.put(AboutUsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsController>(builder: (_) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: CBase().getFullWidth(context),
            height: CBase().getFullHeight(context),
            child: Image.asset(
              'images/about.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  color: aboutUsController.startAnimation
                      ? Colors.black.withOpacity(0.7)
                      : Colors.transparent,
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  height: aboutUsController.startAnimation
                      ? 0.0
                      : CBase().getFullHeight(context),
                  width: CBase().getFullWidth(context),
                ),
                Container(
                  width: CBase().getFullWidth(context),
                  height: CBase().getFullHeight(context),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      key: scaffoldKey,
                      backgroundColor: Colors.transparent,
                      drawer: AppDrawer(
                        scaffoldKey: scaffoldKey,
                      ),
                      body: SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      scaffoldKey.currentState!
                                          .openDrawer();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Icon(
                                        Icons.menu,
                                        color: Color(0xffFFD400),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Container(
                                      height: 46,
                                        width:
                                            CBase().getFullWidth(context) * 0.5,
                                        child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: SvgPicture.asset(
                                                "images/about_logo.svg"))),
                                  ),
                                  Opacity(
                                    opacity: 0,
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Icon(
                                        Icons.menu,
                                        color: Color(0xffFFD400),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: CBase().getFullWidth(context) * 0.7,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        'راه حلی امروزی تر برای خرید قطعات یدکی',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: SingleChildScrollView(
                                    controller:
                                        aboutUsController.scrollController,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          width:
                                              CBase().getFullWidth(context) - 40,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Text(
                                            'توسعه اینترنت روش‌های خرید ما را به کلی دگرگون کرده است. منافع موجود در خرید اینترنتی هر روز تعداد بیشتری از مردم را به تجربه آن و ایجاد تغییر در الگوهای متداول خرید ترغیب می‏‌کند. امروز دیگر افراد این روش خرید را بیشتر منطبق بر شرایط زندگی مدرن می‏‏‏‌بینند. ویژگی‏‏‏‌ها و طبیعت خرید اینترنتی با روحیات و نیازهای رو به رشد ما هماهنگ‏‏‌تر شده است. همه سخت در حال تلاش برای پیشرفت‏‏‌های شخصی و جمعی خود هستیم.' +
                                                '\n' +
                                                'امروزه بهای اوقات فراغت ما با وجود مشغله‏‌های روزانه بسیار گرانبها‌تر شده است. همه ما برای این اوقات برنامه ریزی فشرده‏‌تری داریم. دیگر صرف زمان‌هایی نسبتا طولانی در فعالیت‏‌های نه‌چندان با اهمیت مانند خرید و سفرهای شهری برای بسیاری از انسان‌ها اولویت خود را از دست داده است. هوشمندی انسان‌ها، آنها را مجاب می‏‌کند که با تغییر در الگوهای قدیمی و نا‏کارآمد زندگی، هوشمندانه‏‌تر و امروزی‏‌تر زندگی کنند. صرف اوقات فراغت برای تفریح، آموزش، ورزش، لذت بردن از علایق شخصی و رفع خستگی‏‏‌های روزانه اولویت بیشتری نسبت به فعالیت‌‏‏‏های وقت‌گیر و در عین حال کم اهمیت‏‏‏‌تر مانند خرید کردن دارند.' +
                                                '\n' +
                                                'امروز دیگر برای بیشتر نیازهای روزمره راه‏ حل‏‏‏‌های جدیدتری وجود دارد، از جمله برای انتخاب و خرید کالا. دیگر کمتر کسی برای خرید کالا، بدون تحقیق و بررسی دقیق اقدام می‏‌کند.' +
                                                '\n' +
                                                'مشتریان پیشاپیش و قبل از خرید از حق انتخاب گسترده خود و اطلاعات موجود نهایت استفاده را می‏‌برند. مشتری در دنیای امروز حق انتخاب بیشتری را طلب می‏‌کند و مایل است دقیق‏‌تر و با قطعیت بیشتری انتخاب کند. زندگی امروزی بی‏‌گمان خرید به رو‏‌ش‌های نو‏تر، هوشمندانه‏‌تر و البته لذت‏‏ بخش‏‌تری را می‏‌طلبد. از همین روست که هر روز به تعداد استفاده‏ کنندگان سرویس‌های اینترنتی و مشتریان فروشگاه‏‏‌‏های اینترنتی افزوده می‌‏‏شود.',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          width:
                                              CBase().getFullWidth(context) - 40,
                                          child: Text(
                                            'دیجی‌کالا مرجع تخصصی نقد و بررسی و فروش اینترنتی کالا در ایران است. گروه‏‏‌های مختلف کالا مانند کالای دیجیتال، لوازم خانگی، لوازم شخصی، فرهنگ و هنر و ورزش و سرگرمی با تنوعی بی‌نظیر در دیجی‌کالا عرضه می‏‏‏‌شوند. دیجی‌کالا با در اختیار داشتن سهم عمده‏‌ای از بازار عرضه اینترنتی کالا در ایران با تنوعی بسیار بالا از برندهای مختلف، در همراهی مشتریان در فرآیند خرید و حفظ جایگاه بی‏‏‏‌طرفانه در میان آنها، نهایت تلاش خود را می‌‏‏کند. کاربران و مشتریان دیجی‌کالا می‏‏‌توانند با حق انتخابی بسیار بالا و با دریافت اطلاعاتی کامل برای انتخاب درست کالای مورد نظر خود، وب سایت دیجی‌کالا را بررسی کنند و با حداکثر اطمینان کالای خود را انتخاب و خرید کنند. همواره بهترین انتخاب و بهترین خدمات، شایسته مشتری دیجی‌کالاست.',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          width:
                                              CBase().getFullWidth(context) - 40,
                                          decoration: BoxDecoration(
                                            color: Color(0xfff9f9f9),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    width: CBase().getFullWidth(
                                                            context) *
                                                        0.287,
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: SvgPicture.asset(
                                                          'images/copapp_farsi.svg'),
                                                    ),
                                                  ),
                                                  FloatingActionButton(
                                                      backgroundColor:
                                                          Colors.white,
                                                      mini: true,
                                                      child: Icon(
                                                        Icons.arrow_upward,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        // scrollController.animateTo(offset, duration: duration, curve: curve)
                                                        aboutUsController
                                                            .scrollController!
                                                            .animateTo(
                                                                aboutUsController
                                                                    .scrollController!
                                                                    .position
                                                                    .minScrollExtent,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        700),
                                                                curve: Curves
                                                                    .decelerate);
                                                      })
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  'آدرس : تهران - خیابان وزراء - کوچه ششم پلاک 14 واحد 10'
                                                      .toPersianDigit(),
                                                  style: TextStyle(
                                                      color: Color(0xff5e5e5e),
                                                      fontSize: CBase()
                                                              .getTextfontSizeByScreen() *
                                                          1.2),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                                height: 1,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  'تلفن پشتیبانی : 3516-021'
                                                      .toPersianDigit(),
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Color(0xff313131),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: CBase()
                                                          .getTitlefontSizeByScreen()),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  'هفت روز هفته، 24 ساعت شبانه روز پاسخگویی شما هستیم.'
                                                      .toPersianDigit(),
                                                  style: TextStyle(
                                                      color: Color(0xff5e5e5e),
                                                      fontSize: CBase()
                                                              .getTextfontSizeByScreen() *
                                                          1.2),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
