import 'package:flutter/material.dart';

class AppSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final bool enabled;

  const AppSolidButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height = 48,
    this.borderRadius = 12,
    this.backgroundColor = Colors.blue,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = !enabled || isLoading;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: textStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
      ),
    );
  }
}
