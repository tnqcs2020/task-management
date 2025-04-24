import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.isPassword = false,
    this.icon,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onFieldSubmitted,
  });
  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool? isPassword;
  final IconData? icon;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword!,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon, color: Colors.indigo) : null,
          labelText: label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          hintText: hint,
          hintStyle: TextStyle(fontWeight: FontWeight.w300),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: Colors.white,
          floatingLabelStyle: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black, width: 0.7),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo, width: 0.7),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo, width: 0.7),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo, width: 0.7),
          ),
        ),
        keyboardType: TextInputType.text,
        textInputAction: textInputAction,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
