// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:number_to_text_converter/number_to_text_converter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:pesu_payu/src/presentation/views/online_payment_view.dart';
import 'package:pesu_payu/src/utils/enums/misc_enums.dart';
import 'package:pesu_payu/src/utils/page_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/TransactionModel.dart';
import '../../data/models/c_type_model.dart';
import '../../data/models/payment_confirmation_model.dart';
import '../../data/models/payment_detail_model.dart';
import '../../data/models/s_type_model.dart';
import '../../data/repo/payment_repo.dart';
import '../../utils/enums/rxtstatus.dart';
import '../../utils/toast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class OnlinePaymentController extends GetxController {
  // OnlinePaymentController( this._dio);
  static const Uuid _uuid = Uuid();
  OnlinePaymentController(this._dio, this._preferences, this._cancelToken);
  final Dio _dio;
  late final SharedPreferences _preferences;
  late PaymentDetailRepo _paymentDetailRepo;
// final PaymentDetailService _api=PaymentDetailService(_dio);
  ///stores trxn Id
  final Rx<dynamic> pesuTxnId = Rx<dynamic>(null);

  ///stors ptrxn time in case user caacelled trxn
  final Rx<dynamic> trxnTime = Rx<dynamic>(null);

  final paymentDetailModel = Rx<PaymentDetailModel>(PaymentDetailModel());
  final transactionDetailModel =
      Rx<TransactionDetailModel>(TransactionDetailModel());
  final cTypeModel = Rx<CTypeModel>(CTypeModel());
  final sTypeModel = Rx<List<STypeModel>>([]);
  final paymentConfirmationModel = Rx<List<PaymentConfirmModel>>([]);
  List<dynamic> emptystype = [];
  // final connectionController = Get.put(ConnectionController());
  var rejectedCount = 0.obs;
  var pendingCount = 0.obs;
  var paidCount = 0.obs;

  ///confirm amount to pay
  final partialAmountController = TextEditingController();
  RxBool isotherAmountNotAvailable = false.obs;
  RxBool otherAmountflag = false.obs;
  String confirmAmountToPay = '';

  ///formKey
  final amountformKey = GlobalKey<FormState>();
  final discformKey = GlobalKey<FormState>();
  final miscSubcopyformKey = GlobalKey<FormState>();

  ///misc paymnet page
  final miscSubcopies = TextEditingController();
  final miscdescController = TextEditingController();
  final miscdynamicamount = TextEditingController();

  String miscConfirmAmountToPay = '';
  final Rx<dynamic> miscAmount = Rx<dynamic>(null);
  //
  final paymentLoading = Rx<bool>(false);

  final RxBool miscLoading = RxBool(false);

//terms and conditions
  Rx<dynamic> termsandcondition = Rx<dynamic>(null);
  Rx<dynamic> termsLoading = Rx<dynamic>(null);

  ///
  ScreenshotController screenshotController = ScreenshotController();

  ///
  Rx<dynamic> ctypedrop = Rx(null);
  Rx<dynamic> stypedrop = Rx(null);
//

  ValueNotifier<Map> payuresponse = ValueNotifier<Map>({});

//
  final rxRequestStatus = RequestStatus.LOADING.obs;
  void setRxRequestStatus(RequestStatus _value) =>
      rxRequestStatus.value = _value;

//
  final payupaymentstarted = RxBool(false);
  final count = 0.obs;
  RxBool annulatcflag = false.obs;
  RxBool misctcflag = false.obs;
  dynamic ctypeValue;
  dynamic stypeValue;
  // dynamic partialAmount;
  RxBool pcflag = false.obs;

  ///amount in words
  Rx<dynamic> amountInWords = Rx<dynamic>(null);
  var converter = NumberToTextConverter.forIndianNumberingSystem();

  CancelToken _cancelToken;

  @override
  void onInit() async {
    // Check internet connection with singleton (no custom values allowed)
    await execute(InternetConnectionChecker());

    // Create customized instance which can be registered via dependency injection
    final InternetConnectionChecker customInstance =
        InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 1),
      checkInterval: const Duration(seconds: 1),
    );

    // Check internet connection with created instance
    await execute(customInstance);
    _paymentDetailRepo = PaymentDetailRepo(_dio, _cancelToken);

    super.onInit();
  }

  @override
  void onReady()async {
   await getPaymentDetail();
    getCTypeListResponse();
    super.onReady();
    getTermsAndConditions();
  }


