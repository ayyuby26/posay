import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectbox/objectbox.dart';
import 'package:posay/core/posay_bloc_observer.dart';
import 'package:posay/core/local_storage/object_box_storage.dart';
import 'package:posay/injector.dart';

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
    Injector.init(store);
  }
}

class LoadLanguage {}

class Setup {
  Future<void> init() async {
    FlutterBindingInitializer.initialize();
    final store = await ObjectBoxStorageInitializer.initialize();
    DependencyInitializer.initialize(store);
    Bloc.observer = PosayBlocObserver();
  }
}
