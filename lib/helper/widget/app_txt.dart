import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  final String text;

  // Custom style
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final double? height;
  final TextDecoration? decoration;

  // Text config
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const Txt(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: defaultStyle?.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
        decoration: decoration,
      ),
    );
  }
}
