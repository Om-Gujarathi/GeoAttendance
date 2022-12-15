import 'package:edi/common/bottom_bar.dart';
import 'package:edi/constants/global_variables.dart';
import 'package:edi/features/auth/services/auth_service.dart';
import 'package:edi/features/home/home_screen2.dart';
import 'package:edi/features/home/loginscreen.dart';
import 'package:edi/providers/user_provider.dart';
import 'package:edi/routes.dart';
import 'package:edi/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: ((routeSettings) => generateRoute(routeSettings)),
      home: SplashScreen(),
    );
  }
}
//VIT LATITUDE LONGITUDE 18.463627484687272, 73.86820606393962
