
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../pesupay.dart';

class AnnualFee extends GetView<OnlinePaymentController> {
  // final 
  const AnnualFee({super.key});
  @override
  Widget build(BuildContext context) {
    CancelToken token = CancelToken();
    final config = Get.find<PaymentConfig>();
    return PopScope(
      onPopInvoked: (didPop) => token.cancel(),
      child: RefreshIndicator.adaptive(
                  onRefresh: ()async {
      controller.getCTypeListResponse();
                 controller.getPaymentDetail();
                 controller.getTermsAndConditions();
                //  return ;
                  },
                  child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: config.secondaryColor,
                child: MyText(
                    "Balance / Pending Amount(${controller.pendingCount.value})",
                    style: GoogleFonts.merriweather(
                      // textStyle: Properties.textsStyles.text16_500
                      //     .copyWith(color: Properties.themeColor.darkBlue1),
                    )),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller
                          .paymentDetailModel.value.sTUDENTPAYMENTDETAILS?.length ??
                      0,
                  itemBuilder: (context, int i) {
                    var status = controller.paymentDetailModel.value
                        .sTUDENTPAYMENTDETAILS?[i].paymentStatus;
                    return (status == "Pending" || status == "Partially Paid")
                        ? annualFreeListTile1(context, i)
                        : Container();
                  }),
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.all(10),
              //   color: Properties.themeColor.darkBlue3,
              //   child: MyText(
              //       "Paid/Successful/Rejected Payment(${controller.paidCount.value})",
              //       style: GoogleFonts.merriweather(
              //         textStyle: Properties.textsStyles.text16_500
              //             .copyWith(color: Properties.themeColor.darkBlue1),
              //       )),
              // ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller
                          .paymentDetailModel.value.sTUDENTPAYMENTDETAILS?.length ??
                      0,
                  itemBuilder: (context, int i) {
                    var status = controller.paymentDetailModel.value
                        .sTUDENTPAYMENTDETAILS?[i].paymentStatus;
                    return (status == "Successful" ||
                            status == "Paid" ||
                            status == "Rejected")
                        ? annualFreeListTile1(context, i)
                        : Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget annualFreeListTile1(context, int i) {
    var status = controller
        .paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[i].paymentStatus;
    return InkWell(
      onTap: () {
        controller.getTransactionDetail(
            controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[i]
                    .academicYearId ??
                0,
            controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[i]
                    .finDemandFeeTypeId
                    .toString() ??
                0);
controller. setisotherAmountAvailableorNot(i);
        Get.to(() => TransactionDetailView(
              annualfeeIndex: i,
              
            ), transition: Transition.cupertino);
      
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: MyText(
                          '${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[i].finDemandFeeType}(${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[i].academicYear ?? ""} - ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[i].branch ?? ""})',
                          maxLines: 4,
                          // style: Properties.textsStyles.text16_600
                          //     .copyWith(color: Colors.black),
                        ),
                      ),
                      const MyText("10-06-2024"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                          "Total : ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[i].demandAmount} "),
                      Container(
                        child: (status == "Successful" || status == "Paid")
                            ? Icon(
                                LucideIcons.checkCircle,
                                color: ((status == "Successful")
                                    ? Colors.green
                                    : Colors.brown),
                                size: 20,
                              )
                            : (status == "Pending")
                                ? const Icon(
                                    LucideIcons.clock,
                                    color: Colors.grey,
                                    size: 20,
                                  )
                                : (status == "Partially Paid")
                                    ? const Icon(
                                        Icons.incomplete_circle,
                                        color: Colors.grey,
                                        size: 20,
                                      )
                                    : (status == "Rejected")
                                        ? const Icon(
                                            LucideIcons.xCircle,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        : const Icon(
                                            Icons.check_circle_outline_sharp,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                      ),
                    ],
                  ),
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                        "Balance : ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[i].totalDue}"),
                    MyText(controller.paymentDetailModel.value
                            .sTUDENTPAYMENTDETAILS?[i].paymentStatus
                            .toString() ??
                        ""),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
   
}
