import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pesua/app/modules/student_modules/online_payment/controllers/online_payment_controller.dart';
import 'package:pesua/app/modules/student_modules/online_payment/views/subwidgets/annualFees.dart';
import 'package:pesua/app/modules/student_modules/online_payment/views/subwidgets/disclaimer.dart';
import 'package:pesua/app/modules/student_modules/online_payment/views/subwidgets/miscellaneous.dart';
import 'package:pesua/app/modules/student_modules/online_payment/views/subwidgets/paymentHistoryView.dart';
import 'package:pesua/utils/properties.dart';
import 'package:pesua/utils/retry_exception.dart';
import 'package:pesua/utils/rxstatus.dart';
import 'package:pesua/utils/widgets/appbar/custom_app_bar.dart';
import 'package:pesua/utils/widgets/loading_widget.dart';
import 'package:pesupay/src/presentation/controller/payment_controller.dart';
import 'package:pesupay/src/utils/enums/rxtstatus.dart';

// import '../controllers/online_payment_controller.dart';

class OnlinePaymentView extends GetView<OnlinePaymentController> {
  const OnlinePaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    
    // Get.put<OnlinePaymentController>(OnlinePaymentController());
    TabBar tabBar = TabBar(
     
      tabAlignment: TabAlignment.start,
        onTap: (index) {
          // if(index==0||index==2){
          // controller.stypeModel.value.stype!.clear();
          // }
          //   controller.ctcCategory.value=controller
          //       .placementRegisteredTopicwise.value.cTCWISE![0].cTCS1ID.toString();
          // }else if(index==1){
          //   controller.ctcCategory.value=controller
          //       .placementRegisteredTopicwise.value.cTCWISE![0].cTCS2ID.toString();
          // }else if(index == 2){
          //   controller.ctcCategory.value=controller
          //       .placementRegisteredTopicwise.value.cTCWISE![0].cTCS3ID.toString();
          // }else if(index == 3){
          //   controller.ctcCategory.value=controller
          //       .placementRegisteredTopicwise.value.cTCWISE![0].cTCS4ID.toString();
          // }else if(index == 4){
          //   controller.ctcCategory.value=controller
          //       .placementRegisteredTopicwise.value.cTCWISE![0].cTCS5ID.toString();
          // }else if(index == 5){
          //   controller.ctcCategory.value=controller
          //       .placementRegisteredTopicwise.value.cTCWISE![0].cTCS6ID.toString();
          // }
        },
        enableFeedback: true,
        indicatorColor: Properties.themeColor.appVersion,
        indicatorWeight: 4,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        labelColor: Properties.themeColor.darkBlue1,
        unselectedLabelColor: Properties.themeColor.darkBlue1,
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
        appBar: customAppBar(
          title: "Online Payments",
          actions: [
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
              color: Properties.themeColor.darkBlue3,
              //<-- SEE HERE
              child: SizedBox(
                  width: MediaQuery.of(context).size.width, child: tabBar),
            ),
          ),
          onBack: () {
            Get.back();
          },

          // backgroundColor: Properties.themeColor.secondaryColor,
        ),
        body: Obx(
          () => controller.rxRequestStatus.value==RequestStatus.LOADING
              ? const PesuLoading()
              : controller.rxRequestStatus.value==RequestStatus.ERROR ?
            RetryException(onTap: (){
              controller.getPaymentDetail();
              controller.getCTypeListResponse();
            })
              
              // const Center(child: Text("No Data Available"),)
              : const TabBarView(
                 physics:  NeverScrollableScrollPhysics(),
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
