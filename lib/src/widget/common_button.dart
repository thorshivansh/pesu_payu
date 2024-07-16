import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.onPressed,
      this.width,
      this.height,
      this.icon,
      required this.label,
      this.color,
      this.loading,
      this.buttonColor,
       this.labelStyle, this.borderColor,});
  final Function() onPressed;
  final double? width;
  final double? height;
  final IconData? icon;
  final String label;
  final Color? color;
  final Color? borderColor;

  final Color? buttonColor;
  final bool? loading;
  final TextStyle? labelStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: borderColor ?? const Color(0xff00377B)),
        color: color ?? const Color(0xff00377B),
      ),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        color: color ?? const Color(0xff00377B),
        disabledColor: color?.withOpacity(0.5),
        minWidth: width ?? double.infinity,
        // height: 40,
        elevation: 0,
        onPressed: loading ?? false ? null : onPressed,
        child: loading ?? false
            ? const SizedBox(
                // height: 25,
                // width: 25,
                child: Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              )
            : FittedBox(
                child: Row(
                  children: [
                    icon != null
                        ? Icon(
                            icon,
                            color: Colors.white,
                          )
                        : const Column(),
                    SizedBox(
                      width: icon != null ? 10.0 : 0.0,
                    ),
                    Text(
                      label,
                      style: labelStyle ??
                          GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
