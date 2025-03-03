import 'package:flutter/material.dart';
import 'package:quitt/res/app_theme.dart';
import 'package:quitt/res/strings.dart';
import 'package:quitt/route/app_route.dart';
import 'package:quitt/utils/firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.quitt,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login, // Default route
      routes: AppRoutes.routes,
    );
  }
}
