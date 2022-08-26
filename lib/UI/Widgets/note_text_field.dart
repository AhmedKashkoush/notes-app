import 'package:flutter/material.dart';

class NoteTextField extends StatelessWidget {
  final String hint;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextAlign textAlign;
  final int? maxLines;
  final FocusNode? focusNode;
  const NoteTextField({
    Key? key,
    required this.hint,
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
    this.controller,
    this.onChanged,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.focusNode,
    this.fontStyle = FontStyle.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontStyle: fontStyle,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontStyle: fontStyle,
        ),
        border: InputBorder.none,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      focusNode: focusNode,
    );
  }
}
