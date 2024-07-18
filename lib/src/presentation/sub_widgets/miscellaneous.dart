// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pesu_payu/src/presentation/controller/payment_controller.dart';
import 'package:pesu_payu/src/presentation/sub_widgets/terms_condition.dart';
import 'package:pesu_payu/src/utils/color/colors.dart';
import 'package:pesu_payu/src/utils/dropdown.dart';
import 'package:pesu_payu/src/utils/misctext_field.dart';
import 'package:pesu_payu/src/utils/my_button.dart';
import 'package:pesu_payu/src/utils/my_icons.dart';
import 'package:pesu_payu/src/utils/my_text.dart';
import 'package:pesu_payu/src/utils/toast.dart';
import 'package:pesu_payu/src/widget/alignrow_widget.dart';
// import 'package:pesupay/src/presentation/controller/payment_controller.dart'

// import 'package:pesua/app/modules/student_modules/online_payment/controllers/online_payment_controller.dart';
// import 'package:pesua/app/modules/student_modules/online_payment/views/subwidgets/terms_condition.dart';
// import 'package:pesua/app/modules/student_modules/online_payment/widgets/misctextfield.dart';
// import 'package:pesua/services/auth_service.dart/file_dowload.dart';
// import 'package:pesua/utils/properties.dart';
// import 'package:pesua/utils/widgets/align_row.dart';
// import 'package:pesua/utils/widgets/buttons/common_button.dart';
// import 'package:pesua/utils/widgets/dialogs/toast.dart';
// import 'package:pesua/utils/widgets/drop_down/dropdown.dart';
// import 'package:pesua/utils/widgets/loading_widget.dart';
// import 'package:pesua/utils/widgets/no_data_.dart';

class Miscellaneous extends GetView<OnlinePaymentController> {
  const Miscellaneous({super.key});

