import 'package:flutter/material.dart';

class ComponentHelper {
  static Widget InputFieldCircular(String text, TextInputType textInputType,
      {bool autofocus = false,
      TextEditingController controller = null,
      bool obscure = false,
      FormFieldValidator<String> validator}) {
    return TextFormField(
      autofocus: autofocus,
      obscureText: obscure,
      keyboardType: textInputType,
      style: TextStyle(fontSize: 20),
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: text,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
    );
  }

  static Widget RaisedButtonCircular(String text, {VoidCallback onPressed}) {
    return RaisedButton(
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20)),
        color: Colors.green,
        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        onPressed: onPressed);
  }
}
