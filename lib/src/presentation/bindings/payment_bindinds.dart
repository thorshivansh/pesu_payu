import 'package:get/get.dart';
import 'package:pesu_payu/src/config/payments_config.dart';
import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
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
