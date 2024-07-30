// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'hide Response;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pesu_payu/src/config/payments_config.dart';

import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/annualFees.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/disclaimer.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/miscellaneous.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/paymentHistoryView.dart';
import 'package:pesu_payu/src/utils/enums/rxtstatus.dart';
import 'package:pesu_payu/src/utils/my_icons.dart';
import 'package:pesu_payu/src/widget/appbar.dart';
import 'package:pesu_payu/src/widget/retry_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnlinePaymentView extends GetView<OnlinePaymentController> {
  final String name;
  final String email;
  final String mobileNumber;
  final String userId;
  final String loginId;
  final int instId;
  final Dio dio;
  final SharedPreferences preferences;
  final CancelToken cancelToken;
  final PaymentConfig config;
  const OnlinePaymentView(
      {required this.dio,
      required this.instId,
      required this.preferences,
      required this.cancelToken,
      required this.config,
      required this.name,
      required this.email,
      required this.mobileNumber,
      required this.userId,
      required this.loginId,
      super.key});




  @override
  Widget build(BuildContext context) {
final config = Get.find<PaymentConfig>();
 dio.interceptors.add(CustomInterceptor());
Get.put<OnlinePaymentController>(
    OnlinePaymentController(dio, preferences, cancelToken),
  );

  // Get.put();
  controller.userInfo = ValueNotifier({
    'name':  name,
    'email':  email,
    'mobileNumber':  mobileNumber,
    'loginId':  loginId,
    'userId':  userId,
    'instId':  instId,
  });
    TabBar tabBar = TabBar(
        tabAlignment: TabAlignment.start,
        onTap: (index) {

        },
        enableFeedback: true,
        // indicatorColor: config.appVersion,
        indicatorWeight: 4,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        labelColor: config.primaryColor,
        unselectedLabelColor: config.primaryColor,
        tabs: const [
          Tab(
            text: "Annual Fees",
          ),
          Tab(text: "Miscellaneous Fees"),
          Tab(text: "Payment History"),
        ]);
    // Get.find<OnlinePaymentController>();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: paymentAppBar(
          
          appBarTitle: "Online Payments",appBarBackgroundColor: config.primaryColor,
          appBarAction: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(0),
                      ),
                    ),
                    context: context,
                    enableDrag: true,
                    builder: (BuildContext context) {
                      return const Padding(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 10, bottom: 15),
                        child: Disclaimer(),
                      );
                    },
                  );
                },
                child: const MyIcons(
                  LucideIcons.alertCircle,
                  color: Colors.white,
                ),
              ),
            ),

            Visibility(
              visible: tabBar.controller?.index!=0,
            child: MyIcons(LucideIcons.search, onPressed: () {
                
              },),
          )
          ],
          bottom: PreferredSize(
            preferredSize: tabBar.preferredSize,
            child: Material(
              color: config.secondaryColor,
            
              child: SizedBox(
                  width: MediaQuery.of(context).size.width, child: tabBar),
            ),
          ),
          // onBack: () {
          //   Get.back();
          // },


        ),
        body: Obx(
          () => controller.rxRequestStatus.value == RequestStatus.LOADING
              ?  Center(child: config.loadingWidget)
              : controller.rxRequestStatus.value == RequestStatus.ERROR
                  ? RetryException(onTap: () {
                      controller.getPaymentDetail();
                      controller.getCTypeListResponse();
                      controller.getTermsAndConditions();
                    })

                  // const Center(child: Text("No Data Available"),)
                  : const TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        AnnualFee(),
                        Miscellaneous(),
                        PaymentHistoryView(),
                      ],
                    ),
        ),
      ),
    );
  }
}



///
///
///


class CustomInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
       errorMessage = "Connection Timeout. Please try again.";
        break;
      case DioExceptionType.badResponse:
        if (err.response?.statusCode == 404) {
        errorMessage = "Resource not found.";
        } else {
         errorMessage = "Received invalid status code: ${err.response?.statusCode}";
        }
        break;
      case DioExceptionType.cancel:
       errorMessage = "Request to API server was cancelled.";
        break;
      case DioExceptionType.unknown:
       errorMessage = "Connection error: ${err.message}";
        break;
        default:
        errorMessage = "Unknown error occurred.";
        break;
    }
    handler.next(DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: CustomDioException(errorMessage),
    ));
  }


  /// Called when the request is about to be sent.
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.next(options);
  }

  /// Called when the response is about to be resolved.
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}


class CustomDioException implements Exception {
  final String message;
  CustomDioException(this.message);

  @override
  String toString() => message;
}
