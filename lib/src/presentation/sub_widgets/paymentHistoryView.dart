import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
import 'package:pesu_payu/src/utils/toast.dart';
// import 'package:pesua/app/modules/student_modules/online_payment/controllers/online_payment_controller.dart';
// import 'package:pesua/utils/properties.dart';
// import 'package:pesua/utils/widgets/dialogs/toast.dart';


class PaymentHistoryView extends GetView<OnlinePaymentController> {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put<OnlinePaymentController>(OnlinePaymentController());
    return RefreshIndicator.adaptive(
                onRefresh: () async
                
                {
            //       controller.getPaymentDetail();
            //  controller.   getCTypeListResponse();
                },
                child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              controller.paymentDetailModel.value.paymenthistory?.length ?? 0,
          itemBuilder: (context, int i) {
            return annualFreeListTile1(context, i);
          }),
    );
  }

  Widget annualFreeListTile1(BuildContext context, int i) {
    var status =
        controller.paymentDetailModel.value.paymenthistory?[i].verifiedStatus;
    return Column(
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
                      child: Text(
                        controller.paymentDetailModel.value.paymenthistory?[i]
                                .transactionDetails ??
                            "",
                        // style: Properties.textsStyles.text16_600
                        //     .copyWith(color: Colors.black),
                      ),
                    ),
                    Text(controller.paymentDetailModel.value.paymenthistory?[i]
                            .transactionDate ??
                        ""),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${controller.paymentDetailModel.value.paymenthistory?[i].batchName ?? ""} "),
                    Text(
                        "₹ ${controller.paymentDetailModel.value.paymenthistory?[i].amount ?? ""}"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Status"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: (status == "Successful" || status == "Paid")
                              ? Icon(
                                  LucideIcons.checkCircle,
                                  color: ((status == "Successful")
                                      ? Colors.green
                                      : Colors.brown),
                                  size: 20,
                                )
                              : (status == "Pending" ||
                                      status == "Partially Paid")
                                  ? const Icon(
                                      LucideIcons.clock,
                                      color: Colors.grey,
                                      size: 20,
                                    )
                                  : (status == "Rejected" ||
                                          status == "Failure")
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
                        Text(
                            " ${controller.paymentDetailModel.value.paymenthistory?[i].verifiedStatus.toString()}"),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Transaction Id"),
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(
                            text:
                                "${(controller.paymentDetailModel.value.paymenthistory?[i].transactionNo.toString())}"));
                        showToast('Transaction id copied');
                        // copied successfully
                      },
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.copy,
                            // color: Properties.themeColor.skyblue1,
                            size: 16,
                          ),
                          const Text(" "),
                          Text(controller.paymentDetailModel.value
                                  .paymenthistory?[i].transactionNo
                                  .toString() ??
                              ""),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                          maxLines: 4,
                          controller.paymentDetailModel.value.paymenthistory?[i]
                                          .reason !=
                                      ' ' &&
                                  controller.paymentDetailModel.value
                                          .paymenthistory?[i].reason !=
                                      ''
                              ? "Reason : ${controller.paymentDetailModel.value.paymenthistory?[i].reason.toString()}"
                              : ""),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  // Widget annualFreeListTile(int index) {
  //   return Container(
  //     margin: const EdgeInsets.all(12),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             // Text("1", style: Properties.textsStyles.text18_600),
  //             Expanded(
  //               child: Container(
  //                 padding: const EdgeInsets.only(left: 8),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                         controller
  //                                 .paymentDetailModel
  //                                 .value
  //                                 .sTUDENTPAYMENTDETAILS?[index]
  //                                 .finDemandFeeType ??
  //                             '',
  //                         style: Properties.textsStyles.text18_600.copyWith(
  //                           color: Properties.themeColor.black,
  //                         )),
  //                     const Text("2023-24  -  Bachelor of pharmacy "),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "Demand Amount",
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                         Text(
  //                           controller.paymentDetailModel.value
  //                                   .sTUDENTPAYMENTDETAILS?[index].demandAmount
  //                                   .toString() ??
  //                               '0.0',
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "Paid Amount",
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                         Text(
  //                           controller.paymentDetailModel.value
  //                                   .sTUDENTPAYMENTDETAILS?[index].paidAmount
  //                                   .toString() ??
  //                               '0.0',
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "Balance Amount",
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                         Text(
  //                           controller.paymentDetailModel.value
  //                                   .sTUDENTPAYMENTDETAILS?[index].amount
  //                                   .toString() ??
  //                               '0.0',
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "Due Amount",
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                         Text(
  //                           controller.paymentDetailModel.value
  //                                   .sTUDENTPAYMENTDETAILS?[index].amount
  //                                   .toString() ??
  //                               '0.0',
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "No of Transaction ",
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                         Text(
  //                           controller
  //                                   .paymentDetailModel
  //                                   .value
  //                                   .sTUDENTPAYMENTDETAILS?[index]
  //                                   .noofTransction
  //                                   .toString() ??
  //                               '0',
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "Status",
  //                           style: Properties.textsStyles.text14_600,
  //                         ),
  //                         Text(
  //                           controller.paymentDetailModel.value
  //                                   .sTUDENTPAYMENTDETAILS?[index].status
  //                                   .toString() ??
  //                               '',
  //                           style: Properties.textsStyles.text14_600,
  //                         )
  //                       ],
  //                     ),

  //                     // const SizedBox(
  //                     //   height: 10,
  //                     // ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         commonButton(
  //                             width: 100,
  //                             onPressed: () {},
  //                             label: "Transaction Detail"),
  //                         commonButton(
  //                             width: 100, onPressed: () {}, label: "PAY"),
  //                       ],
  //                     ),
  //                     // const SizedBox(
  //                     //   height: 10,
  //                     // ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
