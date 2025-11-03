import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.textInputAction,
    this.labelText,
    this.keyboardType,
    this.controller,
    super.key,
    this.onChanged,
    this.onSave,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.onEditingComplete,
    this.autofocus,
    this.focusNode,
    this.hintText,
    this.padding = 16,
    // this.border = true,
    this.textAlignVertical,
    this.textAlign,
    this.contentPadding,
    this.maxLines,
    this.inputFormatters,
    this.onTapOutside,
    this.fillColor,
    this.filled,
    this.enabled,
    this.borderRadius,
    this.borderColor,
  });
  final void Function(String)? onChanged;
  final void Function(String?)? onSave;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final bool? autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  // final bool? border;
  final double? padding;
  final TextAlignVertical? textAlignVertical;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(PointerDownEvent)? onTapOutside;
  final Color? fillColor;
  final bool? filled;
  final bool? enabled;
  final double? borderRadius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputDecorationTheme = theme.inputDecorationTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: padding!.h),
      child: TextFormField(
        enabled: enabled ?? true,
        onTapOutside: onTapOutside ??
            (event) => FocusScope.of(context).unfocus(), // Default unfocus
        inputFormatters: inputFormatters ?? [],
        maxLines: maxLines ?? 1,
        textAlignVertical: textAlignVertical,
        textAlign: textAlign ?? TextAlign.start,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onChanged: onChanged,
        onSaved: onSave,
        autofocus: autofocus ?? false,
        validator: validator,
        obscureText: obscureText ?? false,
        obscuringCharacter: '●',
        onEditingComplete: onEditingComplete,
        cursorColor: ColorsManager.main,
        style:
            theme.textTheme.bodyLarge?.copyWith(color: ColorsManager.textDark),
        decoration: InputDecoration(
          labelText: labelText, // Keep label if provided
          hintText: hintText,
          hintStyle: inputDecorationTheme.hintStyle ??
              theme.textTheme.bodyLarge
                  ?.copyWith(color: ColorsManager.textLight),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          filled: filled ?? true,
          fillColor: fillColor ?? ColorsManager.lightGrey,
          // floatingLabelBehavior: FloatingLabelBehavior.never,

          border: _createInputBorder(inputDecorationTheme.border,
              theme.colorScheme.onSurface.withOpacity(0.12)),
          enabledBorder: _createInputBorder(
              inputDecorationTheme.enabledBorder,
              borderColor ??
                  Colors.transparent), // No border when enabled and unfocused
          focusedBorder: _createInputBorder(inputDecorationTheme.focusedBorder,
              ColorsManager.main), // Theme color border on focus
          errorBorder: _createInputBorder(
              inputDecorationTheme.errorBorder, ColorsManager.red),
          focusedErrorBorder: _createInputBorder(
              inputDecorationTheme.focusedErrorBorder,
              ColorsManager.red.withOpacity(0.5)),
          disabledBorder: _createInputBorder(
              inputDecorationTheme.disabledBorder,
              ColorsManager.grey.withOpacity(0.2)),

          labelStyle: inputDecorationTheme.labelStyle,
          errorStyle: inputDecorationTheme.errorStyle,
          floatingLabelStyle: inputDecorationTheme.floatingLabelStyle,
          prefixIconColor: inputDecorationTheme.prefixIconColor,
          suffixIconColor: inputDecorationTheme.suffixIconColor,
        ),
      ),
    );
  }

  InputBorder _createInputBorder(InputBorder? themeBorder, Color color) {
    final defaultRadius = BorderRadius.circular(borderRadius?.r ?? 12.r);

    final radius = (themeBorder is OutlineInputBorder && borderRadius == null)
        ? themeBorder.borderRadius
        : defaultRadius;

    return OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: color,
        width: color == Colors.transparent
            ? 0
            : 1.5, // No width for transparent border
      ),
    );
  }
}
