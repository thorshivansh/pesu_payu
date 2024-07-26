import 'package:flutter/material.dart';

class PaymentConfig {
  final Color? primaryColor;
  final Color? secondaryColor;
  final Icon? appBarIcon;
  final Color? appBarColor;
  final Widget? loadingWidget;
  final AssetImage? logoImage;
  final String? assetString;
  final Color? successColor;
  final Color? failColor;
  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final double? primaryTextSize;
  final double? secondaryTextSize;
  final TextStyle? primaryTextStyle;
  final TextStyle? secondaryTextStyle;

  final String? buttonText;
  final String? buttonColor;
  final String? buttonTextColor;
  final String? buttonBorderColor;

  PaymentConfig({
    this.successColor,
    this.failColor,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.primaryTextSize,
    this.secondaryTextSize,
    this.primaryTextStyle,
    this.secondaryTextStyle, 
    this.assetString,
    this.buttonText,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonBorderColor,
    this.appBarIcon,
    this.appBarColor,
    this.primaryColor,
    this.secondaryColor,
    this.loadingWidget,
    this.logoImage,
  })
  // : assert(primaryColor != null),
  //  assert(assetString != null),
  //      assert(loadingWidget != null),
  //      assert(secondaryColor != null)
  ;
}
