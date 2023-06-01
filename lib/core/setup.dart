import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
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

class FlutterBindingInitializer {
  static void initialize() {
    WidgetsFlutterBinding.ensureInitialized();
  }
}

class ObjectBoxStorageInitializer {
  static Future<Store> initialize() async {
    return (await ObjectBoxStorage.create()).store;
  }
}

class DependencyInitializer {
  static void initialize() {
    di.init();
  }
}

class Application {
  Future<void> runApp() async {
    FlutterBindingInitializer.initialize();
    store = await ObjectBoxStorageInitializer.initialize();
    DependencyInitializer.initialize();
  }
}
