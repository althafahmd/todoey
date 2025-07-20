import 'package:flutter/material.dart';

import 'screen_size_config.dart';
import 'app_colors.dart';

class AppTypography {
  static const TextStyle titleMedium = TextStyle(
    color: AppColors.pureWhite,
    fontFamily: 'Poppins',
    letterSpacing: 1.0,
    fontWeight: FontWeight.w700,
  );

  static TextStyle titleLarge = TextStyle(
    color: AppColors.pureWhite,
    fontFamily: 'Poppins',
    fontSize: ScreenSizeConfig.screenWidth * 0.2,
    letterSpacing: 1.0,
    fontWeight: FontWeight.w700,
  );

  static TextStyle labelTextStyle = TextStyle(
    color: AppColors.pureWhite,
    fontFamily: 'Poppins',
    letterSpacing: 1.0,
    fontSize: ScreenSizeConfig.screenWidth * 0.05,
    fontWeight: FontWeight.w500,
  );

  static TextStyle taskTextStyle = TextStyle(
    color: AppColors.pureWhite,
    fontFamily: 'Poppins',
    letterSpacing: 1.0,
    fontSize: ScreenSizeConfig.screenWidth * 0.045,
    fontWeight: FontWeight.w500,
  );

  static TextStyle hintTextStyle = TextStyle(
    color: AppColors.textColor,
    fontFamily: 'Poppins',
    letterSpacing: 1.0,
    fontSize: ScreenSizeConfig.screenWidth * 0.05,
    fontWeight: FontWeight.w500,
  );

  static TextStyle buttonTextStyle = TextStyle(
    color: AppColors.pureWhite,
    fontFamily: 'Poppins',
    letterSpacing: 1.0,
    fontSize: ScreenSizeConfig.screenWidth * 0.035,
    fontWeight: FontWeight.w500,
  );
}
