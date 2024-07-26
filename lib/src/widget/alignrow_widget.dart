import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'autosize_text.dart';

class AlignRowWidget extends StatelessWidget {
  final String? firstText;
  final String? secondText;
  final Widget? firstWidget;
  final int? firstWidgetFlex;
  final Widget? secondWidget;
  final int? secondWidgetFlex;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  const AlignRowWidget({
    super.key,
    this.firstText,
    this.secondText,
    this.firstWidget,
    this.secondWidget,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.firstWidgetFlex,
    this.secondWidgetFlex,
  });

  @override
  build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 15.0, right: 10.0),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: firstWidgetFlex ?? 1,
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
          // SizedBox(),
          // const Text(
          //   ":",
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          // ),
          const SizedBox(width: 10),
          Expanded(
            flex: secondWidgetFlex ?? 1,
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



// class ColumnWidget extends StatelessWidget {
//   final String name;
//   final String longText;
//   final Widget? rowSecondWidget;
//   const ColumnWidget({super.key, required this.name, required this.longText,  this.rowSecondWidget});

//   @override
//   Widget build(BuildContext context) {
  
//   return Row(
//     crossAxisAlignment: CrossAxisAlignment.end,
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         "$name:",
//         style: Properties.textsStyles.text16_300
//             .copyWith(color: Properties.themeColor.gray),
//       ),
//       Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             PesuText(
//               longText,
//               style: Properties.textsStyles.text16_700
//                   .copyWith(color: Properties.themeColor.black),
//             ),
//       SizedBox(child: rowSecondWidget,)
//           ],
//           ),
          
//     ],
//   );
//   }
// }