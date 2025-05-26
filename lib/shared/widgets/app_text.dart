import 'package:flutter/material.dart';

enum AppTextType { h1, h2, h3, h4, h5, h6, body, bodyBold, caption, captionBold, button, small, smallBold }

class AppText extends StatelessWidget {
  final String text;
  final AppTextType type;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    super.key,
    this.type = AppTextType.body,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style;
    switch (type) {
      case AppTextType.h1:
        style = const TextStyle(
          fontFamily: 'Geist',
          fontSize: 32,
          fontWeight: FontWeight.bold,
        );
        break;
      case AppTextType.h2:
        style = const TextStyle(
          fontFamily: 'Geist',
          fontSize: 28,
          fontWeight: FontWeight.bold,
        );
        break;
      case AppTextType.h3:
        style = const TextStyle(
          fontFamily: 'Geist',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        );
        break;
      case AppTextType.h4:
        style = const TextStyle(
          fontFamily: 'Geist',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        );
        break;
      case AppTextType.h5:
        style = const TextStyle(
          fontFamily: 'Geist',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        );
        break;
      case AppTextType.h6:
        style = const TextStyle(
          fontFamily: 'Geist',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        );
        break;
      case AppTextType.body:
        style = const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.normal,
        );
        break;
      case AppTextType.bodyBold:
        style = const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        );
        break;
      case AppTextType.caption:
        style = const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.normal,
        );
        break;
      case AppTextType.captionBold:
        style = const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        );
        break;
      case AppTextType.button:
        style = const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        );
        break;
      case AppTextType.small:
        style = const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
        );
        break;
      case AppTextType.smallBold:
        style = const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        );
    }
    if (color != null) style = style.copyWith(color: color);
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
} 