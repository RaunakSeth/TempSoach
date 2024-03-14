import 'package:flutter/material.dart';
import 'package:testing/Utils/image_constant.dart';
import 'package:testing/widgets/custom_icon_button.dart';
import 'package:testing/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class AppbarLeadingIconbutton extends StatelessWidget {
  AppbarLeadingIconbutton({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          height: 61,
          width: 61,
          child: CustomImageView(
            imagePath: ImageConstant.imgLock,
          ),
        ),
      ),
    );
  }
}
