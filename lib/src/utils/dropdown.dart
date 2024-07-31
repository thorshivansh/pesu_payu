import 'package:flutter/material.dart';



class ShowDropDown extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>>? items;
  final CallBack onChanged;
  final CallBack? onSaved;
  final String? Function(dynamic)? validate;
  final String? labelText;
  final String? hintText;
  final bool? isLoading;
  final Widget? icon;
  final Text? hint;
  final dynamic initialValue;
  final FocusNode? focusNode;
  final bool iconVisibility;
  final bool disable;
  final double? minWidth;
  final double? itemHeight;
  final double? menuMaxHeight;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  const ShowDropDown({
    this.focusNode,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.hint,
    this.iconVisibility = true,
    this.minWidth,
    this.menuMaxHeight,
    this.selectedItemBuilder,
    required this.onChanged,
    required this.items,
    super.key,
    this.disable = false,
    this.onSaved,
    this.validate, this.isLoading, this.icon, this.itemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      enableFeedback: true,
      itemHeight:itemHeight,
      isExpanded: true,
      isDense: true,
      focusNode: focusNode,
      value: initialValue,
      hint: hint,
      icon:icon?? Visibility(
          visible: iconVisibility,
          child: const Icon(Icons.keyboard_arrow_down_rounded)),
      decoration: InputDecoration(
        
        filled: true,
        isDense: false,
        fillColor: Colors.white,
        suffixIcon: null,
        labelText: labelText,
        labelStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w400, color: null),
        hintText: hintText,
        // hintStyle: GoogleFonts.roboto(
        //     fontWeight: FontWeight.w400,
        //     textStyle: Properties.textsStyles.text16_400
        //         .copyWith(color: Properties.themeColor.black)),
        disabledBorder: baseBoarder,
        enabledBorder: baseBoarder,
        border: baseBoarder,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
      ),
      
      menuMaxHeight: menuMaxHeight,
      items: items,
      onChanged: !disable ? onChanged : null,
      onSaved: onSaved,
      validator: validate,
      
    );
  }
}

InputBorder baseBoarder = OutlineInputBorder(
    borderSide: const BorderSide(width: 1),
    borderRadius: BorderRadius.circular(5));

typedef CallBack(value);
