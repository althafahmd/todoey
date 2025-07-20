import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_typography.dart';
import '../../utilities/screen_size_config.dart';

class PrimaryButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback onTap;
  late ShapeBorder shape;
  PrimaryButton({
    super.key,
    this.child,
    required this.onTap,
    required this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RawMaterialButton(
        textStyle: AppTypography.buttonTextStyle,
        fillColor: AppColors.primaryBlue,
        shape: shape,
        onPressed: onTap,
        child: SizedBox(
          height: 50.0,
          width: ScreenSizeConfig.screenWidth * 0.85,
          child: Padding(
            padding: EdgeInsets.only(left: 4.0, bottom: 4.0),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
