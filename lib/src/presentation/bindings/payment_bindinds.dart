import 'package:get/get.dart';
import '../controller/payment_controller.dart';
class OnlinePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlinePaymentController>(
      () => OnlinePaymentController(Get.find(), Get.find()),
    );
  }
}
