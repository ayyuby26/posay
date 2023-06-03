import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/core/local_storage/object_box_storage.dart';
import 'package:posay/injection.dart' as di;

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
  static void initialize(Store store) {
    di.init(store);
  }
}

class LoadLanguage {
  
}

class Setup {
  Future<void> init() async {
    FlutterBindingInitializer.initialize();
    final store = await ObjectBoxStorageInitializer.initialize();
    DependencyInitializer.initialize(store);
  }
}
