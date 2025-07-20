import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_typography.dart';
import '../../utilities/screen_size_config.dart';

class PrimaryFormField extends StatefulWidget {
  final IconData? prefixIcon;
  final String? label;
  final String? hintText;
  final IconData? suffixIcon;
  final bool isPassword;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool autofocus;

  const PrimaryFormField({
    super.key,
    this.prefixIcon,
    this.label,
    this.suffixIcon,
    this.isPassword = false,
    this.hintText,
    this.onChanged,
    this.keyboardType,
    this.controller,
    required this.autofocus,
  });

  @override
  State<PrimaryFormField> createState() => _PrimaryFormFieldState();
}

class _PrimaryFormFieldState extends State<PrimaryFormField> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: ScreenSizeConfig.screenWidth * 0.85,
        child: TextField(
          autofocus: widget.autofocus,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          obscureText: widget.isPassword ? isSecure : false,
          cursorColor: AppColors.pureWhite.withAlpha(95),
          cursorErrorColor: Colors.red,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: AppTypography.labelTextStyle,
            prefixIcon: Icon(
              widget.prefixIcon,
              color: AppColors.pureWhite.withAlpha(95),
            ),
            hintText: widget.hintText,
            hintStyle: AppTypography.hintTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              borderSide: BorderSide(
                color: AppColors.pureWhite.withAlpha(95),
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              borderSide: BorderSide(
                color: AppColors.pureWhite.withAlpha(95),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              borderSide: BorderSide(color: AppColors.primaryBlue, width: 3.0),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => isSecure = !isSecure),
                    icon: Icon(
                      isSecure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.pureWhite.withAlpha(95),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
