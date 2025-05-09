// ignore_for_file: body_might_complete_normally_nullable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import '../utils/text_styles.dart';
import 'custom_inputborder.dart';

class CustomTextFormFeld extends StatelessWidget {
  const CustomTextFormFeld(
      {super.key,
      required this.hintText,
      required this.inputType,
      this.icon,
      this.obscureText = false,
      this.onSaved,
      this.onSubmit,
      this.controller,
      this.validator,
      this.readOnly,
      this.textDirection = TextDirection.ltr,
      this.value,
      this.focusMode, this.suffixIcon});
  final TextEditingController? controller;
  final String hintText;
  final TextInputType inputType;
  final Widget? icon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool? validator;
  final bool? readOnly;
  final String? value;
  final TextDirection textDirection;
  final void Function(String?)? onSaved;
  final void Function(String)? onSubmit;
  final FocusNode? focusMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      focusNode: focusMode,
      textAlign: TextAlign.start,
      readOnly: readOnly ?? false,
      controller: controller,
      obscureText: obscureText, // Add this line to hide the password
      // textAlign: TextAlign.end,
      onSaved: onSaved,

      onFieldSubmitted: onSubmit,
      validator: validator == false
          ? null
          : (value) {
              if (value!.isEmpty || value == null) {
                return 'هذا الحقل مطلوب';
              }
            },
      keyboardType: inputType,
      minLines: 1,
      maxLines: 10,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyles.bold13,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        filled: true,
        // fillColor: const Color(0xffF9FAFA),
        fillColor: Theme.of(context).colorScheme.background,
        enabledBorder: customInputBorder(context),
        focusedBorder: customInputBorder(context),
        prefixIcon: icon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
