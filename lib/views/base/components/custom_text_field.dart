import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';

class MyTextFormFieldWithIcon extends StatefulWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final String formHintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyBoardType;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final double radius;

  const MyTextFormFieldWithIcon({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    required this.formHintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyBoardType,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 20,
    ),
    this.fillColor,
    this.radius = 24,

  });

  @override
  State createState() => _MyTextFormFieldWithIconState();
}

class _MyTextFormFieldWithIconState extends State<MyTextFormFieldWithIcon> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 12,horizontal: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(widget.radius),
        border: Border.all(color: Colors.grey, width: 0.8),
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyBoardType,
        obscureText: widget.isPassword ? _obscureText : false,
        textInputAction: TextInputAction.next,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          fillColor: widget.fillColor,
          filled: widget.fillColor == null ? false : true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            // Same borderRadius for consistency
            borderSide: const BorderSide(
              color: Colors.transparent, // Apply the primary color
            ),
          ),
          hintText: widget.formHintText,
           prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon ?? _buildDefaultSuffixIcon(),
          // border: InputBorder.none,
          contentPadding: widget.contentPadding,
        ),
        validator: widget.validator,
      ),
    );
  }

  /// Default suffix icon for password toggle
  Widget? _buildDefaultSuffixIcon() {
    if (!widget.isPassword) return null;
    return IconButton(
      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}
