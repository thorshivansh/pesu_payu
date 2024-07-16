import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'autosize_text.dart';

class AlignRowWidget extends StatelessWidget {
  final String? firstText;
  final String? secondText;
  final Widget? firstWidget;
  final Widget? secondWidget;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  const AlignRowWidget(
      {super.key,
      this.firstText,
      this.secondText,
      this.firstWidget,
      this.secondWidget,
      this.mainAxisAlignment,
      this.crossAxisAlignment});

  @override
  build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 15.0, right: 10.0),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: firstWidget ??
                PesuText(
                  "$firstText:",
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff999999),
                  ),
                ),
          ),
          // const Text(
          //   ":",
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          // ),
          const SizedBox(width: 10),
          Expanded(
            child: secondWidget ??
                PesuText(
                  secondText ?? '',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff000000),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
