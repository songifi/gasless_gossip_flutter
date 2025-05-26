import 'package:flutter/material.dart';

class AppInput extends StatefulWidget {
  final String? label;
  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final Color? borderColor;
  final Color? fillColor;
  final Widget? prefixIcon;

  const AppInput({
    super.key,
    this.label,
    this.hintText,
    this.isPassword = false,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.enabled = true,
    this.onChanged,
    this.borderColor,
    this.fillColor,
    this.prefixIcon,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscure : false,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        errorText: widget.errorText,
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
        hintStyle: const TextStyle(fontSize: 14),
        labelStyle: const TextStyle(fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: widget.borderColor ?? const Color(0xFFDBE1E7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: widget.borderColor ?? const Color(0xFFDBE1E7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: widget.borderColor ?? Theme.of(context).colorScheme.primary, width: 2),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
      ),
    );
  }
} 