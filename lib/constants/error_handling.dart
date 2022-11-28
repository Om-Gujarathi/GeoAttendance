import 'dart:convert';
import 'package:edi/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response responce,
  required BuildContext context,
  required VoidCallback onSucess,
}) {
  switch (responce.statusCode) {
    case 200:
      onSucess();
      break;

    case 400:
      showSnackBar(context, jsonDecode(responce.body)['msg']);
      break;

    case 500:
      showSnackBar(context, jsonDecode(responce.body)['error']);
      break;

    default:
      showSnackBar(context, responce.body);
  }
}
