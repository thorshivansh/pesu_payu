import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? color;
  final  TextStyle? style;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final bool? isBold;
  final bool? isUnderline;
  final TextOverflow? overflow;

  final bool? isAutoSize;
  final int? maxLines;

  final double? height;

  const MyText( this.text,{super.key, this.fontSize, this.color, this.fontWeight, this.textAlign, this.isBold, this.isUnderline, this.isAutoSize, this.maxLines, this.height, this.style, this.overflow});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text??'',
    overflow:overflow ,
     style: style??GoogleFonts.roboto(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),  );
  }
}