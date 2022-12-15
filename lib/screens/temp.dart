import 'package:edi/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../constants/global_variables.dart';

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
      appBar: AppBar(
        backgroundColor: GlobalVariables.violetcolor,
        title: const Text('Logout Portal'),
        centerTitle: true,
        toolbarHeight: 60,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            const Image(image: AssetImage("lib/assets/images/6.png"),
              height: 150,
            ),
            SizedBox(height: 80,),
            const Text('Are you sure you want to logout?',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: logOutUser, child: const Text('LOGOUT'),
              style: ElevatedButton.styleFrom(
                primary: GlobalVariables.violetcolor,
              ),)
          ],
        ),
      )),
    );
  }
}
