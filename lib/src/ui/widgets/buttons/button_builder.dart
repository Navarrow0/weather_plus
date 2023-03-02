

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_plus/src/utils/utils.dart';

class ButtonBuilder extends StatelessWidget {
  final VoidCallback? onPressed;
  final ButtonType buttonType;
  Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final String label;
  final bool? isActive;
  Color? backgroundColor;
  final double? fontSize;
  final Color _baseColor = const Color.fromRGBO(61, 90, 241, 1);

  ButtonBuilder({
    Key? key,
    this.onPressed,
    required this.buttonType,
    this.foregroundColor,
    this.padding = const EdgeInsets.all(24.0),
    required this.label,
    this.isActive,
    this.backgroundColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    createStyle();

    OutlinedBorder? shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    );

    return SizedBox(
      width: double.infinity,
      child:
      buttonType == ButtonType.outlined || buttonType == ButtonType.toggle
          ? OutlinedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            foregroundColor: _baseColor,
            side: BorderSide(
                width: 1,
                color: buttonType == ButtonType.outlined
                    ? _baseColor: _baseColor),
            padding: padding,
            shape: shape),
        child: _buildLabel(),
      )
          : TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: padding,
            shape: shape,
          ),
          child: buttonType == ButtonType.iconArrow
              ? _buildLabelWithArrow()
              : _buildLabel()),
    );
  }

  Widget _buildLabelWithArrow() {
    return Row(
      children: [
        _buildLabel(),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 17.0,
        )
      ],
    );
  }

  Widget _buildLabel() {
    return Text(
      label,
      style: TextStyle(fontSize: fontSize?.sp),
    );
  }

  void createStyle() {
    switch (buttonType) {
      case ButtonType.flat:
        foregroundColor = const Color.fromRGBO(255, 255, 255, 1);
        backgroundColor = onPressed != null
            ? _baseColor
            : const Color.fromRGBO(211, 216, 226, 1);
        break;
      case ButtonType.text:
        foregroundColor = _baseColor;
        break;
      case ButtonType.iconArrow:
        foregroundColor = _baseColor;
        break;
      case ButtonType.outlined:
        foregroundColor = _baseColor;
        break;
      case ButtonType.toggle:
        foregroundColor = isActive! ? Colors.white : _baseColor;
        backgroundColor = isActive! ? _baseColor : Colors.white;
        break;
      case ButtonType.rounded:
        foregroundColor = const Color.fromRGBO(255, 255, 255, 1);
        backgroundColor = backgroundColor;
        break;
    }
  }
}