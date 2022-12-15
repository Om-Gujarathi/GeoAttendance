import 'dart:convert';
import 'package:edi/common/custom_button.dart';
import 'package:edi/common/custom_textfield.dart';
import 'package:edi/constants/global_variables.dart';
import 'package:edi/providers/user_provider.dart';
import 'package:edi/screens/biometric_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Locate extends StatefulWidget {
  const Locate({super.key});

  @override
  State<Locate> createState() => _LocateState();
}

class _LocateState extends State<Locate> {
  final TextEditingController _courseIdController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showBiometric = false;
  bool isAuthenticated = false;
  @override
  void initState() {
    isBiometricsAvailable();
    super.initState();
  }

  isBiometricsAvailable() async {
    showBiometric = await BiometricHelper().hasEnrolledBiometrics();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String name =
        Provider.of<UserProvider>(context, listen: false).user.name;
    return SafeArea(
      child: Column(children: [
        Text(
          'Welcome $name',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8.0),
          color: GlobalVariables.backgroundColor,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _courseIdController,
                  hintText: 'Course ID',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _dateController,
                  hintText: 'Date',
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'MARK ATTENDANCE',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      getlocation();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void getlocation() async {
    if (await fingerprint() == false) {
      return;
    } else {
      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      var posi = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      double dist = Geolocator.distanceBetween(
          posi.latitude, posi.longitude, 18.463627484687272, 73.86820606393962);

      print(dist);

      if (dist >= 100000) {
        Fluttertoast.showToast(
            msg: 'Cannot mark attendance from outside of vit');
      } else {
        await markAttendance(
            context: context,
            prn: Provider.of<UserProvider>(context, listen: false).user.id,
            courseid: _courseIdController.text,
            date: _dateController.text);
      }
    }
  }

  Future<void> markAttendance(
      {required BuildContext context,
      required String prn,
      required String courseid,
      required String date}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/edi/addattendance'),
        body: jsonEncode({
          "courseid": courseid,
          "date": date,
          "prn": prn,
          "attended": "present"
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      String? canAttend =
          await howIsModify(context: context, courseid: courseid, date: date);
      print("Attendance Startted : ");
      print(canAttend);
      if (canAttend == null || canAttend == "false") {
        Fluttertoast.showToast(msg: "Faculty has not started the Attendance");
      } else {
        Fluttertoast.showToast(msg: "ATTENDANCE HAS BEEN MARKED");
      }
    } catch (e) {
      print("ERROR! COULD NOT MARK YOUR ATTENDANCE");
    }
  }

  Future<String?> howIsModify(
      {required BuildContext context,
      required String courseid,
      required String date}) async {
    try {
      print(courseid + " " + date);
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

      var x = jsonDecode(res.body);
      print(x);
      return x['result'][0]['courseinfo'][0]['modify'];
    } catch (e) {
      print(e);
    }
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
      print(data.keys);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> fingerprint() async {
    isAuthenticated = await BiometricHelper().authenticate();
    return isAuthenticated;
  }
}
