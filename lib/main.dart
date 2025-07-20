import 'package:flutter/material.dart';

import 'ui/screens/task_screen.dart';
import 'utilities/app_colors.dart';
import 'utilities/screen_size_config.dart';

void main() {
  runApp(const Todoey());
}

class Todoey extends StatelessWidget {
  const Todoey({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(scaffoldBackgroundColor: AppColors.cardColor),
      home: TaskScreen(),
    );
  }
}