  @override
  Widget build(BuildContext context) {
    controller.ctypeValue=null;
    controller.ctypedrop.value=null;

   Function? downlaod;
    return Obx(() => controller.paymentloading.value
        ? const CircularProgressIndicator.adaptive()
        : Container(
            margin: const EdgeInsets.all(12.0),
            child: Column(
              children: [
//                 DropdownSearch<String>(

//     popupProps: const PopupProps.menu(
//       showSearchBox: true,
//         showSelectedItems: true,
//         // disabledItemFn: (String s) => s.startsWith('I'),
//     ),
//     items: controller.ctypeModel.value.ctype!.map((e) => e.name!).toList(),
//     dropdownDecoratorProps: const DropDownDecoratorProps(
//         dropdownSearchDecoration: InputDecoration(

//             labelText: "",
//             hintText: "",
//         ),
//     ),
//     onChanged: print,
//     // selectedItem: "Brazil",
// ),

// DropdownSearch<String>.multiSelection(
//     items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
//     popupProps: PopupPropsMultiSelection.menu(
//         showSelectedItems: true,
//         disabledItemFn: (String s) => s.startsWith('I'),
//     ),

                controller.ctypeModel.value.ctype == null
                    ? const SizedBox()
                    : Column(
                        children: [
                          // GetBuilder<OnlinePaymentController>(
                          //   builder: (c) {
                          //     return
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: ShowDropDown(
                              // itemHeight: 50,
                              icon: controller.miscloading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator.adaptive(
                                        strokeCap: StrokeCap.round,
                                        // backgroundColor: Properties.themeColor.d,
                                        value: null,
                                        strokeWidth: 3.0,
                                      ),
                                    )
                                  : const MyIcons(
                                      Icons.keyboard_arrow_down_rounded),
                              menuMaxHeight: Get.width * 1.2,
                              initialValue: controller.ctypedrop.value,
                              hintText: 'Select Category',
                              onChanged: (v) {
                                controller.stypedrop.value = null;
                                controller.stypeModel.value.clear();
                                controller.ctypedrop.value = v;
                              },
                              items: controller.ctypeModel.value.ctype!
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        onTap: () {
                                          controller.stypedrop.value = "";

                                          controller
                                              .getSTypeListResponse(e.id ?? 0);
                                          controller.ctypeValue = e.id;
                                        },
                                        child: MyText(
                                          e.name ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),


                     GetBuilder<OnlinePaymentController>(builder: (c)=>     c.stypeModel.value.isEmpty ||
                                  c.stypeModel.value[0].stype!.isEmpty
                              ? const SizedBox()
                              :Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 8.0),
                                    child: ShowDropDown(
                                      menuMaxHeight: Get.width * 1.2,
                                     
                                      initialValue: controller.stypedrop.value,
                                      hintText: 'Select Sub-Category',
                                      onChanged: (selectedValue) {
                                        controller.stypedrop.value =
                                            selectedValue;

                                        // Handle onChanged event if needed
                                        showModalBottomSheet(
                                          enableDrag: false,
                                          isScrollControlled: true,
                                          isDismissible: false,
                                          backgroundColor: Colors.white,
                                          elevation: 0.0,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(0),
                                            ),
                                          ),
                                          context: context,
                                          builder: (context) {
                                            return Obx(
                                              () => SafeArea(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom,
                                                  ),
                                                  child: SingleChildScrollView(
                                                      child: controller
                                                              .miscloading.value
                                                          ? const SizedBox(
                                                              height: 150,
                                                              child:
                                                                  CircularProgressIndicator.adaptive()
                                                                  
                                                                  )
                                                          : paymentConfirmation(
                                                              context,
                                                              0) // Replace with your bottom sheet content
                                                      ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      items: controller.stypeModel.value[0].stype!
                                          .map((e) => DropdownMenuItem(
                                                value: e.name,
                                                onTap: () {
                                           
                                                  controller
                                                      .getPaymentConfirmationResponse(
                                                          controller.ctypeValue,
                                                          e.id!);
                                               
                                                  controller.miscdescController
                                                      .clear();
                                                  controller.stypeValue = e.id;
                                                  
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.0,
                                                  // height: 90,
                                                  color: Colors.white,
                                                  child: MyText(
                                                    e.name ?? '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),)
                                
                        ],
                      ),

                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: RefreshIndicator.adaptive(
                    onRefresh: () async {
                      controller.getCTypeListResponse();
                      controller.getPaymentDetail();
                    },
                    child: controller.paymentloading.value
                        ? const CircularProgressIndicator.adaptive()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.paymentDetailModel.value
                                    .misDetails?.length ??
                                0,
                            itemBuilder: (context, int i) {
                              return annualFreeListTile1(context, i, downlaod);
                            }),
                  ),
                )
              ],
            ),
          ));
  }

  Widget annualFreeListTile1(BuildContext context, int i,Function? download ) {
     
    var status =
        controller.paymentDetailModel.value.misDetails?[i].verifiedStatus;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            controller.paymentDetailModel.value.misDetails?[i]
                                    .transactionDetails ??
                                "",
                            // style: Properties.textsStyles.text16_600
                            //     .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        MyText(controller.paymentDetailModel.value.misDetails?[i]
                                .transactionDate ??
                            ""),
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
                    MyText(
                        "${controller.paymentDetailModel.value.misDetails?[i].batchName ?? ""} "),
                    MyText(
                        "₹ ${controller.paymentDetailModel.value.misDetails?[i].amount ?? ""}"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyText("Status"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: (status == "Successful" || status == "Paid")
                              ? MyIcons(
                                  LucideIcons.checkCircle,
                                  color: ((status == "Successful")
                                      ? Colors.green
                                      : Colors.brown),
                                  size: 20,
                                )
                              : (status == "Pending")
                                  ? const MyIcons(
                                      LucideIcons.clock,
                                      color: Colors.grey,
                                      size: 20,
                                    )
                                  : (status == "Rejected" ||
                                          status == "Failure")
                                      ? const MyIcons(
                                          LucideIcons.xCircle,
                                          color: Colors.red,
                                          size: 20,
                                        )
                                      : const MyIcons(
                                          Icons.check_circle_outline_sharp,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                        ),
                        MyText(
                            " ${controller.paymentDetailModel.value.misDetails?[i].verifiedStatus.toString()}"),
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
                    const MyText("Transaction Id"),
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(
                            text:
                                "${controller.paymentDetailModel.value.misDetails?[i].transactionNo.toString()}"));
                        showToast('Transaction id copied');
                        // copied successfully
                      },
                      child: Row(
                        children: [
                          const MyIcons(
                            LucideIcons.copy,
                            color:MyColors.darkBlue1,
                            size: 16,
                          ),
                          // const MyText(" "),
                          MyText(controller.paymentDetailModel.value
                                  .misDetails?[i].transactionNo
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: MyText(
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
                    (controller.paymentDetailModel.value.misDetails?[i]
                                .verifiedStatus ==
                            "Successful"||controller.paymentDetailModel.value.misDetails?[i]
                                .recepitId!=0.0)
                        ? Center(
                          child: SizedBox(
                            height: 30,
                            width: 140,
                            child: 
                            
                            // DownloadFunction
                            // (
                            //   fileName: 'receipt',
                            //   url: 'https://www.pesuacademy.com/Academy/s/reports/Reports/StudentReceiptDownload/0/246320/12',
                            //   download:(_)=>download=_ ,
                            //   child:
                               MyButton(
                                  width: 70,
                                  // color: Properties.themeColor.darkBlue,
                                  height: 30,
                                  onPressed: () {
                                    download!.call();
                              
                            
                                  },
                                  label: "PDF Download"),
                            // ),
                          ),
                        )
                        : Container()
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

  Widget paymentConfirmation(BuildContext context, int i) {
    //  if (controller.paymentConfirmationModel.value
    //                           .miscellaneouspayment?[0].label !=
    //                       'NA' ||
    //                   controller.paymentConfirmationModel.value
    //                           .miscellaneouspayment?[0].label !=
    //                       '' ||
    //                   controller.paymentConfirmationModel.value
    //                           .miscellaneouspayment?[0].label !=
    //                       null){  controller.miscSubcopies.text=controller.paymentConfirmationModel.value
    //                             .miscellaneouspayment?[0].dataValue3??'';
    //                       }
    return controller.paymentConfirmationModel.value.isEmpty
        ? SizedBox(height: 130, child: Text( 'No Data Available'))
        : Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<OnlinePaymentController>(
                  builder: (c) {
                    return ListTile(
                      // tileColor: Properties.themeColor.darkBlue1,
                      title: const MyText(
                        "Payment Confirmation",
                        // style: Properties.textsStyles.text18_600.copyWith(
                        //   color: Properties.themeColor.white,
                        // ),
                      ),
                      trailing: IconButton(
                        icon: const MyIcons(
                          LucideIcons.x,
                          size: 18,
                          // color: Properties.themeColor.white,
                        ),
                        onPressed: () {
                          c.clean();
                        // controller.stypeModel.value.clear();
                        // controller.stypeModel.value[0].stype?.clear();
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  }
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AlignRowWidget(
                          firstWidget: const MyText(
                            'Academic year:',
                            style: TextStyle(fontSize: 16),
                          ),
                          secondWidget: MyText(
                            controller.paymentConfirmationModel.value[0]
                                    .miscellaneouspayment?[0].academicYear ??
                                "",
                            // style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        const Divider(),
                        AlignRowWidget(
                            firstWidget: const MyText(
                              'Payment Description:',
                              style: TextStyle(fontSize: 16),
                            ),
                            secondWidget: controller
                                            .paymentConfirmationModel
                                            .value[0]
                                            .miscellaneouspayment?[0]
                                            .paymentDesc !=
                                        '' ||
                                    controller
                                            .paymentConfirmationModel
                                            .value[0]
                                            .miscellaneouspayment?[0]
                                            .paymentDesc ==
                                        null
                                ? MyText(
                                    controller
                                            .paymentConfirmationModel
                                            .value[0]
                                            .miscellaneouspayment?[0]
                                            .paymentDesc
                                            .toString() ??
                                        "",
                                    // style: Properties.textsStyles.text14_600
                                    //     .copyWith(color: Colors.black),
                                  )
                                : MiscTextfield(
                                    validator: (v) {
                                      if (v == null || v.isEmpty || v == '') {
                                        return 'Description is empty!';
                                      }
                                      return null;
                                    },
                                    formKey: controller.discformKey,
                                    keyboardType: TextInputType.name,
                                    textController:
                                        controller.miscdescController,
                                  )),
                        const Divider(),
                      
                        AlignRowWidget(
                            firstWidget: const MyText(
                              'Amount:',
                              style: TextStyle(fontSize: 16),
                            ),
                            secondWidget: controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0]
                                        .amount !=
                                    "0"
                                ? MyText(
                                    '₹. ${controller.paymentConfirmationModel.value[0].miscellaneouspayment?[0].amount.toString()}', // Replace with your data
                                    style: const TextStyle(fontSize: 16),
                                  )
                                : MiscTextfield(
                                    formKey: controller.amountformKey,
                                    textController:
                                        controller.miscdynamicamount,
                                    maxlines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'^0|\.')),
                                      FilteringTextInputFormatter.allow(RegExp(
                                          r'^(?:[1-9]\d*|0)?(?:\.\d{1,2})?$'))
                                    ],
                                    onChanged: (v) {
                                      if (v == '') {
                                        controller.updatemiscAmount('0');
                                      }
                                      controller.updatemiscAmount(v);
                                    },
                                    validator: (v) {
                                      if (v == null || v.isEmpty || v == '') {
                                        return 'amount is empty!';
                                      }else if(v=='0'){
                                        return 'amount should be greater than 0';
                                      }
                                      return null;
                                    },
                                  ),
                            crossAxisAlignment: CrossAxisAlignment.center),
                        if (controller.paymentConfirmationModel.value[0]
                                .miscellaneouspayment?[0].dataValue1 !=
                            'NA')
                          Column(
                            children: [
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // MyText(
                                  //   'Data Value:',
                                  //   style: TextStyle(fontSize: 16),
                                  // ),

                                  MyText(
                                    controller.paymentConfirmationModel.value[0]
                                            .miscellaneouspayment?[0].dataValue1
                                            .toString() ??
                                        "", // Replace with your data

                                    style: const TextStyle(fontSize: 16),
                                  ),

                                  MyText(
                                      '₹. ${controller.paymentConfirmationModel.value[0].miscellaneouspayment?[0].dataValue2.toString() ?? ""}')
                                ],
                              ),
                            ],
                          ),
                        if (controller.paymentConfirmationModel.value[0]
                                .miscellaneouspayment?[0].label !=
                            'NA')
                          Column(children: [
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  "${controller.paymentConfirmationModel.value[0].miscellaneouspayment?[0].label.toString()}:",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                    child: MiscTextfield(
                                        formKey: controller.miscSubcopyformKey,
                                        validator: (v) {
                                          if (v == null ||
                                              v.isEmpty ||
                                              v == '') {
                                            return 'copies is empty!';
                                          }
                                          return null;
                                        },
                                        onChanged: (v) {
                                          log(v,
                                              error: '',
                                              name: " misc textfield cpoy");
                                          if (v == "") return;
                                          controller.addsubCopiesamount(
                                              amount: controller
                                                  .paymentConfirmationModel
                                                  .value[0]
                                                  .miscellaneouspayment![0]
                                                  .amount
                                                  .toString(),
                                              copy: int.tryParse(v)!);
                                        },
                                        // onChanged: (p0) => controller.updatemiscAmount(controller.paymentConfirmationModel.value[0].miscellaneouspayment?[0].amount),
                                        textController:
                                            controller.miscSubcopies)),
                              ],
                            ),
                          ]),
                        const Divider(),
                        AlignRowWidget(
                            firstWidget: const MyText(
                              'Instructions:',
                              style: TextStyle(fontSize: 16),
                            ),
                            secondWidget: HtmlWidget(controller
                                    .paymentConfirmationModel
                                    .value[0]
                                    .miscellaneouspayment?[0]
                                    .instructions
                                    .toString() ??
                                ""),
                            crossAxisAlignment: CrossAxisAlignment.start),
                        const Divider(),
                        GetBuilder<OnlinePaymentController>(
                          initState: (state) => controller.updatemiscAmount(
                              controller.paymentConfirmationModel.value[0]
                                  .miscellaneouspayment?[0].amount),
                          builder: (c) => AlignRowWidget(
                              firstWidget: const MyText(
                                'Total Amount:',
                                style: TextStyle(fontSize: 16),
                              ),
                              secondWidget:
                                  MyText(controller.miscamount.value.toString())),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
                GetBuilder<OnlinePaymentController>(
                    builder: (c) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                  value: c.tcflag.value,
                                  onChanged: (value) {
                                    c.tcflag.value = !c.tcflag.value;
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
                                        text: 'terms and conditions',
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
                                        text: '.',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ])),


                controller.tcflag.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyButton(
                            onPressed: () async {


                              
                              var amount =
                                  controller.miscamount.value.toString();
                              log(amount, error: '', name: "PPPPPPPP");
                              try {
                                if (controller
                                        .miscSubcopyformKey.currentState !=
                                    null) {
                                  if (controller
                                      .miscSubcopyformKey.currentState!
                                      .validate()) {
                                 controller.startPayment(
                                    instId:controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0].instId.toString() ,
                                    miscDescription: controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0].paymentDesc
                                        
                                        .toString(),
                                    merchantKey: controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0]
                                        .paymentKey
                                        .toString(),
                                    context: context,
                                    amount: controller.miscamount.value,
                                    cat: controller.ctypeValue.toString(),
                                    subcat: controller.stypeValue.toString(),
                                    academicYearId: controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0]
                                        .academicYearId
                                        .toString(),
                                  );
                                  }
                                } else if (controller
                                            .amountformKey.currentState !=
                                        null &&
                                    controller.discformKey.currentState !=
                                        null) {
                                  if (controller.amountformKey.currentState!
                                          .validate() &&
                                      controller.discformKey.currentState!
                                          .validate()) {
                                                controller.startPayment(
                                                  instId:controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0].instId.toString() ,
                                    
                                    miscDescription: controller.miscdescController.value.text,
                                    merchantKey: controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0]
                                        .paymentKey
                                        .toString(),
                                    context: context,
                                    amount: controller.miscamount.value,
                                    cat: controller.ctypeValue.toString(),
                                    subcat: controller.stypeValue.toString(),
                                    academicYearId: controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0]
                                        .academicYearId
                                        .toString(),
                                  );
                                   
                                  }
                                } else {
                                  // Function? download;
                                  controller.startPayment(
                                    instId:controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0].instId.toString() ,
                                    miscDescription: controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment?[0]
                                        .paymentDesc
                                        .toString(),
                                    merchantKey: controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0]
                                        .paymentKey
                                        .toString(),
                                    context: context,
                                    amount: controller.miscamount.value,
                                    cat: controller.ctypeValue.toString(),
                                    subcat: controller.stypeValue.toString(),
                                    academicYearId: controller
                                        .paymentConfirmationModel
                                        .value[0]
                                        .miscellaneouspayment![0]
                                        .academicYearId
                                        .toString(),
                                  );
                                  
                                }
                                // controller.
                                //  print( controller.updatemiscAmount(""));
                              } catch (e, s) {
                                log(e.toString(), error: s, name: "pay button");
                              }
                            },
                            label: "Pay"),
                      )
                    : const SizedBox(),
              ],
            ),
          );
  }
  
}

