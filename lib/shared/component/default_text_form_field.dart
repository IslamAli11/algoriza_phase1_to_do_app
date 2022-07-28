import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTextFormFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String? validate;
  final String hintText;
  final Widget? suffixIcon;

  const DefaultTextFormFiled(
      {Key? key,
        this.controller,
        this.validate,
        required this.hintText,
        this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        if (value!.isEmpty) {
          return validate;
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          fillColor: Colors.grey[150],
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10))),
    );
  }
}