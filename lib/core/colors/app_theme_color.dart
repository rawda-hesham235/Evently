import 'package:evently/core/colors/app_color.dart';
import 'package:flutter/material.dart';

abstract class AppThemeColor {
  Color primaryColor();
  Color greyColor();
}

class LightColor extends AppThemeColor {
  @override
  Color greyColor() {
    return AppColor.grayColor;
  }

  @override
  Color primaryColor() {
    return AppColor.blueColor;
  }
}

class DarkColor extends AppThemeColor {
  @override
  Color greyColor() {
    return AppColor.grayLightColor;
  }

  @override
  Color primaryColor() {
    return AppColor.whiteColor;
  }
}
