import 'package:get/get.dart';
import 'package:pesupay/src/presentation/controller/payment_controller.dart';
class OnlinePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlinePaymentController>(
      () => OnlinePaymentController(Get.find()),
    );
  }
}
