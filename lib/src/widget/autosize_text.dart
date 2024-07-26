import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PesuText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? underline;
  final Color? color;
  const PesuText(this.data,
      {super.key, this.style, this.fontSize, this.underline, this.color, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(data,
        style: style ??
            TextStyle(
                fontSize: fontSize ?? 20,
                fontWeight:fontWeight,
                color:color?? Colors.white));
  }
}