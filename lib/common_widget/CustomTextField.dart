import 'package:flutter/material.dart';

import 'multi_click_avoid.dart';

enum DataTypes { email, numeric, alphanumeric }

class CustomTextField extends StatefulWidget {
  final Function(String)? onChanged;
  final String hint;
  final bool isPassword;
  final String? errorText;
  final TextEditingController? controller;
  final double padding;
  final double topPadding;
  final DataTypes dataType;
  final Key? paramId;
  final bool isVerify;
  final bool isMobileNo;
  final bool isAmount;
  final int maxLength;
  final bool isTextVerify;
  final bool? isReadOnly;
  final Function()? onVerify;
  final MultiClick? multiClick;


  const CustomTextField({
    super.key,
    this.onChanged,
    this.isPassword=false,
    required this.hint,
    this.errorText,
    this.controller,
    this.dataType = DataTypes.alphanumeric,
    this.padding = 3,
    this.topPadding = 3,
    this.paramId,
    this.isVerify = false,
    this.isMobileNo = false,
    this.isAmount = false,
    this.isTextVerify = false,
    this.maxLength = 35,
    this.isReadOnly = false,
    this.onVerify,
    this.multiClick,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.topPadding),
      child: TextFormField(
          autocorrect: true,
        cursorRadius: Radius.circular(2),
        cursorHeight: 20,
        controller: widget.controller,
        onChanged: widget.onChanged,
        keyboardType: _getKeyboardType(),
        readOnly: widget.isReadOnly ?? false,
        maxLength: widget.maxLength,
        validator: _validateInput,
        obscureText: widget.isPassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                  color: Colors.deepOrangeAccent
              )
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Colors.deepOrangeAccent
            )
          ),
          hintStyle: TextStyle(
            color: Colors.black12,
          ),
          errorStyle: TextStyle(
            color: Colors.deepOrangeAccent
          ),
          hintText: widget.hint,
          border: InputBorder.none,
          errorText: widget.errorText,
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          counterText: '', // Hides the character counter
        ),
      ),
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.dataType) {
      case DataTypes.email:
        return TextInputType.emailAddress;
      case DataTypes.numeric:
        return TextInputType.number;
      case DataTypes.alphanumeric:
      default:
        return TextInputType.text;
    }
  }
}
