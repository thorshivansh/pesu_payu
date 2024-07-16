// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_to_text_converter/number_to_text_converter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';

// import 'package:pesua/app/data/api/api_client.dart';
// import 'package:pesua/app/data/models/payment_models/TransactionModel.dart';
// import 'package:pesua/app/data/models/payment_models/c_type_model.dart';
// import 'package:pesua/app/data/models/payment_models/payment_confirmation_model.dart';
// import 'package:pesua/app/data/models/TransactionModel.dart';
// import 'package:pesua/app/data/models/payment_models/payment_detail_model.dart';
// import 'package:pesua/app/data/models/payment_models/s_type_model.dart';
// import 'package:pesua/app/modules/student_modules/online_payment/views/payment_page.dart';
// import 'package:pesua/app/data/models/payment_detail_model.dart';
// import 'package:pesua/utils/connectivity.dart';
// import 'package:pesua/utils/custom_page/fullpage_dialog.dart';
// import 'package:pesua/utils/locator.dart';
// import 'package:pesua/utils/properties.dart';
// import 'package:pesua/utils/rxstatus.dart';
import 'package:pesupay/src/data/models/TransactionModel.dart';
import 'package:pesupay/src/data/models/c_type_model.dart';
import 'package:pesupay/src/data/models/payment_confirmation_model.dart';
import 'package:pesupay/src/data/models/payment_detail_model.dart';
import 'package:pesupay/src/data/models/s_type_model.dart';
import 'package:pesupay/src/data/repo/payment_repo.dart';
import 'package:pesupay/src/presentation/views/pesupay_page.dart';
import 'package:pesupay/src/utils/enums/rxtstatus.dart';
import 'package:pesupay/src/utils/toast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class OnlinePaymentController extends GetxController {
  // OnlinePaymentController( this._dio);
  static const Uuid _uuid = Uuid();
  OnlinePaymentController(this._dio);
  final Dio _dio;
late PaymentDetailRepo _paymentDetailRepo;
// final PaymentDetailService _api=PaymentDetailService(_dio);
  ///stores trxn Id
  final Rx<dynamic> pesutxnId = Rx<dynamic>(null);

  ///stors ptrxn time in case user caacelled trxn
  final Rx<dynamic> trxnTime = Rx<dynamic>(null);

  final paymentDetailModel = Rx<PaymentDetailModel>(PaymentDetailModel());
  final transactionDetailModel =
      Rx<TransactionDetailModel>(TransactionDetailModel());
  final ctypeModel = Rx<CTypeModel>(CTypeModel());
  final stypeModel = Rx<List<STypeModel>>([]);
  final paymentConfirmationModel =
      Rx<List<PaymentConfirmModel>>([]);
  List<dynamic> emptystype = [];
  // final connectionController = Get.put(ConnectionController());
  var rejectedCount = 0.obs;
  var pendingCount = 0.obs;
  var paidCount = 0.obs;
  final partialAmountController = TextEditingController();

  ///misc paymnet page
  final miscSubcopies = TextEditingController();
  final miscdescController = TextEditingController();
  final miscdynamicamount = TextEditingController();

  ///formKey
  final amountformKey = GlobalKey<FormState>();
  final discformKey = GlobalKey<FormState>();
  final miscSubcopyformKey = GlobalKey<FormState>();

  final RxString miscamount = RxString('');
  //
  final paymentloading = Rx<bool>(false);

  final RxBool miscloading = RxBool(false);

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
  RxBool otherAmountflag = false.obs;
  RxBool isotherAmountAvailable = false.obs;
  RxBool tcflag = false.obs;
  dynamic ctypeValue;
  dynamic stypeValue;
  dynamic partialAmount;
  RxBool pcflag = false.obs;


///amount in words 
RxString amountInWords = RxString('');
    var converter = NumberToTextConverter.forIndianNumberingSystem();




  @override
  void onInit() async {
    _paymentDetailRepo = PaymentDetailRepo(_dio);
    // await getPaymentDetail();
    // getCTypeListResponse();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // amountformKey.currentState:?.dispose();
    miscSubcopies.dispose();
    miscdescController.dispose();
    miscdynamicamount.dispose();
    payuresponse.dispose();
    super.onClose();
  }

  void clean() {
    tcflag.value = false;
    miscSubcopies.clear();
    miscdescController.clear();
    miscdynamicamount.clear();
    miscamount.value = '';
  }

  ///Payu surl $ furl

  final androidFurl =
      "https://www.pesuacademy.com/MAcademy/payment/PayuPaymentResponse/failed";
  final androidSurl =
      "https://www.pesuacademy.com/MAcademy/payment/PayuPaymentResponse/success";
  final iosFurl =
      "https://www.pesuacademy.com/MAcademy/payment/PayuPaymentResponse/failed";
  final iosSurl =
      "https://wwww.pesuacademy.com/MAcademy/payment/PayuPaymentResponse/success";
  final testmerchantKey = "3TnMpV";
  //  "Kc9iwJ"; // Add you Merchant Key
  final livemerchantKey = "OZBkWu"; // Add you Merchant Key

  ///payu configs
  ///
  /// for modification in payu checkout page
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

  void increment() => count.value++;

  ///misc payment
  Future<void> startPayment(
      {required String amount,
      required String cat,
      required String name,
      required String email,
      required String mobileNumber,
      required String subcat,
      required String loginId,
      required String userId,
      required String academicYearId,
      String? miscDescription,
    required  String merchantKey,
      required BuildContext context}) async {
    var miscCatSubcat = "1&$cat&$subcat&2&2&1";
    Get.back();
    // Navigator.push(
    //     context,
    //     FullPageDialogRoute(
    //         builder: ((context) => PesuPaymentPage(
    //           name:name ,
    //           email:email ,
    //           loginId: loginId,
    //           // loadingWidget: ,
    //           mobileNumber:mobileNumber,
    //           userId: userId,
    //               paymentDescription: miscDescription,
    //               isMiscpayment: true,
    //               dueAmount: amount,
    //               feeName: miscDescription,
    //               misctype: miscCatSubcat,
    //               merchantKey: merchantKey,
    //               academicyear: academicYearId,
    //             ))));
  }

