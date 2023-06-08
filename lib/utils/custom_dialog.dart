// import 'dart:io' show Platform;

import 'package:flutter/material.dart';

const Color kDarkGray = Color(0xFFA3A3A3);

class CustomDialog {
  static void show(context, String heading, String subHeading,
      String positiveButtonText, Function onPressedPositive,
      [String? negativeButtonText, Function? onPressedNegative]) {
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          heading,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          subHeading,
          style: const TextStyle(
            color: kDarkGray,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (onPressedNegative != null) {
                onPressedNegative();
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(
              negativeButtonText ?? 'Cancel',
              style: const TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () => onPressedPositive,
            child: Text(positiveButtonText),
          ),
        ],
      ),
    );
  }
}
