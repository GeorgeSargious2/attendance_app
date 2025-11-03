import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
import 'loader.dart';

enum ButtonType { primary, outlined, text }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final ButtonType buttonType;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? loadingIndicatorColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final double borderRadius;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isDisabled;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.buttonType = ButtonType.primary,
    this.height = 52.0,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.loadingIndicatorColor,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.borderRadius = 12.0,
    this.leadingIcon,
    this.trailingIcon,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
    // final ColorScheme colorScheme = theme.colorScheme;
    final bool trulyDisabled = isDisabled || isLoading;

    final baseTextStyle = TextStyle(
      fontSize: (fontSize ?? 16).sp,
      fontWeight: fontWeight ?? FontWeight.w600,
      letterSpacing: 0,
    );

    Widget loadingWidget = Loader(
      size: (height ?? 52).h * 0.5,
      color: loadingIndicatorColor ??
          _resolveForegroundColor(context, WidgetState.disabled),
    );

    Widget buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) ...[
          WidgetStatePropertyBuilder(
            states: trulyDisabled ? {WidgetState.disabled} : {},
            builder: (context, states) => IconTheme(
              data: IconThemeData(
                  color: _resolveForegroundColor(context, states.firstOrNull),
                  size: (fontSize ?? 16).sp * 1.2),
              child: leadingIcon!,
            ),
          ),
          SizedBox(width: 8.w),
        ],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (trailingIcon != null) ...[
          SizedBox(width: 8.w),
          WidgetStatePropertyBuilder(
            states: trulyDisabled ? {WidgetState.disabled} : {},
            builder: (context, states) => IconTheme(
              data: IconThemeData(
                  color: _resolveForegroundColor(context, states.firstOrNull),
                  size: (fontSize ?? 16).sp * 1.2),
              child: trailingIcon!,
            ),
          ),
        ],
      ],
    );

    final ButtonStyle commonStyle = ButtonStyle(
      minimumSize:
          WidgetStateProperty.all(Size(width?.w ?? 0, (height ?? 52).h)),
      maximumSize: WidgetStateProperty.resolveWith((states) {
        return Size(width?.w ?? double.infinity, (height ?? 52).h);
      }),
      padding: WidgetStateProperty.all(
          padding ?? EdgeInsets.symmetric(horizontal: 20.w)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
      textStyle: WidgetStateProperty.all(baseTextStyle),
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled) ||
            buttonType == ButtonType.text ||
            buttonType == ButtonType.outlined) {
          return 0;
        }
        if (states.contains(WidgetState.pressed)) return 1;
        return 0;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          final overlayBase = _resolveForegroundColor(context, null);
          return overlayBase?.withValues(alpha: 0.12);
        }
        return Colors.transparent;
      }),
    );

    switch (buttonType) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: trulyDisabled ? null : onPressed,
          style: commonStyle.copyWith(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return ColorsManager.main.withValues(alpha: 0.5);
              }
              return backgroundColor ?? ColorsManager.main;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return ColorsManager.white.withValues(alpha: 0.7);
              }
              return foregroundColor ?? ColorsManager.white;
            }),
          ),
          child: isLoading ? loadingWidget : buttonContent,
        );

      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: trulyDisabled ? null : onPressed,
          style: commonStyle.copyWith(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              return backgroundColor ?? Colors.transparent;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return ColorsManager.grey;
              }

              return foregroundColor ?? ColorsManager.textDark;
            }),
            side: WidgetStateProperty.resolveWith((states) {
              Color color;
              if (states.contains(WidgetState.disabled)) {
                color = ColorsManager.borderGrey;
              } else {
                color = borderColor ?? ColorsManager.borderGrey;
              }
              return BorderSide(color: color, width: 1.5);
            }),
          ),
          child: isLoading ? loadingWidget : buttonContent,
        );

      case ButtonType.text:
        return TextButton(
          onPressed: trulyDisabled ? null : onPressed,
          style: commonStyle.copyWith(
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return ColorsManager.grey;
              }

              return foregroundColor ?? ColorsManager.main;
            }),
          ),
          child: isLoading ? loadingWidget : buttonContent,
        );
    }
  }

  Color? _resolveForegroundColor(BuildContext context, WidgetState? state) {
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isDisabledState = state == WidgetState.disabled;

    switch (buttonType) {
      case ButtonType.primary:
        if (isDisabledState) return ColorsManager.white.withValues(alpha: 0.7);
        return foregroundColor ?? ColorsManager.white;
      case ButtonType.outlined:
        if (isDisabledState) return ColorsManager.grey;
        return foregroundColor ?? ColorsManager.textDark;
      case ButtonType.text:
        if (isDisabledState) return ColorsManager.grey;
        return foregroundColor ?? ColorsManager.main;
    }
  }
}

class WidgetStatePropertyBuilder<T> extends StatelessWidget {
  final Set<WidgetState> states;
  final Widget Function(BuildContext context, Set<WidgetState> states) builder;

  const WidgetStatePropertyBuilder({
    super.key,
    required this.states,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, states);
  }
}