//
  Future<void> getPaymentDetail(String userId) async {
    if (rxRequestStatus.value != RequestStatus.LOADING) {
      setRxRequestStatus(RequestStatus.LOADING);
    }
    try {
      // paymentloading.value = true;
      var response =
          await _paymentDetailRepo.getPaymentDetail(userId);
      // if (response.statuscode == 200) {
      response.fold((error) {
        // paymentloading.value = false;
        setRxRequestStatus(RequestStatus.ERROR);
      }, (res) {
        paymentDetailModel.value = PaymentDetailModel.fromJson(res);
        pendingCount.value = paymentDetailModel.value.sTUDENTPAYMENTDETAILS!
            .where((detail) =>
                detail.verifiedStatus == 'Pending' ||
                detail.verifiedStatus == 'Partially Paid'||detail.paymentStatus=='Partially Paid')
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
      // paymentloading.value = false;
    } catch (e, s) {
      setRxRequestStatus(RequestStatus.ERROR);
      log('$e', error: s);
      // paymentloading.value = false;
    }
  }

  Future<void> getTransactionDetail(
      dynamic academicYearId, dynamic feeType, String userId) async {
    try {
      paymentloading.value = true;
      var response = await _paymentDetailRepo
          .getTransactionDetail(academicYearId, feeType,userId);
      // if (response.statuscode == 200) {
      response.fold((left) {
        paymentloading.value = false;
      }, (res) {
        transactionDetailModel.value = TransactionDetailModel.fromJson(res);
      });

      // }
      paymentloading.value = false;
    } catch (e, s) {
      log('$e', error: s);
      paymentloading.value = false;
    }
  }

  void setisotherAmountAvailable(int annualfeeIndex) {
    isotherAmountAvailable.value = paymentDetailModel
                .value.sTUDENTPAYMENTDETAILS![annualfeeIndex].minAmount ==
            null ||
        paymentDetailModel
                .value.sTUDENTPAYMENTDETAILS![annualfeeIndex].minAmount ==
            0.0;
  }
  // void convertToInt(dynamic val) {
  //   try {
  //     int value = int.parse(val);

  //     partialAmount = value;
  //   } catch (e) {
  //     // partialAmount = 'Invalid number';
  //   }
  // }



///
void updateAnount(){
  if (partialAmountController.value.text.isNotEmpty) {
      amountInWords.value =                                converter.convert(int.tryParse(partialAmountController.value.text.removeAllWhitespace)!).toUpperCase();
  }
update();
// return convertedtext;
}
  ///Get trannsactionHas Id
  ///

  Future<String> getUuidTrxnId() async {
    
    try {
      pesutxnId.value = null;
      var txnId = _uuid.v7obj().toString();

      pesutxnId.value = txnId.substring(0,18);
      log('${pesutxnId.value}}', name: 'txnId');
      return txnId;
    } catch (e, s) {
      log('$e', error: s, name: 'uuid');
      throw Exception();
    }
  }

  Future<void> getnewTrxnId()async
{
// Rand
}
  Future<String> getTrxnTime() async {
    try {
      var now = DateTime.now();
      // DateTime.parse(formattedString);

      // Define the desired format
      DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

      // Format the current date and time
      String formattedDate = formatter.format(now);
      trxnTime.value = formattedDate;
      return formattedDate;
    } catch (e, s) {
      log('$e', error: s, name: 'trxnTime');
      throw Exception();
    }
  }

  ///Get Dynamic Hashes from server
  Future<Map> getserverDynamicHash(
      {required String hash,
      required String trxnId,
      required String misctype,
      required String academicyear,
      required String demandId,
      required String dueAmount,
      required String feeName,
      required String fdFeeTypeId,
      required String merchantKey,
     required String instId,   required String name,
  required String email,
  required String mobileNumber,
  required String userId,
  required String loginId,}) async {
    // String hash='';
    payupaymentstarted.value = true;
    var serverhash;
    try {
      var response = await _paymentDetailRepo
          .getDynamicHash(
            name: name,
            email: email,
            mobileNumber: mobileNumber,
            userId: userId,
            loginId: loginId,
              txnId:trxnId,
              hash: hash,
              academicyear: academicyear,
              misctype: misctype,
              demandId: demandId,
              dueAmount: dueAmount,
              feeName: feeName,
              fdFeeTypeId: fdFeeTypeId,
              instId: instId ,
              merchantKey: merchantKey);
      response.fold((error) {
        payupaymentstarted.value = false;

        throw Exception(error);
      }, (hashresponse) async {
        //  _checkoutPro.hashGenerated(hash: ha);
        serverhash = hashresponse;
        log(hashresponse.toString(), error: '', name: "payupaymentstarted");
        return serverhash;
      });
    } catch (e, s) {
      payupaymentstarted.value = false;
      log('$e', error: s, name: 'cont');
      // return e.toString();
      return {"error": "$e"};
    }
    return serverhash;
  }

  ///
  void shareScreenshot() async {
    try {
      final image = await screenshotController.capture();
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/screenshot.png').create();
        await imagePath.writeAsBytes(image);
        Share.shareXFiles([
          XFile.fromData(image, name: 'screenshot.png', mimeType: 'image/png')
        ]);
      }
    } catch (e) {
      debugPrint('print------------PESU---------- : ${e.toString()}');
    }
  }

  ///
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

  ///

  void download(String trxId) async {
   
    final directory = await getDownloadPath(); //from path_provide package
    String fileName = '/$trxId.png';
    print(directory);
    var path = '$directory';

    screenshotController.captureAndSave(
        path, //set path where screenshot will be saved
        fileName: fileName);
         showToast('Downloaded Successfully');
  }

  Future getCTypeListResponse(int instId) async {
    try {
      // paymentloading.value = true;
      ctypeModel.value.ctype?.clear();
      var response =
          await _paymentDetailRepo.getCTypeList(instId);

      response.fold((error) {
        paymentloading.value = false;
      }, (response) {
        ctypeModel.value = CTypeModel.fromJson(response);

        // paymentloading.value = false;
      });
      // }
      // paymentloading.value = false;
    } catch (e, s) {
      log('$e', error: s);
      // paymentloading.value = false;
    }
  }

  Future getSTypeListResponse(int id, int instId) async {
    try {
      // paymentloading.value = true;
          stypeModel.value.clear();
      
      miscloading.value = true;
      var response =
          await _paymentDetailRepo.getSTypeList(id, instId);
      response.fold((error) {
        miscloading.value = false;
      }, (response) {
        print(response);
        stypeModel.value.add( STypeModel.fromJson(response));
        if (stypeModel.value[0].stype!.isEmpty) showToast('No Data');
        miscloading.value = false;
        // log('${stypeModel.value.stype!}', name: 'stpe');
      });
      // }
      // paymentloading.value = false;
    } catch (e, s) {
      log('$e', error: s);
      miscloading.value = false;
    }
  }

  Future<void> getPaymentConfirmationResponse(int ctypeId, int stypeId,  String userId) async {
    try {

      miscloading.value = true;
      paymentConfirmationModel.value.clear();
      var response = await _paymentDetailRepo
          .getPaymentConfirmationDetail(ctypeId, stypeId, userId);

      response.fold((error) {
        miscloading.value = false;
      }, (response) {
        paymentConfirmationModel.value.add( PaymentConfirmModel.fromJson(response));
        miscloading.value = false;
        if (paymentConfirmationModel.value[0].miscellaneouspayment != []) {
          pcflag.value = true;
        } else {
          pcflag.value = false;
        }
        miscloading.value = false;
      });

      // }
      // paymentloading.value = false;
    } catch (e, s) {
      log('$e', error: s);
      miscloading.value = false;
    }
  }
//

  void addsubCopiesamount({int? copy, required String amount}) {
    // if(copy==0){}else{
    double value = double.tryParse(amount)! +
        (int.tryParse(miscSubcopies.value.text.toString())! *
            double.tryParse(paymentConfirmationModel
                .value[0].miscellaneouspayment![0].dataValue2!)!);
    miscamount.value = value.toString();
    log(value.toString(), error: '', name: "amount");
    // update();
    // }
  }

  void updatemiscAmount(String? amout) {
    try {
      if (paymentConfirmationModel.value[0].miscellaneouspayment?[0].label !=
          'NA') {
        miscSubcopies.text = paymentConfirmationModel
                .value[0].miscellaneouspayment?[0].dataValue3 ??
            '';
      }
      
      miscamount.value = '';
      if (amout == "null" || amout == null || amout == "0") {
        miscamount.value = miscdynamicamount.value.text;

// return miscamount.value;
      } else {
        miscamount.value = '';

        miscamount.value = amout;
        // return miscamount.value;
      }
    } catch (e) {
      print('update amoutnt ' + "$e");
    }
    update([
      {'id': "292992"}
    ]);
// return miscamount.value;
  }
}

class HashError implements Exception {
  final String message;
  HashError(this.message);
}
