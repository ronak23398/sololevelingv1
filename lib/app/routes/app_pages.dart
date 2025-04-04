import 'package:get/get.dart';
import 'package:solo_leveling_v1/app/bindings/auth_binding.dart';
import 'package:solo_leveling_v1/app/bindings/home_binding.dart';
import 'package:solo_leveling_v1/app/screens/auth/login_screen.dart';
import 'package:solo_leveling_v1/app/screens/auth/signup_screen.dart';
import 'package:solo_leveling_v1/app/screens/home_screen.dart';
import 'package:solo_leveling_v1/app/screens/profile_screen.dart';
import 'package:solo_leveling_v1/app/screens/task_screen.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.TASKS,
      page: () => TaskScreen(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileScreen(),
    ),
  ];
}

abstract class Routes {
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const HOME = '/home';
  static const TASKS = '/tasks';
  static const PROFILE = '/profile';
}
