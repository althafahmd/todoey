import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';

import 'ui/screens/splash_screen.dart';
import 'core/hive_model/task_model.dart';
import 'ui/screens/task_screen.dart';
import 'utilities/app_colors.dart';
import 'utilities/screen_size_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');
  runApp(const Todoey());
}

class Todoey extends StatelessWidget {
  const Todoey({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        TaskScreen.id: (context) => TaskScreen(),
      },
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(scaffoldBackgroundColor: AppColors.cardColor),
    );
  }
}
