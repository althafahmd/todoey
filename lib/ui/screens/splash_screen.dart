import 'package:flutter/material.dart';

import 'task_screen.dart';
import '../../utilities/app_typography.dart';
import '../../utilities/screen_size_config.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation shapeAnimation;

  @override
  void initState() {
    super.initState();
    _next(context);
    animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    animationController.forward();

    animationController.addListener(() {
      setState(() {});
    });

    shapeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    );
  }

  Future<void> _next(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushNamed(context, TaskScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '👋🏻',
          style: AppTypography.titleMedium.copyWith(
            fontSize: ScreenSizeConfig.screenWidth * shapeAnimation.value / 5,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
