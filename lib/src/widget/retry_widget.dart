import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
import 'package:pesu_payu/src/utils/my_button.dart';

// import 'package:get/get.dart';

class ApiCallState<T> {
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var data = Rxn<T>();

  void reset() {
    isLoading(false);
    hasError(false);
    errorMessage('');
    data.value = null;
  }
}



class RetryException extends GetView<OnlinePaymentController> {
  const RetryException({
    super.key,
    required this.onTap,
    this.message,
  });

  final Function() onTap;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         const Icon(
         Icons.error_outline_rounded,
          size: 50,
          color: Colors.red,
        ),
        Center(
          child: Text(
            message ?? '',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        const Text(
          'Please Try again',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        // const SizedBox(
        //   height: 20,
        // ),
        const SizedBox(height: 30),
    //  Obx(()=>
       MyButton(
        height: Get.height*0.06,
        width: Get.width*0.5,
        // radius: 10,
        onPressed: (){
          onTap();
           HapticFeedback.heavyImpact();
        }, label: "Retry"  ),
    //  )
      ],
    );
  }
}