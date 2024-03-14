import 'package:flutter/material.dart';
import 'package:testing/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Display text style
  static get displayLargeWhiteA70001 => theme.textTheme.displayLarge!.copyWith(
        color: appTheme.whiteA70001,
      );
  // Headline text style
  static get headlineSmallInterffffffff =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: Color(0XFFFFFFFF),
        fontSize: 25,
        fontWeight: FontWeight.w700,
      );
  // Label text style
  static get labelLargeWhiteA70001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.whiteA70001,
      );
  static get labelLargec9ffffff => theme.textTheme.labelLarge!.copyWith(
        color: Color(0XC9FFFFFF),
      );
  static get labelLargeffffffff => theme.textTheme.labelLarge!.copyWith(
        color: Color(0XFFFFFFFF),
      );
  static get labelLargeffffffffExtraBold =>
      theme.textTheme.labelLarge!.copyWith(
        color: Color(0XFFFFFFFF),
        fontWeight: FontWeight.w800,
      );
  // Title text style
  static get titleMediumGreenA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.greenA700,
      );
}

extension on TextStyle {
  TextStyle get nunito {
    return copyWith(
      fontFamily: 'Nunito',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
