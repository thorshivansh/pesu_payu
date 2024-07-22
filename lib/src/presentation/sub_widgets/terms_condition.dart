import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
import 'package:pesu_payu/src/utils/enums/rxtstatus.dart';
import 'package:pesu_payu/src/widget/retry_widget.dart';

class TermsAndConditionView extends GetView<OnlinePaymentController> {
  const TermsAndConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms and Conditions")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<OnlinePaymentController>(builder: (con) {
            return con.rxRequestStatus.value == RequestStatus.LOADING
                ? const SizedBox(
                    height: 500,
                    child: Center(child: CircularProgressIndicator.adaptive()))
                : con.rxRequestStatus.value == RequestStatus.ERROR ||
                        con.termsandcondition.value == null
                    ? RetryException(onTap: controller.getTermsAndConditions, message:  '')
                    : HtmlDetails(
                        open: true,
                        child: HtmlWidget(
                          controller.termsandcondition.value,
                          onErrorBuilder: (context, element, error) => RetryException(onTap: controller.getTermsAndConditions, message: '',),
                          onLoadingBuilder:
                              (context, element, loadingProgress) =>
                                  const SizedBox(
                                      height: 500,
                                      child: Center(
                                          child: CircularProgressIndicator
                                              .adaptive())),
                        ));
          }),
        ),
      ),
    );
  }
}
