import 'dart:convert';
import 'package:edi/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EdiService {
  //Add New Course:
  Future<void> addCourse({
    required BuildContext context,
    required String coursename,
    required String courseid,
  }) async {
    try {
      await http.post(
        Uri.parse('$uri/edi/addcourse'),
        body: jsonEncode({
          "courseid": courseid,
          "coursename": coursename,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Fluttertoast.showToast(msg: "Course Added Sucessfully");
    } catch (e) {
      print(e);
    }
  }

  //Add New Date:
  Future<void> addDate(
      {required BuildContext context,
      required String courseid,
      required String date}) async {
    try {
      await http.post(
        Uri.parse('$uri/edi/adddate'),
        body: jsonEncode({
          "courseid": courseid,
          "adddate": date,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Fluttertoast.showToast(msg: "Date Added Sucessfully");
    } catch (e) {
      print(e);
    }
  }

  Future<void> modifyOn(
      {required BuildContext context,
      required String courseid,
      required String date}) async {
    try {
      await http.post(
        Uri.parse('$uri/edi/modifyOn'),
        body: jsonEncode({
          "courseid": courseid,
          "date": date,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Fluttertoast.showToast(msg: "Students can now mark their attendance");
    } catch (e) {
      print(e);
    }
  }

  Future<void> modifyOff(
      {required BuildContext context,
      required String courseid,
      required String date}) async {
    try {
      await http.post(
        Uri.parse('$uri/edi/modifyOff'),
        body: jsonEncode({
          "courseid": courseid,
          "date": date,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      Fluttertoast.showToast(msg: "Attendance cannot be modified now");
    } catch (e) {
      print(e);
    }
  }
}
