import 'package:flutter/material.dart';
import 'package:quitt/view/screens/login/login_screen.dart';
import 'package:quitt/view/screens/register/registration.dart';

class AppRoutes {
  // Define route names
  static const String login = '/login';
  static const String registration = '/registration';

  // Route mappings
  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    registration: (context) => RegistrationScreen(),
  };
}
