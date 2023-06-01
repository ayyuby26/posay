import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/core/local_storage/object_box_storage.dart';
import 'package:posay/injection.dart' as di;
import 'package:posay/core/local_storage/object_box.dart';

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
  static void initialize(ObjectBox objectBox) {
    di.init(objectBox);
  }
}

class Application {
  Future<void> setup() async {
    FlutterBindingInitializer.initialize();
    final store = await ObjectBoxStorageInitializer.initialize();
   final objectBox =  ObjectBox(store);
    DependencyInitializer.initialize(objectBox);
  }
}
