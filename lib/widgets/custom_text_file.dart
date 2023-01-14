import 'package:flutter/material.dart';

class CustomFormTextFile extends StatelessWidget {
  CustomFormTextFile({this.hindText, this.onchanged, this.obscureText = false});
  Function(String)? onchanged;
  String? hindText;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        hintText: hindText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
