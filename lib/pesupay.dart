// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/annualFees.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/disclaimer.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/miscellaneous.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/paymentHistoryView.dart';
import 'package:pesu_payu/src/utils/enums/rxtstatus.dart';

class OnlinePaymentView extends GetView<OnlinePaymentController> {
    final String name;
    final String email;
    final String mobileNumber;
    final String userId;
    final String loginId;
    final int instId;
    final Dio dio;
  const OnlinePaymentView(this.dio, this.instId, {required this.name,required this.email,required this.mobileNumber,required this.userId,required this.loginId, super.key});
  @override
  Widget build(BuildContext context) {
     Get.put<OnlinePaymentController>(OnlinePaymentController(dio));
     controller.userInfo=ValueNotifier({ 'name': name,
    'email': email,
    'mobileNumber': mobileNumber,
    'loginId': loginId,
    'userId': userId,
    'instId': instId,});
// controller.getUserInfo(email: email, name: name,mobileNumber: mobileNumber,userId: userId,loginId: loginId, instId:instId);

    
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
        // indicatorColor: Properties.themeColor.appVersion,
        indicatorWeight: 4,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        // labelColor: Properties.themeColor.darkBlue1,
        // unselectedLabelColor: Properties.themeColor.darkBlue1,
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
        appBar: AppBar(
          title: const Text("Online Payments"),
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
              // color: Properties.themeColor.darkBlue3,
              //<-- SEE HERE
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
          () => controller.rxRequestStatus.value==RequestStatus.LOADING
              ? const CircularProgressIndicator.adaptive()
              : controller.rxRequestStatus.value==RequestStatus.ERROR ?
            GestureDetector(onTap: (){
              // controller.getPaymentDetail();
              // controller.getCTypeListResponse();
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
class UserInfo {
  final String name;
  final String email;
  final String mobile;
  final String instId;
  final String userId;
  final String loginId;
  UserInfo({
    required this.name,
    required this.email,
    required this.mobile,
    required this.instId,
    required this.userId,
    required this.loginId,
  });
  

  void updatinfo(){

  
  ValueNotifier<Map<String, dynamic>> userInfo = ValueNotifier({
 'name': name,
    'email': email,
    'mobileNumber': mobile,
    'loginId': loginId,
    'userId': userId,
    'instId': instId,

  });
  }
  }
