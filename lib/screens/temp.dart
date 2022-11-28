import 'package:edi/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class Logout extends StatefulWidget {
  static const String routeName = '/logout-screen';
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final AuthService authService = AuthService();

  void logOutUser() {
    authService.logOut(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const Text('Are you sure you want to logout?'),
            ElevatedButton(onPressed: logOutUser, child: const Text('LOGOUT'))
          ],
        ),
      )),
    );
  }
}
