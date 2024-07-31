import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../pesupay.dart';

PreferredSizeWidget paymentAppBar({
  required String appBarTitle,
  Widget? appBarTitleWidget,
  List<Widget>? appBarAction,
  PreferredSizeWidget? bottom,
  TextStyle? appBarTitleStyle,
  double? appBarTitleFontSize,
  Widget? appBarLeading,
  IconData? appBarLeadingIcon,
  double? appBarLeadingIconSize,
  Color? appBarLeadingIconColor,
  Color? appBarTitleColor,
  Color? appBarBackgroundColor,
  FontWeight? appBarTitleFontWeight,
  void Function()? appBarLeadingOnTap
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    actions: appBarAction,
    bottom: bottom,
    title: appBarTitleWidget ??
        PesuText(
          appBarTitle,
          fontSize: appBarTitleFontSize,
          style: appBarTitleStyle,
          color: appBarTitleColor,
          fontWeight: appBarTitleFontWeight,
        ),
    backgroundColor: appBarBackgroundColor,
    leading: appBarLeading ??  MyIcons(
      onPressed: appBarLeadingOnTap,
      appBarLeadingIcon ?? CupertinoIcons.back,
      color: appBarLeadingIconColor ?? Colors.white,
      size: appBarLeadingIconSize ?? 25.0,
    ),
  );
}
