// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:posay/objectbox.g.dart';

class ObjectBoxStorage {
  final Store store;
  ObjectBoxStorage._create(this.store);

  static Future<ObjectBoxStorage> create() async {
    final dir = await getApplicationDocumentsDirectory();

    Store store =
        await openStore(directory: p.join(dir.path, 'objectboxstorage'));

    return ObjectBoxStorage._create(store);
  }
}