/// This [userInfo] saves all user info of Usder passed from app 
  ValueNotifier<Map<String, dynamic>> userInfo = ValueNotifier({});
// Future<ValueNotifier<Map<String, dynamic>> > getUserInfo({required String name,required int instId, required String email,required String mobileNumber, required String userId, required String loginId}) async {

//   return userInfo=ValueNotifier({
//     'name': name,
//     'email': email,
//     'mobileNumber': mobileNumber,
//     'loginId': loginId,
//     'userId': userId,
//     'instId': instId,
//   });
// }

  @override
  void onClose() {
  userInfo.dispose();
  payuresponse.dispose();
    miscSubcopies.dispose();
    miscdescController.dispose();
    miscdynamicamount.dispose();
    payuresponse.dispose();
    super.onClose();
  }


//TODO Just COnfirm whether all Values are clearing or not 
/// This Function clear miscellaneouns fee payments  Values and refresh to ber used again
  void clean() {
     trxnTime.value=null;
    pesuTxnId.value=null;
    misctcflag.value = false;
    miscSubcopies.clear();
    miscdescController.clear();
    miscdynamicamount.clear();
    miscAmount.value = null;
    // sTypeModel.value.clear();
    update(['counterId']);
  }



//TODO Just COnfirm whether all Values are clearing or not 
/// This Function clear annual fee payments  Values and refresh to ber used again
  void annualFeeClean() {
    trxnTime.value=null;
    pesuTxnId.value=null;
    confirmAmountToPay = '';
    otherAmountflag.value = false;
    // isotherAmountNotAvailable.value = false;
    annulatcflag.value = false;
    amountInWords.value = null;
    partialAmountController.clear();
  }



  /// This Functions retuns payu configs
  ///
  /// if any modification nedd to do in payu checkout page
  Map createPayUConfigParams() {
    try {
      // var paymentModesOrder = [
      //   {"UPI": "Google Pay"},
      //   {"UPI": "PHONEPE"},
      //   {"UPI": "PAYTM"},
      //   {"CARD": ""},
      //   {"UPI_INTENT": ""},
      //   {"NB": ""},
      // ];

      // var cartDetails = [
      //   {"Fee": "5%"},
      //   {"Delivery Date": "25 Dec"},
      //   {"Status": "In Progress"}
      // ];
      // var enforcePaymentList = [
      //   {"payment_type": "CARD"},
      //   {"payment_type": "L1_OPTION"},
      //   {"payment_type": "NB"},
      //   {"payment_type": "UPI"},
      //   {"payment_type": "UPI_INTENT"},
      //   {"payment_type": "NEFTRTGS",},
      // ];


///Custom Notes is just Caution message for users while they are doing Transaction
      var customNotes = [
        {
          "custom_note":
              "Please Don't click back Button while Transaction is processing",
          "custom_note_category": [
            PayUPaymentTypeKeys.upi,
            PayUPaymentTypeKeys.card,
            PayUPaymentTypeKeys.nb,
          ]
        },
        {
          "custom_note":
              "Please Don't close the app while Transaction is processing",
          "custom_note_category": [
            PayUPaymentTypeKeys.upiIntent,
            PayUPaymentTypeKeys.upi
          ]
        }
      ];


/// Here We are passing config values to payu as required by Payu
      var payUCheckoutProConfig = {
        PayUCheckoutProConfigKeys.primaryColor: "#4994EC",
        PayUCheckoutProConfigKeys.secondaryColor: "#FFFFFF",
        PayUCheckoutProConfigKeys.merchantName: "PES University",
        PayUCheckoutProConfigKeys.merchantLogo: "@drawable/peslogo",
        PayUCheckoutProConfigKeys.showExitConfirmationOnCheckoutScreen: true,
        PayUCheckoutProConfigKeys.showExitConfirmationOnPaymentScreen: true,
        // PayUCheckoutProConfigKeys.cartDetails: cartDetails,

        // PayUCheckoutProConfigKeys.paymentModesOrder: paymentModesOrder,
        PayUCheckoutProConfigKeys.merchantResponseTimeout: 50000,
        PayUCheckoutProConfigKeys.customNotes: customNotes,
        PayUCheckoutProConfigKeys.autoSelectOtp: true,
        // PayUCheckoutProConfigKeys.enforcePaymentList: enforcePaymentList,
        PayUCheckoutProConfigKeys.waitingTime: 50000,
        PayUCheckoutProConfigKeys.autoApprove: true,
        PayUCheckoutProConfigKeys.merchantSMSPermission: true,
        PayUCheckoutProConfigKeys.showCbToolbar: true,
      };
      return payUCheckoutProConfig;
    } catch (e, s) {
      log(e.toString(), error: s, name: 'name');
      throw Exception();
    }
  }



  ///
