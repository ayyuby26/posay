import 'package:flutter/material.dart';
import 'package:posay/injection.dart' as di;

class SetUp {
  static Future<void> base() async {
    di.init();
    WidgetsFlutterBinding.ensureInitialized();
  }
}
