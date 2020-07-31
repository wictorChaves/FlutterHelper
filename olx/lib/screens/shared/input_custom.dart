import 'package:flutter/material.dart';

class InputCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool autofocus;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;

  InputCustom(
      {@required this.controller,
      @required this.hintText,
      this.obscureText = false,
      this.autofocus = false,
      this.keyboardType = TextInputType.text,
      this.validator = null});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      obscureText: this.obscureText,
      autofocus: this.autofocus,
      keyboardType: this.keyboardType,
      validator: validator,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: this.hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
    );
  }
}
