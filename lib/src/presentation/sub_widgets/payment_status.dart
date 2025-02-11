import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pesu_payu/pesupay.dart';
import 'package:screenshot/screenshot.dart';

class PaymentStatus extends StatefulWidget {
  final String? errorReason;
  final String? name;
  final String? srn;
  final String? paymenntStatus;
  final String? amount;
  final bool? isTrxnInit;
  final String? errorType;
  final String? feeType;
  final String? date;
  final String? paymentMode;
  final String? trxnId;
  final Color? color;
  final BoxDecoration? decoration;

  const PaymentStatus({
    super.key,
    this.paymenntStatus,
    this.amount,
    this.feeType,
    this.date,
    this.paymentMode,
    this.trxnId,
    this.name,
    this.srn,
    this.isTrxnInit,
    this.errorType,
    this.errorReason,
    this.color,
    this.decoration,
  });

  @override
  State<PaymentStatus> createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final OnlinePaymentController _paymentController =
      Get.find<OnlinePaymentController>();
  bool isScreenshotMode = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    ));
  }

  final config = Get.find<PaymentConfig>();
  @override
  Widget build(BuildContext context) {
    // log(_paymentController.payuresponse.value.toString(), name: 'payu');

    return PopScope(
      onPopInvoked: (_) async {
        // Get.back();
        _paymentController.getPaymentDetail();
        PaymentRoutes.preventDuplicate('/online-payment', context);
        // Get.off(OnlinePaymentView());

        // return false;
      },
      child: Scaffold(
        // appBar: paymentAppBar(appBarTitle: '',appBarBackgroundColor: config.primaryColor),
        body: Screenshot(
          controller: _paymentController.screenshotController,
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Stack(
                  //   children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 2.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: widget.decoration ??
                        BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                            ),
                            color: widget.color ?? config.successColor),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back_ios,
                                        color: Colors.white),
                                    onPressed: () {
                                      // Get.back();
                                      _paymentController.getPaymentDetail();
                                      PaymentRoutes.preventDuplicate(
                                          '/online-payment', context);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image.asset(
                                    config.assetString!,
                                    height: 50,
                                  ),
                                ),
                                Visibility(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: InkWell(
                                      onTap: () => setState(() {
                                        isScreenshotMode = true;
                                        _paymentController
                                            .shareScreenshot()
                                            .then((_) {
                                          setState(() {
                                            isScreenshotMode = false;
                                          });
                                        });
                                      }),
                                      child: const Icon(LucideIcons.share2,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Icon(
                                  widget.errorType == '1'
                                      ? Icons.cancel_outlined
                                      : LucideIcons.checkCircle2,
                                  color: widget.errorType == '1'
                                      ? Colors.red
                                      : Colors.green,
                                  size: 50)
                              .animate()
                              .scale(duration: 500.ms),
                          const SizedBox(height: 20),
                          PesuText(
                            'Payment ${widget.paymenntStatus}',
                          ).animate().fadeIn(duration: 500.ms),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const PesuText("Amount : "),
                              PesuText(widget.amount ?? "0.0"),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          const PesuText('Transaction ID :'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PesuText(
                                  '${widget.trxnId == "0" ? "N.A" : widget.trxnId}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //   ],
                  // ),
                  Builder(
                    builder: (context) => SlideTransition(
                      position: _animation,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1.0,
                                color: const Color(0xffE5E5E5),
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AlignRowWidget(
                                  firstText: 'Name',
                                  secondText: widget.name,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                AlignRowWidget(
                                  firstText: 'SRN',
                                  secondText: widget.srn,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                AlignRowWidget(
                                  firstText: 'Transaction ID',
                                  secondText: widget.trxnId == "0"
                                      ? "N.A"
                                      : widget.trxnId,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                AlignRowWidget(
                                  firstText: 'Amount',
                                  secondText: widget.amount,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                AlignRowWidget(
                                  firstText: 'Product Info',
                                  secondText: widget.feeType,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                AlignRowWidget(
                                  firstText: 'Date & Time',
                                  secondText: widget.date,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                AlignRowWidget(
                                  firstText: 'Payment Mode',
                                  secondText: payMode(widget.paymentMode!),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                AlignRowWidget(
                                  firstText: 'Status of Transaction',
                                  secondText: widget.errorReason ??
                                      widget.paymenntStatus,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyButton(
                            width: Get.width * 0.4,
                            height: Get.height * 0.08,
                            secondWidgetInRow: const Icon(LucideIcons.download),
                            onPressed: () =>
                                _paymentController.download(widget.trxnId!),
                            label: 'Download',
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String payMode(String mode) {
    var mode1;
    RegExp regex = RegExp(r'-PG\b');
    String newmode = mode.replaceAll(regex, "");
    switch (newmode) {
      case 'CASH':
        mode1 = "Wallet";
        return mode1;
      case "NB":
        mode1 = "Net Banking";

        return mode1;
      case "CC":
        mode1 = "Credit Card";

        return mode1;
      case "DC":
        mode1 = "Debit Card";

        return mode1;
      case "UPI":
        mode1 = "UPI";

        return mode1;
      default:
        mode1 = 'N.A';
        break;
    }

    return mode;
  }
}
