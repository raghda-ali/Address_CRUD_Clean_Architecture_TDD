import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final double? width;
  final Color? cursorColor;
  final double? radius;
  final Color? focusBorderColor;
  final Color? borderColor;
  final String? hintText;
  final Color? hintColor;
  final Color? enabledBorderColor;
  final double? focusBorderRadius;
  final TextInputType? keyBoardType;
  final String? errorText;
  final String? Function(String? value)? onSave;

  const CustomTextFormField({
    Key? key,
    this.width,
    this.cursorColor,
    this.radius,
    this.focusBorderColor,
    this.borderColor,
    this.hintText,
    this.hintColor,
    this.focusBorderRadius,
    this.enabledBorderColor,
    this.keyBoardType,
    this.errorText,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        keyboardType: keyBoardType,
        maxLines: null,
        cursorColor: cursorColor ?? Colors.grey,
        decoration: InputDecoration(
          errorText: errorText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
            borderSide:
                BorderSide(color: borderColor ?? const Color(0xffDEDEDE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(focusBorderRadius ?? 10),
            borderSide:
                BorderSide(color: focusBorderColor ?? const Color(0xffDEDEDE)),
          ),
          hintText: hintText ?? "",
          hintStyle: TextStyle(
            color: hintColor ?? const Color(0xffB1B1B1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor ?? Colors.grey),
          ),
        ),
        onSaved: onSave == null ? null : (v) => onSave!(v),
      ),
    );
  }
}
