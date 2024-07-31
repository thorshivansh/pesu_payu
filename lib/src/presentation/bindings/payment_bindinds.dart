import 'package:get/get.dart';
import '../../../pesupay.dart';
class OnlinePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlinePaymentController>(
      () => OnlinePaymentController(Get.find(), Get.find(), Get.find()),
    );
    Get.lazyPut<PaymentConfig>(
      () => PaymentConfig(),
    );
  }
}
