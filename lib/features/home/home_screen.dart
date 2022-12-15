import 'package:edi/common/custom_button.dart';
import 'package:edi/common/custom_textfield.dart';
import 'package:edi/constants/global_variables.dart';
import 'package:edi/features/auth/services/edi_service.dart';
import 'package:edi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCourse extends StatefulWidget {
  static const String routeName = '/home-screen';
  CreateCourse({Key? key}) : super(key: key);

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final _formKey = GlobalKey<FormState>();
  final EdiService ediService = EdiService();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseIdController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    String? name = user.name;
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome $name',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              const ListTile(
                tileColor: GlobalVariables.backgroundColor,
                title: Text(
                  'Enter Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _courseNameController,
                        hintText: 'Course Name',
                      ),
                      const SizedBox(height: 10),
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
                        text: 'ADD COURSE',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            ediService.addCourse(
                                context: context,
                                courseid: _courseIdController.text,
                                coursename: _courseNameController.text);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'ADD DATE',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            ediService.addDate(
                                context: context,
                                courseid: _courseIdController.text,
                                date: _dateController.text);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'START',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            ediService.modifyOn(
                                context: context,
                                courseid: _courseIdController.text,
                                date: _dateController.text);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'STOP',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            ediService.modifyOff(
                                context: context,
                                courseid: _courseIdController.text,
                                date: _dateController.text);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
