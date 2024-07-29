
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pesu_payu/config.dart';
import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/disclaimer.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/terms_condition.dart';
import 'package:pesu_payu/src/presentation/views/online_payment_view.dart';
import 'package:pesu_payu/src/utils/color/colors.dart';
import 'package:pesu_payu/src/utils/misctext_field.dart';
import 'package:pesu_payu/src/utils/my_button.dart';
import 'package:pesu_payu/src/utils/my_icons.dart';
import 'package:pesu_payu/src/utils/my_text.dart';
import 'package:pesu_payu/src/utils/page_route.dart';
import 'package:pesu_payu/src/utils/styles/my_text_styles.dart';
import 'package:pesu_payu/src/utils/toast.dart';
import 'package:pesu_payu/src/widget/appbar.dart';
import 'package:pesu_payu/src/widget/autosize_text.dart';

class TransactionDetailView extends GetView<OnlinePaymentController> {
  final int annualfeeIndex;
  const TransactionDetailView({super.key, required this.annualfeeIndex});

  @override
  Widget build(BuildContext context) {
    final config = Get.find<PaymentConfig>();
    return Scaffold(
        appBar: paymentAppBar(
          appBarLeadingOnTap: () => Get.back(),
          appBarTitle: "Transaction Detail",
          appBarBackgroundColor: config.primaryColor,
          appBarLeadingIconSize: 25.0,
        ),
        body: Obx(() => controller.paymentLoading.value
            ? Center(child: config.loadingWidget)
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // MyText("1", //style: Properties.textsStyles.text18_600),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    controller
                                            .paymentDetailModel
                                            .value
                                            .sTUDENTPAYMENTDETAILS?[
                                                annualfeeIndex]
                                            .finDemandFeeType ??
                                        '',
                               
                                  ),
                                  MyText(
                                      "${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[annualfeeIndex].academicYear ?? ""}  -  ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[annualfeeIndex].branch ?? ""} "),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const MyText(
                                          "Demand Amount",
                                     
                                        ),
                                        MyText(
                                          "₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[annualfeeIndex].demandAmount.toString() ?? '0.0'}",
                                      
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const MyText(
                                        "Paid Amount",
                              
                                      ),
                                      MyText(
                                        "₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[annualfeeIndex].paidAmount.toString() ?? '0.0'}",
                                     
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const MyText(
                                        "Balance Due",
                             
                                      ),
                                      MyText(
                                        "₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[annualfeeIndex].totalDue.toString() ?? '0.0'}",
                              
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const MyText(
                                        "Due Date",
                                        
                                      ),
                                      MyText(
                                        '${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[annualfeeIndex].dueDate}',
                                    
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const MyText(
                                          "Status",
                                       
                                        ),
                                        MyText(
                                          controller
                                                  .paymentDetailModel
                                                  .value
                                                  .sTUDENTPAYMENTDETAILS?[
                                                      annualfeeIndex]
                                                  .paymentStatus ??
                                              '',
                                          //style:
                                          // Properties.textsStyles.text14_600,
                                        )
                                      ],
                                    ),
                                  ),
                                
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  ((controller
                                                  .paymentDetailModel
                                                  .value
                                                  .sTUDENTPAYMENTDETAILS?[
                                                      annualfeeIndex]
                                                  .paymentStatus
                                                  .toString() ==
                                              "Pending" ||
                                          controller
                                                  .paymentDetailModel
                                                  .value
                                                  .sTUDENTPAYMENTDETAILS?[
                                                      annualfeeIndex]
                                                  .paymentStatus
                                                  .toString() ==
                                              "Partially Paid"))
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Center(
                                            child: MyButton(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.3,
                                                onPressed: () {
                                                
                                                  showModalBottomSheet(
                                                    isDismissible: false,
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 0.0,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top: Radius.circular(0),
                                                      ),
                                                    ),
                                                    context: context,
                                                    enableDrag: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom,
                                                        ),
                                                        child: PopScope(
                                                          onPopInvoked:
                                                              (didPop) {
                                                            if (didPop) {
                                                              // print("object");
                                                              controller
                                                                  .annualFeeClean();
                                                            }
                                                          },
                                                          child:
                                                              SingleChildScrollView(
                                                                  child:
                                                                      confirmationDialogBox(
                                                            context,
                                                            controller
                                                                .paymentDetailModel
                                                                .value
                                                                .sTUDENTPAYMENTDETAILS?[
                                                                    annualfeeIndex]
                                                                .totalDue
                                                                .toString(),
                                                            annualfeeIndex,
                                                          )),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                name: MyText('PAY',
                                                    color: Colors.white,
                                                    style: MyTextStyle
                                                        .text16_700
                                                        .copyWith(
                                                            color:
                                                                Colors.white))),
                                          ),
                                        )
                                      : Container(),


                                        controller.transactionDetailModel.value
                                          .studentDetails!.isEmpty
                                      ? const SizedBox()
                                      : Padding(
                                        padding: const EdgeInsets.only(top:20.0),
                                        child: ExpansionTile(
                                            tilePadding: EdgeInsets.zero,
                                            iconColor:
                                               config.primaryColor,
                                            collapsedIconColor:
                                                  config.primaryColor,
                                            title: MyText(
                                              'No.of Transaction(${controller.transactionDetailModel.value.studentDetails?.length ?? 0})',
                                          
                                            ),
                                            // ),
                                            children: [
                                              Column(
                                                children: [
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: controller
                                                              .transactionDetailModel
                                                              .value
                                                              .studentDetails
                                                              ?.length ??
                                                          0,
                                                      itemBuilder:
                                                          (context, int index) {
                                                        return noOfTransaction(
                                                            index);
                                                      }),
                                                  (controller
                                                          .transactionDetailModel
                                                          .value
                                                          .studentDetails!
                                                          .isEmpty)
                                                      ? Container()
                                                      : const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 15),
                                                          child: Disclaimer(),
                                                        )
                                                ],
                                              )
                                            ],
                                          ),
                                      ),

                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )));
  }

  Widget noOfTransaction(int transactionIndex) {
    
    return (controller.transactionDetailModel.value.studentDetails == [])
        ? const MyText("Transaction Detail Missing")
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(
                        "Date of transaction",
                 
                      ),
                      MyText(
                        controller
                                .transactionDetailModel
                                .value
                                .studentDetails?[transactionIndex]
                                .transactionDate
                                .toString() ??
                            "",
                 
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(
                        "Paid Amount",
                  
                      ),
                      MyText(
                        "₹ ${controller.transactionDetailModel.value.studentDetails?[transactionIndex].amount.toString()}",
                       
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(
                          "Status",
                        ),
                        MyText(
                          controller
                                  .transactionDetailModel
                                  .value
                                  .studentDetails?[transactionIndex]
                                  .verifiedStatus
                                  .toString() ??
                              "",
                        )
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MyText("Transaction Id"),
                          MyText(controller
                                  .transactionDetailModel
                                  .value
                                  .studentDetails?[transactionIndex]
                                  .transactionNo
                                  .toString() ??
                              ""),
                        ],
                      ),
                      GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                text:
                                    "${controller.transactionDetailModel.value.studentDetails?[transactionIndex].transactionNo.toString()}"));
                            showToast('Transaction id copied');
                            // copied successfully
                          },
                          child: const Icon(
                            Icons.copy,
                            // color: Properties.themeColor.darkBlue1,
                          ))
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          );
  }

  Widget noInternetDialog() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 8, right: 18, top: 12, bottom: 8),
            color: MyColors.darkBlue1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  "Network/Connection Error",
                  // //style: Properties.textsStyles.text15_500.copyWith(
                  //   color:Colors.white,
                  // ),
                ),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const MyIcons(
                      LucideIcons.x,
                      size: 20,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          // const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 15, bottom: 10),
            child: MyText(
                "The server is taking too long to respond OR something is wrong with your internet connection.Please try again later."),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 35,
                right: 14,
              ),
              child: MyButton(
                  width: 60,
                  height: 30,
                  onPressed: () {
                    Get.back();
                  },
                  label: "OK", ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget confirmationDialogBox(BuildContext context, dynamic dueAmount, int i) {
     final payConfig= Get.find<PaymentConfig>();
    print(
        "controller.partialAmountController ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[i].minAmount}");
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 10.0, top: 12.0, bottom: 12.0),
              color: payConfig.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "Confirm Amount To Pay",

                    color: Colors.white,
                    // style: ,
                    // ),
                  ),
                  InkWell(
                      onTap: () {
                        Get.back();
                        //  controller.otherAmountflag.value=false;
                        controller.annulatcflag.value = false;
                        controller.amountInWords.value = null;
                        controller.partialAmountController.clear();
                      },
                      child: const Icon(
                        LucideIcons.x,
                        size: 25.0,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: MyText(
                            "ANNUAL FEE",
                     
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                              "Due Amount ",
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 4, top: 4),
                         
                              width: 195,
                              height: 30,
                              child: MyText(
                                " ₹ $dueAmount",
                       
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: MyText("OR"),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.otherAmountflag.value =
                          !controller.otherAmountflag.value;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        children: [
                          Checkbox(
                              value: controller.otherAmountflag.value,
                              onChanged: (p) {
                                controller.partialAmountController.clear();
                                controller.confirmAmountToPay = '';
                                // controller.partialAmount = 0;
                                controller.otherAmountflag.value =
                                    !controller.otherAmountflag.value;
                              }),
                          const MyText("Other Amount"),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.otherAmountflag.value == true &&
                          controller.isotherAmountNotAvailable.value)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 8, top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const MyText("Partial Amount :"),
                                  SizedBox(
                                    width: 200,
                                    height: 60,
                                    child: MiscTextfield(
                                      hintText: 'Partial Amount in ₹',
                                      textFieldLabel: PesuText(
                                        '₹',
                                        color: Get.find<PaymentConfig>()
                                            .primaryColor,
                                      ),
                                      maxlines: 1,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'^0|\.')),
                                        FilteringTextInputFormatter.allow(RegExp(
                                            r'^(?:[1-9]\d*|0)?(?:\.\d{1,2})?$'))
                                      ],
                                      keyboardType: TextInputType.number,
                                      textController:
                                          controller.partialAmountController,
                                      onChanged: (value) {
                                        controller.updateAnount();
//
                                      },
                                    ),
                                  )
                                ],
                              ),
                              GetBuilder<OnlinePaymentController>(
                                builder: (_) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const MyText("Amount in words :"),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 2),
                                      // color: Properties.themeColor.gray5,
                                      width: 200,
                                      height: 50,
                                      child: AutoSizeText(
                                        (_.partialAmountController.text
                                                .isNotEmpty)
                                            ? "${_.amountInWords.value} RUPEES ONLY"
                                            : "",
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (controller.otherAmountflag.value == true &&
                          !controller.isotherAmountNotAvailable.value)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Row(
                           
                                children: [
                                  MyText(
                                    'Min amount',
                                  ),
                                ],
                              ),
                              Row(
                      
                                children: [
                                  MyText(
                                    '${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].minAmount}',
                           
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      (controller.paymentDetailModel.value
                                  .sTUDENTPAYMENTDETAILS?[0].estFineAmount !=
                              null)
                          ? fineAmount()
                          : Container(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: controller.annulatcflag.value,
                                onChanged: (value) {
                                  controller.annulatcflag.value =
                                      !controller.annulatcflag.value;
                                }),
                            Expanded(
                              child: RichText(
                                maxLines: 4,
                                text: TextSpan(
                                  text:
                                      'I have read instructions and agree to the payment ',
                                  style: const TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Terms and Conditions',
                                      style:  TextStyle(
                                        fontSize: 15.0,
                                        color: payConfig.primaryColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            FullDialogRoute(
                                              builder: (context) =>
                                                  const TermsAndConditionView(),
                                            ),
                                          );
                                        },
                                    ),
                                    const TextSpan(
                                      text: '.*',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 12, right: 8, top: 8, bottom: 8),
                        child: MyText(
                          "Note:- Please update your Adhaar No in your portal(My Profile) . Ignore if it is updated. *",
                        ),
                      ),
                      GetBuilder<OnlinePaymentController>(builder: (_) {
                        return submitButton(context, _);
                      })
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  Padding submitButton(BuildContext context, OnlinePaymentController _) {
    void navigateToPaymentPage({
      required bool isMiscPayment,
      required String merchantKey,
      required String academicYear,
      required String demandId,
      required String dueAmount,
      required String feeName,
      required String feeTypeId,
      required String miscType,
      String? instId,
    }) {
      Get.back();
      Navigator.push(
        context,
        FullDialogRoute(
          builder: (context) => PesuPaymentPage(
            instId: instId,
            isMiscpayment: isMiscPayment,
            merchantKey: merchantKey,
            academicyear: academicYear,
            demandId: demandId,
            dueAmount: dueAmount,
            feeName: feeName,
            fdFeeTypeId: feeTypeId,
            misctype: miscType,
          ),
        ),
      );
    }

    void handleSubmit() async {
      final studentDetails = controller
          .paymentDetailModel.value.sTUDENTPAYMENTDETAILS![annualfeeIndex];
      final merchantKey = studentDetails.paymentKey.toString();
      final academicYear = studentDetails.academicYearId.toString();
      final demandId = studentDetails.demandId ?? '';
      final feeName = studentDetails.feetype ?? '';
      final feeTypeId = studentDetails.finDemandFeeTypeId ?? '';
      final miscType = "0&0&0&1&$feeTypeId";
      final instId = studentDetails.instId.toString();
      final bool result =
          await controller.checkandConfirmAnnualAmount(studentDetails);
      if (_.annulatcflag.value && result) {
        navigateToPaymentPage(
          instId: instId,
          isMiscPayment: false,
          merchantKey: merchantKey,
          academicYear: academicYear,
          demandId: demandId,
          dueAmount: controller.confirmAmountToPay,
          feeName: feeName,
          feeTypeId: feeTypeId,
          miscType: miscType,
        );
      } else if (_.otherAmountflag.value) {
        if (!_.isotherAmountNotAvailable.value) {
          if (_.annulatcflag.value && result) {
            navigateToPaymentPage(
              instId: instId,
              isMiscPayment: false,
              merchantKey: merchantKey,
              academicYear: academicYear,
              demandId: demandId,
              dueAmount: controller.confirmAmountToPay,
              feeName: feeName,
              feeTypeId: feeTypeId,
              miscType: miscType,
            );
          }
        } else {
          if (result && _.annulatcflag.value) {
            navigateToPaymentPage(
              instId: instId,
              isMiscPayment: false,
              merchantKey: merchantKey,
              academicYear: academicYear,
              demandId: demandId,
              dueAmount: _.confirmAmountToPay,
              feeName: feeName,
              feeTypeId: feeTypeId,
              miscType: miscType,
            );
          }
        }
      }
    }

    Color getButtonColor() {
      if (_.annulatcflag.value && !_.otherAmountflag.value) {
        return Colors.green;
      }
      if (_.annulatcflag.value && _.otherAmountflag.value == true) {
        if (!_.isotherAmountNotAvailable.value) {
          return Colors.green;
          // if (_.tcflag.value) {
          // }
        } else if (controller.partialAmountController.value.text == '' ||
            _.partialAmountController.text.isEmpty) {
          return Colors.grey;
          // if (_.partialAmountController.text.isNotEmpty && _.tcflag.value) {}
        }
        return Colors.green;

        //  return    partialAmountController.text.isNotEmpty?Properties.themeColor.darkGreen
        //     _.partialAmountController.text.isNotEmpty?Properties.themeColor.darkGreen
        //     : Properties.themeColor.gray;
      }
      return Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyButton(
            isDisabled: !_.annulatcflag.value,
            name: controller.amountVerifying.value
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: Get.find<PaymentConfig>().loadingWidget)
                : null,
            width: MediaQuery.of(context).size.width / 2.3,
            onPressed: handleSubmit,
            label: "Submit",
            backgrounColor: getButtonColor(),
          ),
          MyButton(
            // isDisabled: true,
            width: MediaQuery.of(context).size.width / 2.3,
            onPressed: () {
              _.annualFeeClean();
              Get.back();
              print("confirmAmountToPay   ${_.confirmAmountToPay}");
            },
            label: "Cancel",
          ),
        ],
      ),
    );
  }

  Column fineAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText("Fine Amount"),
              Container(
                padding: const EdgeInsets.only(left: 4, top: 4),
          
                width: 195,
                height: 30,
                child: MyText(
                  " ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].estFineAmount}",
                
                ),
              )
            ],
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.only(bottom: 4, left: 8),
          child: MyText(
            "Total Amount to Pay",
        
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText("Due/min Amount"),
              Container(
                padding: const EdgeInsets.only(left: 4, top: 4),
               
                width: 195,
                height: 30,
                child: MyText(
                  " ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].estFineAmount}",
       
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText("Fine Amount"),
              Container(
                padding: const EdgeInsets.only(left: 4, top: 4),
          
                width: 195,
                height: 30,
                child: MyText(
                  " ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].estFineAmount}",
                  
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText("Partial Amount"),
              Container(
                padding: const EdgeInsets.only(left: 4, top: 4),
              
                width: 195,
                height: 30,
                child: MyText(
                  " ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].estFineAmount}",
                  
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText("Total Amount"),
              Container(
                padding: const EdgeInsets.only(left: 4, top: 4),
              
                width: 195,
                height: 30,
                child: MyText(
                  " ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].estFineAmount}",
              
                ),
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
