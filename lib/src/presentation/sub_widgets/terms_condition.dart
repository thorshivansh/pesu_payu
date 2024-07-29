import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pesu_payu/src/config/config.dart';
import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
import 'package:pesu_payu/src/widget/appbar.dart';
import 'package:pesu_payu/src/widget/retry_widget.dart';

class TermsAndConditionView extends GetView<OnlinePaymentController> {
  const TermsAndConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Get.find<PaymentConfig>();
    return Scaffold(
      appBar: paymentAppBar(appBarTitle: "Terms and Conditions", appBarBackgroundColor: config.primaryColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<OnlinePaymentController>(
            
            id: 'terms',
            builder: (con) {
            return con.termsLoading.value=='load'
                ?  SizedBox(
                    height: 500,
                    child: Center(child: config.loadingWidget))
                : con.termsLoading.value == 'fail' ||
                        con.termsandcondition.value == null
                    ? RetryException(onTap: controller.getTermsAndConditions, message:  '')
                    : HtmlDetails(
                        open: true,
                        child: HtmlWidget(
                          controller.termsandcondition.value,
                          onErrorBuilder: (context, element, error) => RetryException(onTap: controller.getTermsAndConditions, message: '',),
                          onLoadingBuilder:
                              (context, element, loadingProgress) =>
                                   SizedBox(
                                      height: 500,
                                      child: Center(
                                          child: config.loadingWidget)),
                        ));
          }),
        ),
      ),
    );
  }
}