//
  final RxBool amountVerifying = RxBool(false);
//TODO Please verify once more for  more accurate data parsing 
  /// this function just another function to check and confirm payments amount and all fields 
  /// Whether amount is empty or less tha 1 and update values accordingly
  /// 
  Future<bool> checkandConfirmAnnualAmount(
      STUDENTPAYMENTDETAILS studentDetails) async {
    amountVerifying.value = true;
    confirmAmountToPay = '';
    try {
      if (otherAmountflag.value) {
        if (isotherAmountNotAvailable.value) {
          if (partialAmountController.value.text.isEmpty) {
            // else if (_.partialAmountController.text.isEmpty) {
            amountVerifying.value = false;
            showToast('amount is empty');
            // }
            return false;
          } else if (partialAmountController.text.isNotEmpty) {
            var number =
                partialAmountController.value.text.toIntEither(() => false);

            number.fold((l) {
              amountVerifying.value = false;
              return false;
            }, (amount) {
              // if (amount < 1) return false;
              // if(amount<)

              if (amount > studentDetails.dueAmount!) {
                showToast('Amount is more than your total due amount');
                amountVerifying.value = false;
                return false;
              } else if (amount < 5000) {
                showToast('Minimum amount should be Rs. 5000');
                amountVerifying.value = false;
                return false;
              }
              confirmAmountToPay = amount.toString();
              amountVerifying.value = false;
              return true;
            });
          }
        } else if (isotherAmountNotAvailable.value == false) {
          final amount = studentDetails.minAmount ?? 0.0;
          if (amount < 1) {
            showToast("amount can't be zero");
            amountVerifying.value = false;
            return false;
          }
          confirmAmountToPay = amount.toString();
          amountVerifying.value = false;
          return true;
        }
      } else {
        double? amount = studentDetails.totalDue ?? 0.0;

        if (amount < 1) {
          amountVerifying.value = false;
          showToast("amount can't be zero");
          return false;
        } else {
          confirmAmountToPay = amount.toString();
          amountVerifying.value = false;
          return true;
        }
        // confirmAmountToPay = studentDetails.dueAmount.toString();
        // amountVerifying.value=false;
        // return true;
      }
    } catch (e) {
      amountVerifying.value = false;
      print(e);
      return false;
    }
    amountVerifying.value = false;
    update();
    return false;
  }






