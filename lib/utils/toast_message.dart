import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showToast({required String message}) async {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey[800],
    textColor: Colors.white,
   toastLength: Toast.LENGTH_LONG
  );
}
