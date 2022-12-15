import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  final String title;
  const FieldTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 26,
          fontFamily: "NexaBold",
        ),
      ),
    );
  }
}
