import 'package:edi/common/fielid_title.dart';
import 'package:edi/constants/global_variables.dart';
import 'package:flutter/material.dart';

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
  List<String>? present;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
          )
        ],
      ),
    );
  }
}
