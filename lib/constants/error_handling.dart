import 'dart:convert';

import 'package:amazonclone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackbar(
          context: context, message: jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackbar(
          context: context, message: jsonDecode(response.body)['message']);
      break;
    default:
      showSnackbar(context: context, message: response.body);
  }
}
