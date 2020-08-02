import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool autofocus;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;
  final int maxLines;

  InputCustom(
      {@required this.controller,
      @required this.hintText,
      this.obscureText = false,
      this.autofocus = false,
      this.keyboardType = TextInputType.text,
      this.validator = null,
      this.inputFormatters,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      obscureText: this.obscureText,
      autofocus: this.autofocus,
      keyboardType: this.keyboardType,
      validator: this.validator,
      inputFormatters: this.inputFormatters,
      maxLines: this.maxLines,
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
