import 'dart:convert';
import 'package:edi/common/custom_button.dart';
import 'package:edi/common/custom_textfield.dart';
import 'package:edi/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewAttendance extends StatefulWidget {
  static const String routeName = '/view-attendance-screen';
  const ViewAttendance({super.key});

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  final _getAttendanceFormKey = GlobalKey<FormState>();
  final TextEditingController _courseIdController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List<String>? present;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
              children: [
                const Text(
                  'See Attendance',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _courseIdController,
                  hintText: "Enter Course ID",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _dateController,
                  hintText: 'Enter Date',
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Fetch',
                  onTap: () async {
                    if (_getAttendanceFormKey.currentState!.validate()) {
                      await getData(
                          context: context,
                          courseid: _courseIdController.text,
                          date: _dateController.text);
                    }
                  },
                ),
                const SizedBox(height: 10),
                if (present != null) Text('$present')
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> getData(
      {required BuildContext context,
      required String courseid,
      required String date}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/edi/howIsModify'),
        body: jsonEncode({
          "courseid": courseid,
          "date": date,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var x = jsonDecode(res.body) as Map;
      var data = x['result'][0]['courseinfo'][0]['classattendance'] as Map;
      print(data.keys.toList());
      setState(() {
        present = data.keys.cast<String>().toList();
      });
    } catch (e) {
      print(e);
    }
  }
}
