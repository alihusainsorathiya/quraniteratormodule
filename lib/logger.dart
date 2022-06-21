import 'package:flutter/material.dart';

class Log {
  Log(dynamic value) {
    debugPrint("=============== Logger : " + value.toString());
  }

  Logg(dynamic text, dynamic value) {
    debugPrint(
        "=============== Logger : " + text.toString() + value.toString());
  }
}
