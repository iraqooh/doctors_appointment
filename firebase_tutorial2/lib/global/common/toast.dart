import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xff00ff00),
    textColor: Colors.white,
    fontSize: 16.0
  );
}