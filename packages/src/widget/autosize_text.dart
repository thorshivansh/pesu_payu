import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PesuText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final double? fontsize;
  final bool? underline;
  final Color? color;
  const PesuText(this.data,
      {super.key, this.style, this.fontsize, this.underline, this.color});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(data,
        style: style ??
            TextStyle(
                fontSize: fontsize ?? 20,
                fontWeight: FontWeight.bold,
                color:color?? Colors.white));
  }
}