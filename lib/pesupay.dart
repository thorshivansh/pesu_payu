// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pesu_payu/src/config/config.dart';

import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/annualFees.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/disclaimer.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/miscellaneous.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/paymentHistoryView.dart';
import 'package:pesu_payu/src/utils/enums/rxtstatus.dart';
import 'package:pesu_payu/src/widget/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnlinePaymentView extends StatefulWidget {
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
  State<OnlinePaymentView> createState() => _OnlinePaymentViewState();
}


class _OnlinePaymentViewState extends State<OnlinePaymentView> {
  late final OnlinePaymentController controller ;
@override
void initState() {
controller= Get.put<OnlinePaymentController>(
    OnlinePaymentController(widget.dio, widget.preferences, widget.cancelToken),
  );
  // Get.put();
  controller.userInfo = ValueNotifier({
    'name': widget.name,
    'email': widget.email,
    'mobileNumber': widget.mobileNumber,
    'loginId': widget.loginId,
    'userId': widget.userId,
    'instId': widget.instId,
  });
  super.initState();
}

final config = Get.find<PaymentConfig>();
  @override
  Widget build(BuildContext context) {
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
          appBarTitle: "Online Payments",
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
                child: const Icon(
                  LucideIcons.alertCircle,
                  color: Colors.white,
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: tabBar.preferredSize,
            child: Material(
              // color: Properties.themeColor.darkBlue3,
            
              child: SizedBox(
                  width: MediaQuery.of(context).size.width, child: tabBar),
            ),
          ),
          // onBack: () {
          //   Get.back();
          // },

          // backgroundColor: Properties.themeColor.secondaryColor,
        ),
        body: Obx(
          () => controller.rxRequestStatus.value == RequestStatus.LOADING
              ? const Center(child: CircularProgressIndicator.adaptive())
              : controller.rxRequestStatus.value == RequestStatus.ERROR
                  ? GestureDetector(onTap: () {
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
