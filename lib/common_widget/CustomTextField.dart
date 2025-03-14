import 'package:flutter/material.dart';

import 'multi_click_avoid.dart';

enum DataTypes { email, numeric, alphanumeric }

class CustomTextField extends StatefulWidget {
  final Function(String)? onChanged;
  final String hint;
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

  const CustomTextField(
      {super.key,
        this.onChanged,
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
        this.multiClick});

  @override
  CustomTextFieldState createState() =>  CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.topPadding),
      child: Container(
        padding: EdgeInsets.all(widget.padding),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(32),  // Rounded corners
        ),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          keyboardType: _getKeyboardType(),
          readOnly: widget.isReadOnly ?? false,
          decoration: InputDecoration(
            hintText: widget.hint,
            border: InputBorder.none,
            errorText: widget.errorText,
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          ),
        ),
      ),
    );
  }

  // Helper method to determine keyboard type based on dataType
  TextInputType _getKeyboardType() {
    switch (widget.dataType) {
      case DataTypes.email:
        return TextInputType.emailAddress;
      case DataTypes.numeric:
        return TextInputType.number;
      case DataTypes.alphanumeric:
        return TextInputType.text;
      default:
        return TextInputType.text;
    }
  }
}
