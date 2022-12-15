import 'package:edi/common/bottom_bar.dart';
import 'package:edi/features/auth/screens/auth_screen.dart';
import 'package:edi/features/auth/screens/create_account.dart';
import 'package:edi/features/auth/screens/view_attendance.dart';
import 'package:edi/features/home/home_screen.dart';
import 'package:edi/features/home/loginscreen.dart';
import 'package:edi/screens/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => AuthScreen(),
      );

      case CreateCourse.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => CreateCourse(),
      );

      case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => BottomBar(),
      );

      case CreateAccount.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const CreateAccount(),
      );

      case Logout.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const Logout(),
      );

      case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => KeyboardVisibilityProvider(child: LoginScreen()),
      );

      case ViewAttendance.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const  ViewAttendance(),
      );
    
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist')
          ),
        ),
      );
  }
}
