import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pesu_payu/src/utils/color/colors.dart';

class MiscTextfield extends StatelessWidget {
  const MiscTextfield(
      {super.key,
      required this.textController,
      this.height,
      this.width,
      this.maxlines,
      this.margin,
      this.inputFormatters,
      this.keyboardType,
      this.textInputAction,
      this.onChanged,
      this.enable,
      this.validator,
      this.formKey});

  final TextEditingController textController;
  final double? height;
  final double? width;
  final int? maxlines;
  final bool? enable;
  final Key? formKey;
  final EdgeInsetsGeometry? margin;
  final List<TextInputFormatter>? inputFormatters; //for numeric input
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        // height: height ?? Get.height * 0.04,
        // width: width ?? Get.width * 0.4,
        margin: margin ?? const EdgeInsets.only(top: 7, bottom: 7),
        child: TextFormField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            enabled: enable ?? true,
            maxLines: maxlines ?? 1,
            inputFormatters: inputFormatters,
            // ??
            //     [
            //       FilteringTextInputFormatter.digitsOnly,
            //       FilteringTextInputFormatter.allow(
            //           RegExp(r'^[1-9]\d{0,1}(\.\d{1,2})?$')),
            //     ],
            keyboardType: keyboardType ?? TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero, // Square edges
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero, // Square edges when focused
                borderSide: BorderSide(
                    color:
                        MyColors.darkBlue1), // Custom border color
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero, // Square edges when enabled
                borderSide:
                    BorderSide(color: Colors.grey), // Custom border color
              ),
            ),
            controller: textController,
            onChanged: onChanged

            // autofocus: true,
            ),
      ),
    );
  }
}
