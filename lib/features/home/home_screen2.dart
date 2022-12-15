import 'package:edi/constants/global_variables.dart';
import 'package:edi/features/auth/services/auth_service.dart';
import 'package:edi/features/home/griddashboard.dart';
import 'package:edi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthService().logOut(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("ADMIN PANNEL",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: GlobalVariables.secondaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
      ),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Welcome, Prof. ${user.name}",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Home",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                // IconButton(
                //   alignment: Alignment.topCenter,
                //   icon: Image.asset(
                //     "assets/notification.png",
                //     width: 24,
                //   ),
                //   onPressed: () {},
                // )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          GridDashboard()
        ],
      ),
    );
  }
}
