import 'package:flutter/material.dart';

void snackbar(BuildContext context,
    {String text, SnackBarAction action, Duration duration}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    action: action,
    duration: duration,
  ));
}
