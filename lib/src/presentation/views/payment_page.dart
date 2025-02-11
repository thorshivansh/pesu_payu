import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import '../../../pesupay.dart';



class PesuPaymentPage extends StatefulWidget {
  final Widget? loadingWidget;
  final String academicyear;
  final String misctype;
  final String? demandId;
  final String dueAmount;
  final String? feeName;
  final String? instId;
  final String? fdFeeTypeId;
  final String merchantKey;
  final String? paymentDescription;
  final bool isMiscpayment;

  const PesuPaymentPage({
    super.key,
    required this.academicyear,
    required this.misctype,
    this.demandId,
    required this.dueAmount,
    this.feeName,
    this.fdFeeTypeId,
    required this.merchantKey,
    this.paymentDescription,
    required this.isMiscpayment,
    this.loadingWidget,
    this.instId,
    // this.pay
  });

  @override
  State<PesuPaymentPage> createState() => _PesuPaymentPageState();
}

class _PesuPaymentPageState extends State<PesuPaymentPage>
    with PayUCheckoutProProtocol {
  late PayUCheckoutProFlutter _checkoutPro;
  final _controller = Get.find<OnlinePaymentController>();
  // late Map additionnalParms;
  // late Map payuParams;
// late DateTime _dateTime;
  @override
  void initState() {
    print('initstate');
    _checkoutPro = _checkoutPro = PayUCheckoutProFlutter(this);
    _controller.payuresponse.value.clear();
    _controller.trxnTime.value = '';
    super.initState();
    // widget.pay!(my());
    // my();
    doPaymennt();
  }

  my() {
    print(
        " ${widget.academicyear};${widget.misctype}${widget.demandId}${widget.dueAmount}${widget.feeName}${widget.fdFeeTypeId}${widget.merchantKey}${widget.paymentDescription}${widget.isMiscpayment}");
    // Get.dialog(
    //   AlertDialog(
    //     title: const Text('Payment Success'),
    //     content: const Text('Payment Success'),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Get.back();
    //           },
    //           child: const Text('OK'),
    //           ),
    //           ],
    //           ),

    // );
  }

  doPaymennt() async {
    _controller.payupaymentstarted.value = true;
    try {
      _controller
          .getUuidTrxnId()
          .then((value) => _controller.getTrxnTime())
          .then((value) => _checkoutPro.openCheckoutScreen(
              payUPaymentParams: payuparams(),
              payUCheckoutProConfig: _controller.createPayUConfigParams()))
          .onError((error, stackTrace) =>
              log(error.toString(), error: stackTrace, name: 'paymennt page'));
    } catch (e, s) {
      _controller.payupaymentstarted.value = false;
      log(e.toString(), error: s, name: 'payu');
    }
  }

  Map payuparams() {
    try {
      var additionnalParms = {
        PayUAdditionalParamKeys.udf1: _controller.userInfo.value['userId'],
        PayUAdditionalParamKeys.udf2:
            _controller.userInfo.value['mobileNumber'],
        PayUAdditionalParamKeys.udf3: _controller.userInfo.value['loginId'],
        PayUAdditionalParamKeys.udf4: widget.academicyear,
        PayUAdditionalParamKeys.udf5: widget.misctype
      };

      var payuParam = {
        PayUPaymentParamKey.key: widget.merchantKey,
        // _controller.testmerchantKey, //TODO  change merchant key
        PayUPaymentParamKey.amount: widget.dueAmount,
        PayUPaymentParamKey.productInfo: widget.isMiscpayment
            ? widget.paymentDescription
            : widget.feeName, //TODO paymnnet description if misc
        PayUPaymentParamKey.firstName: _controller.userInfo.value['name'],
        PayUPaymentParamKey.email: _controller.userInfo.value['email'],
        PayUPaymentParamKey.phone: _controller.userInfo.value['mobileNumber'],
        PayUPaymentParamKey.environment: "0", //TODO  change ennviroment key
        PayUPaymentParamKey.additionalParam: additionnalParms,
        PayUPaymentParamKey.enableNativeOTP: true,
        // String - "0" for Production and "1" for Test
        PayUPaymentParamKey.transactionId: _controller
            .pesuTxnId.value, //TODO for ios txid canot be more than 25 lenght
        // transactionId Cannot be null or empty and should be unique for each transaction. Maximum allowed length is 25 characters. It cannot contain special characters like: -_/
        PayUPaymentParamKey.userCredential:
            "${widget.merchantKey}:${_controller.userInfo.value['email']}", //TODO  change merchant key
        //  Format: <testmerchantKey>:<userId> ... UserId is any id/email/phone number to uniquely identify the user.
        PayUPaymentParamKey.android_surl: ApiConfig.androidSurl,
        PayUPaymentParamKey.android_furl: ApiConfig.androidFurl,
        PayUPaymentParamKey.ios_surl: ApiConfig.iosSurl,
        PayUPaymentParamKey.ios_furl: ApiConfig.iosFurl
      };
      log(payuParam.toString(), name: 'payuparams');
      return payuParam;
    } catch (e, s) {
      log(e.toString(), error: s, name: 'payup');
      throw Exception();
    }
  }

  @override
  void dispose() {
    _controller.clean();
    super.dispose();
  }

//  payuresponse=ValueNotifier({})
  @override
  Widget build(BuildContext context) {
    // print("payuparams : ${payuparams.}");
// var userCredential = "${_controller.livemerchantKey}:abc@gmail.com";
// var json1 = jsonDecode(_controller. payuresponse.value['response']['payuResponse']);

    return SafeArea(
      top: false,
      child: Scaffold(
        body: Obx(() => _controller.payupaymentstarted.value
            ? Center(
                child: widget.loadingWidget ??
                    const CircularProgressIndicator.adaptive())
            : PaymentStatus(
                paymenntStatus: _controller.payuresponse.value['status'] ?? '1',
                errorType: _controller.payuresponse.value['id'] ?? '1',
                date: _getDateValue(_controller.payuresponse.value),
                paymentMode:
                    _getPaymentModeValue(_controller.payuresponse.value),
                feeType: widget.feeName,
                trxnId: _getTransactionId(_controller.payuresponse.value),
                amount: widget.dueAmount,
                name: _controller.userInfo.value['name'],
                srn: _controller.userInfo.value['loginId'],
                errorReason: _getErrorReason(_controller.payuresponse.value),
              )),
      ),
    );
  }

// Helper functions to extract values safely
  String _getDateValue(Map<dynamic, dynamic>? response) {
    if (response == null ||
        response['status'] == 'Cancelled' ||
        response['status'] == 'Error' ||
        response['response'] == null) {
      return _controller.trxnTime.value ?? 'N.A';
    }
    return response['response']['addedon'] ??
        response['response']['result']['addedon'] ??
        'N.A';
  }

  String _getPaymentModeValue(Map<dynamic, dynamic>? response) {
    if (response == null ||
        response['status'] == 'Cancelled' ||
        response['status'] == 'Error' ||
        response['response'] == null ||
        response['response']['PG_TYPE'] == null ||
        response['response']['result'] == null) {
      return 'N.A';
    }
    return response['response']['PG_TYPE'] ??
        response['response']['result']['PG_TYPE'] ??
        'N.A';
  }

  String _getTransactionId(Map<dynamic, dynamic>? response) {
    if (response == null || response['response'] == null) {
      return '0';
    }
    return "${response['response']['id'] ?? response['response']['result']['mihpayid'] ?? '0'}";
  }

  String _getErrorReason(Map<dynamic, dynamic>? response) {
    if (response == null ||
        response['response'] == null ||
        response['status'] == 'Cancelled') {
      return response?['reason'] ?? 'N.A';
    }
    return response['response']['field9'] ?? 'N.A';
  }

  @override
  generateHash(Map response) async {
    try {
      var hash = await _controller.getserverDynamicHash(
        instId: widget.instId, //TODO add InnstId
        trxnId: _controller.pesuTxnId.value,
        misctype: widget.misctype,
        merchantKey: widget.merchantKey,
        hash: jsonEncode(response),
        academicyear: widget.academicyear,
        fdFeeTypeId: widget.isMiscpayment ? "2" : widget.fdFeeTypeId!,
        feeName: widget.feeName!,
        demandId: widget.isMiscpayment ? "0" : widget.demandId!,
        dueAmount: widget.dueAmount,
      );

      // if (hash == null) return;
      print('@@@@@@');
      // var hash = HashService.generateHash(response);
      _checkoutPro.hashGenerated(hash: hash);
    } catch (e, s) {
      // print(e
      // );
      log(e.toString(), error: s, name: "generate hash");
    }
    // TODO: implement generateHash
    // throw UnimplementedError();
  }

  @override
  onError(Map? response) {
    log(response.toString(), name: 'error');
    _controller.payupaymentstarted.value = false;
    // PaymentSuccessScreen(status: 'error',respionse: response,);
    // var res = jsonDecode(response!['payuResponse']);
    _controller.payuresponse = ValueNotifier({
      "status": "Error",
      "onError": response,
      "id": "1",
      "reason": "Payment Error ${response!['errorCode']}"
    });
  }

  @override
  onPaymentCancel(Map? response) {
    try {
      log(_controller.payuresponse.value.toString(), name: 'payu');
      log(response.toString(), name: 'cancel');
      _controller.payupaymentstarted.value = false;
      //  var res = jsonDecode(response!['payuResponse']);
      var isTrxnInitiated = response!['isTxnInitiated'];
      _controller.payuresponse = ValueNotifier({
        "status": "Cancelled",
        "onpayCancel": response,
        "id": "1",
        "reason": isTrxnInitiated
            ? "Pending. Please confirm  your payment"
            : "User Cancelled Transction "
      });
    } catch (e, s) {
      log(e.toString(), error: s, name: 'cancel');
    }
    // PaymentSuccessScreen(status: 'cancelled',
    //  response!.addAll(response);respionse: response,);
  }

  @override
  onPaymentFailure(dynamic response) {
    log(response.toString(), name: 'fails');
    _controller.payupaymentstarted.value = false;
    var res = jsonDecode(response!['payuResponse']);
    // PaymentSuccessScreen(status: 'failed',respionse: response,);
    _controller.payuresponse =
        ValueNotifier({"status": "Failed", "response": res, "id": "1"});
  }

  @override
  onPaymentSuccess(dynamic response) {
    try {
      log(response.toString(), name: 'responnse');
      _controller.payupaymentstarted.value = false;
      var res = jsonDecode(response!['payuResponse']);
      // PaymentSuccessScreen(status: 'Success',respionse: response,);
      _controller.payuresponse =
          ValueNotifier({"status": "Successfull", "response": res, "id": "0"});
    } catch (e) {
      log(e.toString(), name: 'responnse');
    }
  }
}
