import 'package:flutter/material.dart';
import 'package:posay/core/local_storage/object_box_storage.dart';
import 'package:posay/injection.dart' as di;
import 'package:posay/core/local_storage/object_box.dart';

class SetUp {
  static Future<void> app() async {
    WidgetsFlutterBinding.ensureInitialized();
    store = (await ObjectBoxStorage.create()).store;
    di.init();
  }
}
