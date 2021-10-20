import 'package:copapp/Api/ResponseModel.dart';
import 'package:copapp/Controller/Service/InquiryService.dart';
import 'package:get/get.dart';

class InquiryCartController extends GetxController {
  bool isLoading = true;
  bool isSubmiting = false;
  @override
  void onInit() {
    super.onInit();
    InquiryService().getInquiry().then((value) {
      if (value.isSuccess) {
        isLoading = false;
        update();
      } else {
        value.showMessage();
      }
    });
  }

  submitPreOrder() async {
    isSubmiting = true;
    update(['sub']);
    ResponseModel res = await InquiryService().generateManualPreOrder();
    isSubmiting = false;
    update(['sub']);
    res.showMessage();
    if (res.isSuccess) {
      InquiryService.inquiryCart!.details = [];
      update();
      InquiryService().getInquiry();
    }
  }
}
