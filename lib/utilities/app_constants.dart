import 'package:flutter/material.dart';

abstract class AppConstants {
  static ShapeBorder primaryButtonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  );

  static ShapeBorder roundButtonShape = CircleBorder(side: BorderSide.none);
}
