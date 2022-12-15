import 'package:edi/features/auth/screens/view_attendance.dart';
import 'package:edi/features/home/home_screen.dart';
import 'package:edi/screens/temp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
    title: "Create New \n\t   Course",
    subtitle: "",
    event: CreateCourse.routeName,
    img: "assets/.png",
  );

  Items item2 = Items(
    title: "Start New Class",
    subtitle: "",
    event: "",
    img: "assets/.png",
  );
  Items item3 = Items(
    title: "View Attendance",
    subtitle: "",
    event: ViewAttendance.routeName,
    img: "assets/.png",
  );
  Items item4 = Items(
    title: "Activity",
    subtitle: "",
    event: "",
    img: "assets/.png",
  );
  Items item5 = Items(
    title: "To do \n  list",
    subtitle: "",
    event: "",
    img: "assets/.png",
  );
  Items item6 = Items(
    title: "Logout",
    subtitle: "",
    event: Logout.routeName,
    img: "assets/.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    Color color = Color.fromARGB(255, 114, 37, 208);
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, data.event);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset(
                    //   data.img,
                    //   width: 42,
                    // ),
                    // const SizedBox(
                    //   height: 14,
                    // ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}
