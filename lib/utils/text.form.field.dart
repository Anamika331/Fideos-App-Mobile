import 'package:flutter/material.dart';

class CommonTextFormField {
  final TextEditingController controller;
  final String hint;
  final IconData? suffix;
  final Function()? onTapSuffix;
  final bool passwordObsecured;
  final String? Function(String?)? validator;
  final TextInputType type;

  CommonTextFormField(
      {required this.controller,
      required this.hint,
      this.suffix,
      this.onTapSuffix,
      this.validator,
      this.passwordObsecured = false,
      this.type = TextInputType.text});

  show() => TextFormField(
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      keyboardType: type,
      controller: controller,
      obscureText: passwordObsecured,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(width: 1)),
          suffixIcon: GestureDetector(
              onTap: () {
                if (onTapSuffix != null) {
                  onTapSuffix!();
                }
              },
              child: Icon(suffix, size: 15, color: Colors.black)),
          hintText: hint,
          label: Text(hint,
              style: const TextStyle(
                  fontSize: 13, fontFamily: "Lexend", color: Colors.grey)),
          hintStyle: const TextStyle(
              fontSize: 13, fontFamily: "Lexend", color: Colors.grey)));
}
