import 'package:flutter/material.dart';

showSnackbar(String message, BuildContext context) {
  ScaffoldMessengerState().removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
