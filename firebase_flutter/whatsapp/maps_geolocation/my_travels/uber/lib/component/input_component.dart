import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InputComponent {
  static Widget Login(
      {String hintText,
      FormFieldValidator<String> validator,
      obscureText = false}) {
    return TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey))),
        validator: validator);
  }
}
