
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pesu_payu/pesupay.dart';
import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/disclaimer.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/terms_condition.dart';
import 'package:pesu_payu/src/presentation/views/online_payment_view.dart';
import 'package:pesu_payu/src/utils/color/colors.dart';
import 'package:pesu_payu/src/utils/misctext_field.dart';
import 'package:pesu_payu/src/utils/my_button.dart';
import 'package:pesu_payu/src/utils/my_text.dart';
import 'package:pesu_payu/src/utils/my_icons.dart';
import 'package:pesu_payu/src/utils/page_route.dart';
import 'package:pesu_payu/src/utils/styles/my_text_styles.dart';
import 'package:pesu_payu/src/utils/toast.dart';
// import 'package:pesupay/src/presentation/controller/payment_controller.dart';
// import 'package:pesupay/src/utils/toast.dart';
// import 'package:pesua/app/modules/student_modules/online_payment/controllers/online_payment_controller.dart';
// import 'package:pesua/app/modules/student_modules/online_payment/views/payment_page.dart';
// import 'package:pesua/app/modules/student_modules/online_payment/views/subwidgets/disclaimer.dart';
// import 'package:pesua/app/modules/student_modules/online_payment/views/subwidgets/terms_condition.dart';
// import 'package:pesua/app/modules/student_modules/online_payment/widgets/misctextfield.dart';
// import 'package:pesua/utils/custom_page/fullpage_dialog.dart';
// import 'package:pesua/utils/properties.dart';
// import 'package:pesua/utils/widgets/appbar/custom_app_bar.dart';
// import 'package:pesua/utils/widgets/buttons/common_button.dart';
// import 'package:pesua/utils/widgets/dialogs/toast.dart';
// import 'package:pesua/utils/widgets/loading_widget.dart';

