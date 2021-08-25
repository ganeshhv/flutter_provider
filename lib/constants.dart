import 'dart:io';

import 'package:flutter/material.dart';

class Constants
{
  static Constants? _instance;
  factory Constants() => _instance ??= new Constants._();
  Constants._();

  bool isTabletDevice() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide < 600 ? false : true;
  }
}
