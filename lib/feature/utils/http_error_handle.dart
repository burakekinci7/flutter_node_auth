import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}

void httpHandleError({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSucces,
}) {
  switch (response.statusCode) {
    case 200:
      onSucces();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;

    default:
      showSnackBar(context, response.body);
  }
}