class TransactionDetailView extends GetView<OnlinePaymentController> {
  final int annualfeeIndex;
  const TransactionDetailView({super.key, required this.annualfeeIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:const Text( "Transaction Detail")),
        body: Obx(() => controller.paymentloading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
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
                                    // style: GoogleFonts.roboto(
                                    //   textStyle:
                                    //       Properties.textsStyles.text18_600,
                                    //   color: Properties.themeColor.darkBlue,
                                    // ),
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
                                          //style:
                                              // Properties.textsStyles.text14_600,
                                        ),
                                        MyText(
                                          "₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[annualfeeIndex].demandAmount.toString() ?? '0.0'}",
                                          //style:
                                              // Properties.textsStyles.text14_600,
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
                                        //style:
                                            // Properties.textsStyles.text14_600,
                                      ),
                                      MyText(
                                        "₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[annualfeeIndex].paidAmount.toString() ?? '0.0'}",
                                        //style:
                                            // Properties.textsStyles.text14_600,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const MyText(
                                        "Balance Due",
                                        //style:
                                            // Properties.textsStyles.text14_600,
                                      ),
                                      MyText(
                                        "₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[annualfeeIndex].totalDue.toString() ?? '0.0'}",
                                        //style:
                                            // Properties.textsStyles.text14_600,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const MyText(
                                        "Due Date",
                                        //style:
                                            // Properties.textsStyles.text14_600,
                                      ),
                                      MyText(
                                        '${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[annualfeeIndex].dueDate}',
                                        //style:
                                            // Properties.textsStyles.text14_600,
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
                                          //style:
                                              // Properties.textsStyles.text14_600,
                                        ),
                                        MyText(
                                          controller
                                                  .paymentDetailModel
                                                  .value
                                                  .sTUDENTPAYMENTDETAILS?[
                                                      annualfeeIndex]
                                                  .verifiedStatus ??
                                              '',
                                          //style:
                                              // Properties.textsStyles.text14_600,
                                        )
                                      ],
                                    ),
                                  ),
                                  controller.transactionDetailModel.value
                                          .studentDetails!.isEmpty
                                      ? const SizedBox()
                                      : ExpansionTile(
                                          tilePadding: EdgeInsets.zero,
                                          // iconColor:
                                          //     Properties.themeColor.darkBlue,
                                          // collapsedIconColor:
                                          //     Properties.themeColor.darkBlue,
                                          title: MyText(
                                              'No.of Transaction(${controller.transactionDetailModel.value.studentDetails?.length ?? 0})',
                                              //style: GoogleFonts.roboto(
                                                // textStyle: Properties
                                                //     .textsStyles.text14_500,
                                                // color: Properties
                                                    // .themeColor.darkBlue,
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
                                                  controller.tcflag.value =
                                                      false;
                                                  controller.otherAmountflag
                                                      .value = false;
                                                  // (controller
                                                  //             .connectionController
                                                  //             .connectionType
                                                  //             .value ==
                                                  //         0)
                                                  //     ? showModalBottomSheet(
                                                  //         context: context,
                                                  //         builder: (BuildContext
                                                  //             context) {
                                                  //           return noInternetDialog();
                                                  //         })
                                                      showModalBottomSheet(
                                                          isDismissible: false,
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors.white,
                                                          elevation: 0.0,
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .vertical(
                                                              top: Radius
                                                                  .circular(0),
                                                            ),
                                                          ),
                                                          context: context,
                                                          enableDrag: false,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom,
                                                              ),
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
                                                                        .toString() ??
                                                                    '0.0',
                                                                annualfeeIndex,
                                                              )),
                                                            );
                                                          },
                                                        );
                                               
                                               
                                                },
                                                name: MyText('PAY',color: Colors.white, style: MyTextStyle.text16_700.copyWith(color: Colors.white))),
                                          ),
                                        )
                                      : Container(),
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
                        //style: Properties.textsStyles.text14_600,
                      ),
                      MyText(
                        controller
                                .transactionDetailModel
                                .value
                                .studentDetails?[transactionIndex]
                                .transactionDate
                                .toString() ??
                            "",
                        //style: Properties.textsStyles.text14_600,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(
                        "Paid Amount",
                        //style: Properties.textsStyles.text14_600,
                      ),
                      MyText(
                        "₹ ${controller.transactionDetailModel.value.studentDetails?[transactionIndex].amount.toString()}",
                        //style: Properties.textsStyles.text14_600,
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
      color:Colors.white,
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
                      color:Colors.white,
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
                  label: "OK"),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget confirmationDialogBox(BuildContext context, dynamic dueAmount, int i) {
    // print(
    //     "controller.partialAmountController ${controller.partialAmountController.text}");
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
              color: MyColors.darkBlue1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "Confirm Amount To Pay",
                    // //style: Properties.textsStyles.text18_600.copyWith(
                      color:Colors.white,
                      // style: ,
                    // ),
                  ),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        LucideIcons.x,
                        size: 20.0,
                        color:Colors.white,
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
                            // //style: Properties.textsStyles.text18_700,/
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
                              // decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     color: Properties.themeColor.gray3)),
                              width: 195,
                              height: 30,
                              child: MyText(
                                " ₹ $dueAmount",
                                // //style: Properties.textsStyles.text15_500
                                //     .copyWith(
                                //         color: Properties.themeColor.black),
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
                          controller.isotherAmountAvailable.value)
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
                      else if (controller.otherAmountflag.value == true)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  MyText(
                                    'Min amount',
                                  ),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  MyText(
                                    '${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].minAmount}',
                                    // //style: Properties.textsStyles.text15_500
                                    //     .copyWith(
                                    //         color: Properties.themeColor.black),
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
                                value: controller.tcflag.value,
                                onChanged: (value) {
                                  controller.tcflag.value =
                                      !controller.tcflag.value;
                                }),
                            Expanded(
                              child: RichText(
                                maxLines: 4,
                                text: TextSpan(
                                  text:
                                      'I have read instructions and agree to the payment ',
                                  style: const TextStyle(
                                      fontSize: 11.0, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Terms and Conditions',
                                      style: const TextStyle(
                                        fontSize: 11.0,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
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

    void handleSubmit() {
      final studentDetails = controller
          .paymentDetailModel.value.sTUDENTPAYMENTDETAILS![annualfeeIndex];
      final merchantKey = studentDetails.paymentKey.toString();
      final academicYear = studentDetails.academicYearId.toString();
      final demandId = studentDetails.demandId ?? '';
      final feeName = studentDetails.feetype ?? '';
      final feeTypeId = studentDetails.finDemandFeeTypeId ?? '';
      final miscType = "0&0&0&1&$feeTypeId";
      final instId = studentDetails.instId.toString();

      if (_.tcflag.value && !_.otherAmountflag.value) {
        navigateToPaymentPage(
          instId: instId,
          isMiscPayment: false,
          merchantKey: merchantKey,
          academicYear: academicYear,
          demandId: demandId,
          dueAmount: studentDetails.totalDue.toString(),
          feeName: feeName,
          feeTypeId: feeTypeId,
          miscType: miscType,
        );
      } else if (_.otherAmountflag.value) {
        if (!_.isotherAmountAvailable.value) {
          if (_.tcflag.value) {
            navigateToPaymentPage(
              instId: instId,
              isMiscPayment: false,
              merchantKey: merchantKey,
              academicYear: academicYear,
              demandId: demandId,
              dueAmount: studentDetails.minAmount.toString(),
              feeName: feeName,
              feeTypeId: feeTypeId,
              miscType: miscType,
            );
          }
        } else if (_.partialAmountController.text.isEmpty) {
          showToast('amount is empty');
        } else {
          final partialValue = double.tryParse(_.partialAmountController.text)!;

          if (partialValue > studentDetails.dueAmount!) {
            showToast('Amount is more than your total due amount');
          } else if (partialValue < 5000) {
            showToast('Minimum amount should be Rs. 5000');
          } else {
            navigateToPaymentPage(
              instId: instId,
              isMiscPayment: false,
              merchantKey: merchantKey,
              academicYear: academicYear,
              demandId: demandId,
              dueAmount: _.partialAmountController.text,
              feeName: feeName,
              feeTypeId: feeTypeId,
              miscType: miscType,
            );
          }
        }
      }
    }


    Color getButtonColor() {
      if (_.tcflag.value && !_.otherAmountflag.value) {
        return Colors.green;
      }
      if (_.tcflag.value && _.otherAmountflag.value == true) {
        if (!_.isotherAmountAvailable.value) {
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
            width: MediaQuery.of(context).size.width / 2.3,
            onPressed: handleSubmit,
            label: "Submit",
            backgrounColor: getButtonColor(),
          ),
          MyButton(
            width: MediaQuery.of(context).size.width / 2.3,
            onPressed: () {
              _.clean();
              Get.back();
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
                // decoration: BoxDecoration(
                //     border: Border.all(color: Properties.themeColor.gray3)),
                width: 195,
                height: 30,
                child: MyText(
                  " ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].estFineAmount}",
                  // //style: Properties.textsStyles.text15_500
                  //     .copyWith(color: Properties.themeColor.black),
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
            //style: Properties.textsStyles.text18_700,
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
                // decoration: BoxDecoration(
                    // border: Border.all(color: Properties.themeColor.gray3)),
                width: 195,
                height: 30,
                child: MyText(
                  " ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].estFineAmount}",
                  //style: Properties.textsStyles.text15_500
                      // .copyWith(color: Properties.themeColor.black),
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
                // decoration: BoxDecoration(
                //     border: Border.all(color: Properties.themeColor.gray3)),
                width: 195,
                height: 30,
                child: MyText(
                  " ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].estFineAmount}",
                  //style: Properties.textsStyles.text15_500
                      // .copyWith(color: Properties.themeColor.black),
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
                // decoration: BoxDecoration(
                    // border: Border.all(color: Properties.themeColor.gray3)),
                width: 195,
                height: 30,
                child: MyText(
                  " ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].estFineAmount}",
                  //style: Properties.textsStyles.text15_500
                      // .copyWith(color: Properties.themeColor.black),
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
                // decoration: BoxDecoration(
                //     border: Border.all(color: Properties.themeColor.gray3)),
                width: 195,
                height: 30,
                child: MyText(
                  " ₹ ${controller.paymentDetailModel.value.sTUDENTPAYMENTDETAILS?[0].estFineAmount}",
                  //style: Properties.textsStyles.text15_500
                      // .copyWith(color: Properties.themeColor.black),
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
