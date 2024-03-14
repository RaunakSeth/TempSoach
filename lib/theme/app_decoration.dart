import 'package:flutter/material.dart';
import 'package:testing/theme/theme_helper.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

  // Gradient decorations
  static BoxDecoration get gradientGreenToGreenE => BoxDecoration(
        border: Border.all(
          color: appTheme.greenA700.withOpacity(0.44),
          width: 1,
        ),
        gradient: LinearGradient(
          begin: Alignment(0.58, 1),
          end: Alignment(0.57, 0),
          colors: [
            appTheme.green90001,
            appTheme.green800E0,
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlackF => BoxDecoration();
  static BoxDecoration get outlineGreenA => BoxDecoration(
        color: appTheme.whiteA70001,
        border: Border.all(
          color: appTheme.greenA700,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.gray5003f,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
