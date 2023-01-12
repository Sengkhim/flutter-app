import 'package:flutter/material.dart';

class CustomDialog {
  // CustomDialog({this.actions});
  static void showDialogs<T>(BuildContext context,
      {List<Widget>? actions, ShapeBorder? shape}) async {
    await showDialog<T>(
        builder: (context) {
          return AlertDialog(
              alignment: Alignment.center,
              shape: shape,
              contentPadding: const EdgeInsets.only(top: 10.0),
              actions: actions);
        },
        context: context);
  }
}
