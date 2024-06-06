import 'package:flutter/material.dart';
import 'package:testing/theme/custom_text_style.dart';
import 'base_button.dart';

class CustomOutlinedButton2 extends BaseButton {
  CustomOutlinedButton2({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.label,
    VoidCallback? onPressed,
    ButtonStyle? buttonStyle,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    Alignment? alignment,
    double? height,
    double? width,
    EdgeInsets? margin,
    required String text,
  }) : super(
    text: text,
    onPressed: onPressed,
    buttonStyle: buttonStyle,
    isDisabled: isDisabled,
    buttonTextStyle: buttonTextStyle,
    height: height,
    alignment: alignment,
    width: width,
    margin: margin,
  );

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: buildOutlinedButtonWidget,
    )
        : buildOutlinedButtonWidget;
  }

  Widget get buildOutlinedButtonWidget => Container(
    height: this.height ?? 42,
    width: this.width ?? double.maxFinite,
    margin: margin,
    decoration: decoration,
    child: OutlinedButton(
      style: buttonStyle?.copyWith(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFAF2)),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: Color(0xFFFF9C42)),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
          ),
        ),
      ) ?? ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFAF2)),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: Color(0xFFFF9C42)),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
          ),
        ),
      ),
      onPressed: isDisabled ?? false ? null : onPressed ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          Text(
            text,
            style: TextStyle(
              color: Color(0xffF89B1C),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          rightIcon ?? const SizedBox.shrink(),
        ],
      ),
    ),
  );
}