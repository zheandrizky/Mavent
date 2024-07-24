import 'package:flutter/material.dart';

//ya ini file desain input form jadi smua form ntar bentukan desainnya kek bgni lah kira2

class CustomInputForm extends StatelessWidget {
  final TextEditingController? controller;
  final bool? readOnly;
  final VoidCallback? onTap;
  final int? maxLines;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? label;
  final String? hint;
  final List<String>? autofillHints;

  CustomInputForm({
    this.controller,
    this.readOnly,
    this.onTap,
    this.maxLines,
    this.obscureText,
    this.keyboardType,
    this.label,
    this.hint,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: Container(
        width: 370,
        child: TextFormField(
          controller: controller,
          readOnly: readOnly ?? false,
          onTap: onTap,
          autofocus: true,
          autofillHints: autofillHints,
          maxLines: maxLines ?? 1,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF1F4F8),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFF1F4F8),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF4B39EF),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFE0E3E7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFE0E3E7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            labelText: label,
            labelStyle: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF57636C),
              fontWeight: FontWeight.w500,
            ),
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF57636C),
            ),
          ),
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF101213),
            fontSize: 14,
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