//TODO Please verify once more for  more accurate data parsing 
  final RxBool checkAndConfirmMiscAmountloading = RxBool(false);
  /// this function just another function to check and confirm payments amount and all fields 
  /// Whether amount is empty or less tha 1 and update values accordingly
  /// 
  Future<bool> checkAndConfirmMiscAmount(
      Miscellaneouspayment paymentDetails) async {
    miscConfirmAmountToPay = '';
    // const bool value = false;

    checkAndConfirmMiscAmountloading.value = true;
    try {
      final bool isDescEmpty = paymentDetails.paymentDesc == '' ||
          paymentDetails.paymentDesc == null;
      final bool isAmountEmpty = paymentDetails.amount == '' ||
          paymentDetails.amount == null ||
          paymentDetails.amount == '0';
      final bool isLabelEmpty = paymentDetails.label == null ||
          paymentDetails.label == 'NA' ||
          paymentDetails.label == '';
      final bool isDataValue1Empty = paymentDetails.dataValue1 == 'NA' ||
          paymentDetails.dataValue1 == null ||
          paymentDetails.dataValue1 == '';

      late PaymentDetailState state;
      if (isDescEmpty &&
          isAmountEmpty &&
          amountformKey.currentState != null &&
          discformKey.currentState != null &&
          miscSubcopyformKey.currentState == null) {
        state = PaymentDetailState.descAmtEmpty;
      } else if (!isAmountEmpty && !isDescEmpty) {
        if (isLabelEmpty && isDataValue1Empty) {
          state = PaymentDetailState.amountDesNotEmpty;
        } else if (!isLabelEmpty && !isDataValue1Empty) {
          state = PaymentDetailState.misSubCopyReq;
        }
      }

      switch (state) {
        case PaymentDetailState.descAmtEmpty:
          final amount = miscdynamicamount.value.text.toIntEither(() => false);
          return amount.fold((l) => false, (total) {
            if (total < 1) return false;
            miscConfirmAmountToPay = total.toString();

            checkAndConfirmMiscAmountloading.value = false;
            update(['checkAndConfirmMiscAmountloading']);
            return true;
          });

        case PaymentDetailState.amountDesNotEmpty:
          final apiAmount = miscAmount.toString().toIntEither(() => false);
          return apiAmount.fold((l) => false, (r) {
            if (r < 1) return false;
            miscConfirmAmountToPay = r.toString();
            update(['addsubCopiesamount']);
            checkAndConfirmMiscAmountloading.value = false;
            update(['checkAndConfirmMiscAmountloading']);
            return true;
          });

        case PaymentDetailState.misSubCopyReq:
          final totalAmount =
              miscAmount.value.toString().toDoubleEither(() => false);
          return totalAmount.fold((l) {
            print('6666 $l');
            return false;
          }, (rupees) {
            print(rupees);
            if (rupees < 1) return false;

            miscConfirmAmountToPay = rupees.toString();
            checkAndConfirmMiscAmountloading.value = false;
            update(['checkAndConfirmMiscAmountloading']);
            return true;
          });
      }
    } catch (e) {
      log(e.toString(), error: e, name: 'name');
      checkAndConfirmMiscAmountloading.value = false;
      update(['checkAndConfirmMiscAmountloading']);
      return false;
    }

    // return false;
  }

  // Future<bool> checkandConfirmMiscAmount(
  //     Miscellaneouspayment paymentDetails) async {
  //   miscConfirmAmountToPay = '';
  //   const bool value =false;
  //   try {
  //     final bool isdescEmpty = paymentDetails.paymentDesc == '' ||
  //         paymentDetails.paymentDesc == null;
  //     final bool isamountEmpty = paymentDetails.amount == '' ||
  //         paymentDetails.amount == null ||
  //         paymentDetails.amount == '0';
  //         final bool isLabelEmpty =paymentDetails.label==null||paymentDetails.label=='NA'||paymentDetails.label=='';
  //         final bool isDataValue1Empty = paymentDetails.dataValue1=='NA'||paymentDetails.dataValue1==null||paymentDetails.dataValue1=='';
  //         final apiAmount = paymentDetails.amount!.toIntEither(()=>false);
  //     if (isdescEmpty && isamountEmpty&&amountformKey.currentState!=null&&discformKey.currentState!=null&&miscSubcopyformKey.currentState==null) {
  //       print('1111111');
  //       final amount= miscdynamicamount.value.text.toDoubleEither(() => false);
  //       amount.fold((l) => false, (total) {
  //         if(total<1)return false;
  //         miscConfirmAmountToPay = total.toString();
  //         return true;
  //       });

  //     }else if(!isamountEmpty&&!isdescEmpty){

  //       if(isLabelEmpty&&isDataValue1Empty){
  //         apiAmount.getRight();
  //         apiAmount.fold((l) => false,(r){
  //           if(r<1) return false;
  //           miscConfirmAmountToPay = r.toString();
  //           return true;
  //         });

  //               // print('3333333');
  //               // return false;
  //       }else if(!isLabelEmpty&&!isDataValue1Empty){

  //         print('4444444');
  //       apiAmount.fold((l) {
  //         print('6666 $l');
  //         return false;
  //       }, (rupees) {
  //         print(rupees);
  //         if(rupees<1) return false;
  //         miscConfirmAmountToPay = rupees.toString();
  //         return true;
  //       });
  //     // return false;
  //       }
  //       // print('2222222');

  //       // miscConfirmAmountToPay=

  //     }
  //     return value;
  //     //else if()
  //   } catch (e) {
  //     log(e.toString(), error: e, name: 'name');
  //     return false;
  //   }

  //   // return false;
  // }

  ///This Funtion Just Gets Data from misc payment pay Screen and Pass to Payments Page
  Future<void> startPayment(
      {required String amount,
      required String cat,
      required String subcat,
      required String academicYearId,
      String? miscDescription,
      String? instId,
      required String merchantKey,
      required BuildContext context}) async {
    var miscCatSubcat = "1&$cat&$subcat&2&2&1";
    Get.back();

    Navigator.push(
      context,
      FullDialogRoute(
        builder: ((context) => PesuPaymentPage(
              instId: instId,
              paymentDescription: miscDescription,
              isMiscpayment: true,
              dueAmount: amount,
              feeName: miscDescription,
              misctype: miscCatSubcat,
              merchantKey: merchantKey,
              academicyear: academicYearId,
            )),
      ),
    );
  }

  /// Get All payment details from server
  Future<void> getPaymentDetail() async {
    if (rxRequestStatus.value != RequestStatus.LOADING) {
      setRxRequestStatus(RequestStatus.LOADING);
    }
    try {
      // paymentLoading.value = true;
      var response =
          await _paymentDetailRepo.getPaymentDetail(userInfo.value['userId']!);
      // if (response.statuscode == 200) {
      response.fold((error) {
        // paymentLoading.value = false;
        setRxRequestStatus(RequestStatus.ERROR);
      }, (res) {
        paymentDetailModel.value = PaymentDetailModel.fromJson(res);
        pendingCount.value = paymentDetailModel.value.sTUDENTPAYMENTDETAILS!
            .where((detail) =>
                detail.verifiedStatus == 'Pending' ||
                detail.verifiedStatus == 'Partially Paid' ||
                detail.paymentStatus == 'Partially Paid')
            .length;
        // paidCount.value = paymentDetailModel.value.sTUDENTPAYMENTDETAILS!
        //     .where((detail) =>
        //         detail.verifiedStatus == 'Paid' ||
        //         detail.verifiedStatus == "Successful" ||
        //         detail.verifiedStatus == 'Rejected')
        //     .length;
        setRxRequestStatus(RequestStatus.SUCCESS);
      });
      // rejectedCount.value = paymentDetailModel.value.sTUDENTPAYMENTDETAILS!
      //     .where((detail) => detail.verifiedStatus == 'Rejected')
      //     .length;
      // }
      // paymentLoading.value = false;
    } catch (e, s) {
      setRxRequestStatus(RequestStatus.ERROR);
      log('$e', error: s);
      // paymentLoading.value = false;
    }
  }

  /// Get all transaction detils in transaction details view page
  ///
  /// of payments user has done in past of that demand Id
  Future<void> getTransactionDetail(
    dynamic academicYearId,
    dynamic feeType,
  ) async {
    try {
      paymentLoading.value = true;
      var response = await _paymentDetailRepo.getTransactionDetail(
          academicYearId, feeType, userInfo.value['userId']);
      // if (response.statuscode == 200) {
      response.fold((left) {
        paymentLoading.value = false;
      }, (res) {
        transactionDetailModel.value = TransactionDetailModel.fromJson(res);
      });

      // }
      paymentLoading.value = false;
    } catch (e, s) {
      log('$e', error: s);
      paymentLoading.value = false;
    }
  }

  void setisotherAmountAvailable(int annualfeeIndex) {
    isotherAmountNotAvailable.value = paymentDetailModel
                .value.sTUDENTPAYMENTDETAILS![annualfeeIndex].minAmount ==
            null ||
        paymentDetailModel
                .value.sTUDENTPAYMENTDETAILS![annualfeeIndex].minAmount ==
            0.0;
  }

  ///this Function update amount in words in text
  void updateAnount() {
    if (partialAmountController.value.text.isNotEmpty) {
      amountInWords.value = converter
          .convert(int.tryParse(
              partialAmountController.value.text.removeAllWhitespace)!)
          .toUpperCase();
    }
    update(['amountinwords']);
  }

  ///This function Generates Unique TransactionId Every Time User clicks
  ///Pay Button
  Future<String> getUuidTrxnId() async {
    try {
      pesuTxnId.value = null;
      var txnId = _uuid.v7obj().toString();

      pesuTxnId.value = txnId.substring(14);
      log('${pesuTxnId.value}', name: 'txnId');
      return txnId;
    } catch (e, s) {
      log('$e', error: s, name: 'uuid');
      throw Exception();
    }
  }

  /// This Function Generates Gives Treansaction time when user has cancelled trasanction
  ///
  /// or
  ///
  /// transaction got failed or any Error happened to show in Payment status
  ///
  ///
  Future<String> getTrxnTime() async {
    try {
      trxnTime.value = null;
      var now = DateTime.now();
      // DateTime.parse(formattedString);

      // Define the desired format
      DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

      // Format the current date and time
      String formattedDate = formatter.format(now);
      trxnTime.value = formattedDate;
      return formattedDate;
    } catch (e, s) {
      trxnTime.value = null;
      log('$e', error: s, name: 'trxnTime');
      throw Exception();
    }
  }

  ///Get Dynamic Hashes from server as per SDK demands for payments
  Future<Map> getserverDynamicHash({
    required String hash,
    required String trxnId,
    required String misctype,
    required String academicyear,
    required String demandId,
    required String dueAmount,
    required String feeName,
    required String fdFeeTypeId,
    required String merchantKey,
    String? instId,
  }) async {
    payupaymentstarted.value = true;
    var serverhash;
    try {
      var response = await _paymentDetailRepo.getDynamicHash(
          name: userInfo.value['name'],
          email: userInfo.value['email'],
          mobileNumber: userInfo.value['mobileNumber'],
          userId: userInfo.value['userId'],
          loginId: userInfo.value['loginId'],
          txnId: trxnId,
          hash: hash,
          academicyear: academicyear,
          misctype: misctype,
          demandId: demandId,
          dueAmount: dueAmount,
          feeName: feeName,
          fdFeeTypeId: fdFeeTypeId,
          instId: instId ?? userInfo.value['instId'].toString(),
          merchantKey: merchantKey);
      response.fold((error) {
        payupaymentstarted.value = false;

        throw Exception(error);
      }, (hashresponse) async {
        serverhash = hashresponse;
        log(hashresponse.toString(), error: '', name: "payupaymentstarted");
        return serverhash;
      });
    } catch (e, s) {
      payupaymentstarted.value = false;
      log('$e', error: s, name: 'cont');

      return {"error": "$e"};
    }
    return serverhash;
  }

  /// For Sharing Screenshot of paymnets status
  Future<void> shareScreenshot() async {
    try {
      final image = await screenshotController.capture();
      if (image != null) {
        final directory = await getTemporaryDirectory();
        final imagePath =
            await File('${directory.path}/screenshot.png').create();
        await imagePath.writeAsBytes(image);
        await Share.shareXFiles([
          XFile.fromData(image, name: 'screenshot.png', mimeType: 'image/png')
        ]);
      }
    } catch (e) {
      debugPrint('print------------PESU---------- : ${e.toString()}');
    }
  }

  /// Gets and returns DownLoad Paths from device
  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');

        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      debugPrint("Cannot get download folder path");
    }
    return directory?.path;
  }

  ///This function Donwload receipts or payments pdf from server
  final RxBool downloadStarted = RxBool(false);
  Future<void> download(String trxId) async {
    try {
      downloadStarted.value = true;
      final directory = await getDownloadPath(); //from path_provide package
      String fileName = '/$trxId.png';
      print(directory);
      var path = '$directory';

      final String? result = await screenshotController.captureAndSave(
          path, //set path where screenshot will be saved
          fileName: fileName);

      log(result.toString());
      downloadStarted.value = false;
      showToast('Downloaded Successfully');
    } catch (e) {
      downloadStarted.value = false;
      log(e.toString());
      showToast('Download Failed');
    }
  }

  ///This Fucntion Get Category dropdown Data for miscellaneous payments
  Future<void> getCTypeListResponse() async {
    try {
      // paymentLoading.value = true;
      cTypeModel.value.ctype?.clear();
      var response =
          await _paymentDetailRepo.getCTypeList(userInfo.value['instId']!);

      response.fold((error) {
        paymentLoading.value = false;
      }, (response) {
        cTypeModel.value = CTypeModel.fromJson(response);

        // paymentLoading.value = false;
      });
      // }
      // paymentLoading.value = false;
    } catch (e, s) {
      log('$e', error: s);
      // paymentLoading.value = false;
    }
  }

  ///This Fucntion Get Sub-Category dropdown Data for miscellaneous payments after User selects [getCTypeListResponse] Category dropdown value
  Future<void> getSTypeListResponse(int id) async {
    try {
      // paymentLoading.value = true;
      sTypeModel.value.clear();

      miscLoading.value = true;
      var response =
          await _paymentDetailRepo.getSTypeList(id, userInfo.value['instId']);
      response.fold((error) {
        miscLoading.value = false;
      }, (response) {
        print(response);
        sTypeModel.value.add(STypeModel.fromJson(response));
        if (sTypeModel.value[0].stype!.isEmpty) showToast('No Data');
        miscLoading.value = false;
        // log('${sTypeModel.value.stype!}', name: 'stpe');
      });
      // }
      // paymentLoading.value = false;
    } catch (e, s) {
      log('$e', error: s);
      miscLoading.value = false;
    }
  }

  /// This Function Gets payments details and payment type whenn user has selected [getSTypeListResponse]
  ///
  Future<void> getPaymentConfirmationResponse(
    int ctypeId,
    int stypeId,
  ) async {
    try {
      miscLoading.value = true;
      paymentConfirmationModel.value.clear();
      var response = await _paymentDetailRepo.getPaymentConfirmationDetail(
          ctypeId, stypeId, userInfo.value['userId']);

      response.fold((error) {
        miscLoading.value = false;
      }, (response) {
        paymentConfirmationModel.value
            .add(PaymentConfirmModel.fromJson(response));
        miscLoading.value = false;
        if (paymentConfirmationModel.value[0].miscellaneouspayment != []) {
          pcflag.value = true;
        } else {
          pcflag.value = false;
        }
        miscLoading.value = false;
      });

      // }
      // paymentLoading.value = false;
    } catch (e, s) {
      log('$e', error: s);
      miscLoading.value = false;
    }
  }
