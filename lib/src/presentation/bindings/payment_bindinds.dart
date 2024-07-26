import 'package:get/get.dart';
import 'package:pesua/app/modules/student_modules/online_payment/config.dart';
import '../controller/payment_controller.dart';
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
