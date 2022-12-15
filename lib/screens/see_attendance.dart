import 'dart:convert';
import 'package:collection/src/iterable_extensions.dart';
import 'package:edi/common/fielid_title.dart';
import 'package:edi/constants/global_variables.dart';
import 'package:edi/providers/user_provider.dart';
import 'package:edi/screens/temp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SeeAttendance extends StatefulWidget {
  const SeeAttendance({super.key});

  @override
  State<SeeAttendance> createState() => _SeeAttendanceState();
}

class _SeeAttendanceState extends State<SeeAttendance> {
  final _getAttendanceFormKey = GlobalKey<FormState>();
  final TextEditingController _courseIdController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  var screenHeight;
  var screenWidth;

  bool? ispresent;

  @override
  Widget build(BuildContext context) {
    final String name =
        Provider.of<UserProvider>(context, listen: false).user.name;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.pushNamed(context, Logout.routeName);
          }),
          backgroundColor: GlobalVariables.violetcolor,
          elevation: 0.0,
          child: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text("See Attendance"),
          centerTitle: true,
          backgroundColor: GlobalVariables.violetcolor,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _getAttendanceFormKey,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth / 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    FieldTitle(title: 'Course ID'),
                    customField('Enter Course ID', _courseIdController, false),
                    SizedBox(height: 8),
                    FieldTitle(title: 'Date'),
                    customField('Enter Date', _dateController, false),
                    GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        String id = _courseIdController.text.trim();
                        String date = _dateController.text.trim();

                        if (id.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Course ID is still empty!"),
                          ));
                        } else if (date.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Date is still empty!"),
                          ));
                        } else {
                          print('Fetching attendance...');
                          await getAttendance(
                              context: context,
                              courseid: _courseIdController.text,
                              date: _dateController.text,
                              prn: Provider.of<UserProvider>(context,
                                      listen: false)
                                  .user
                                  .id);
                        }
                      },
                      child: Container(
                        height: 60,
                        width: screenWidth,
                        margin: EdgeInsets.only(top: screenHeight / 40),
                        decoration: const BoxDecoration(
                          color: GlobalVariables.violetcolor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Center(
                          child: Text(
                            "SEE ATTENDANCE",
                            style: TextStyle(
                              fontFamily: "NexaBold",
                              fontSize: screenWidth / 26,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (ispresent != null)
                      Text(
                        '$name is marked PRESENT!',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget customField(
      String hint, TextEditingController controller, bool obscure) {
    return Container(
      width: screenWidth,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth / 6,
            child: Icon(
              Icons.person,
              color: GlobalVariables.violetcolor,
              size: screenWidth / 15,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth / 12),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hint,
                ),
                maxLines: 1,
                obscureText: obscure,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> getAttendance(
      {required BuildContext context,
      required String courseid,
      required String date,
      required String prn}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/edi/howIsModify'),
        body: jsonEncode({"courseid": courseid, "date": date, "prn": prn}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      var x = jsonDecode(res.body) as Map;
      if (x['result'][0]['courseinfo'][0]['classattendance'] == null) {
        ispresent = false;
        return;
      }
      var data = x['result'][0]['courseinfo'][0]['classattendance'] as Map;
      var pre = data.keys.toList().firstWhere(
            (item) => item == prn,
            orElse: () => "absent",
          );
      if (pre == "absent") {
        ispresent = false;
      } else {
        ispresent = true;
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
}