//

  /// this funntion add amount as per subcopies user require and adds amount to final amount [miscAmount]
  void addsubCopiesamount({int? copy, required String amount}) {
    // if(copy==0){}else{
    miscAmount.value = null;
    try {
      final value = amount.toDoubleEither(() => throw Exception());
      final noOfCopy =
          miscSubcopies.value.text.toIntEither(() => throw Exception());
      final copyAmount = paymentConfirmationModel
          .value[0].miscellaneouspayment![0].dataValue2!
          .toDoubleEither(() => throw Exception());

      value.fold((l) => null, (amount) {
        noOfCopy.fold((l) => throw Exception(), (copy) {
          copyAmount.fold((l) => throw Exception(), (copyAmount) {
            miscAmount.value = amount + copy * copyAmount;
            print(miscAmount);
          });
        });
        // miscAmount.value = r
        // ;
      });

      log(value.toString(), error: '', name: "amount");
      update(['addsubCopiesamount']);
    } catch (e) {
      miscAmount.value = null;
    }
  }

  /// This Function Gives and Updates initial amount [miscAmount] and no of copies [miscSubcopies] coming from servver
  void updatemiscAmount(String? amout) {
    try {
      if (paymentConfirmationModel.value[0].miscellaneouspayment?[0].label !=
          'NA') {
        miscSubcopies.text = paymentConfirmationModel
                .value[0].miscellaneouspayment?[0].dataValue3 ??
            '';
      }

      miscAmount.value = null;
      if (amout == "null" || amout == null || amout == "0") {
        miscAmount.value = miscdynamicamount.value.text;
      } else {
        miscAmount.value = null;

        miscAmount.value = amout;
      }
    } catch (e) {
      if (kDebugMode) {
        print('update amoutnt ' + "$e");
      }
    }
    update(['addsubCopiesamount']);
  }

  ///This Function gets Terms & conditions from server api and Stores json in local Storage [getLocaltermsConditions]
  ///
  ///In Case if any Exception or Internet is not There
  Future<void> getTermsAndConditions() async {
    termsLoading.value = true;
    var localTermsandCond = await getLocaltermsConditions();
    try {
      var response =
          await _paymentDetailRepo.getPaymenttandc(userInfo.value['instId']);
      response.fold((error) {
        if (kDebugMode) {
          print('error $error');
        }
        termsLoading.value = false;
        throw Exception(error);
      }, (res) {
        saveLocaltermsConditions(res);
        termsandcondition.value = res['termsandcondtions'][0]['description'];
        log(termsandcondition.value.toString(), name: 'pppppppp');
        termsLoading.value = false;
      });
    } catch (e, s) {
      log(e.toString(), name: 'pppppppp', error: s);
      if (localTermsandCond != null) {
        var result = jsonDecode(localTermsandCond);
        termsandcondition.value = result['termsandcondtions'][0]['description'];
        termsLoading.value = false;
      } else {
        termsLoading.value = false;
      }

      if (kDebugMode) {
        print('getTermsAndConditions $e');
      }
    }
    update(['terms']);
  }

  /// Saves Terms and Conditions
  Future<bool> saveLocaltermsConditions(dynamic value) async {
    final bool done =
        await _preferences.setString("terms-cond", jsonEncode(value));
    return done;
  }

  /// Gets and returns locally Saved terms nad conditons
  Future<String?> getLocaltermsConditions() async {
    final String? data = _preferences.getString("terms-cond");

    return data;
  }

  /// This Functions emits Whtther Internet is Available or not
  Future<void> execute(
    InternetConnectionChecker internetConnectionChecker,
  ) async {
    // Simple check to see if we have Internet
    // ignore: avoid_print
    print('''The statement 'this machine is connected to the Internet' is: ''');
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    // ignore: avoid_print
    print(
      isConnected.toString(),
    );
    // returns a bool

    // We can also get an enum instead of a bool
    // ignore: avoid_print
    print(
      'Current status: ${await InternetConnectionChecker().connectionStatus}',
    );
    // Prints either InternetConnectionStatus.connected
    // or InternetConnectionStatus.disconnected

    // actively listen for status updates
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            // ignore: avoid_print
            print('Data connection is available.');
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            print('You are disconnected from the internet.');
            break;
        }
      },
    );

    // close listener after 30 seconds, so the program doesn't run forever
    await Future<void>.delayed(const Duration(seconds: 30));
    await listener.cancel();
  }
}
