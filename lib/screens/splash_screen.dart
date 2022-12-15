import 'dart:async';

import 'package:edi/common/bottom_bar.dart';
import 'package:edi/constants/global_variables.dart';
import 'package:edi/features/home/home_screen2.dart';
import 'package:edi/features/home/loginscreen.dart';
import 'package:edi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Provider.of<UserProvider>(context).user.token.isNotEmpty
                      ? Provider.of<UserProvider>(context).user.type == 'user'
                          ? BottomBar()
                          : HomeScreen()
                      : KeyboardVisibilityProvider(child: LoginScreen())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: GlobalVariables.violetcolor,
      ),
    );
  }
}
