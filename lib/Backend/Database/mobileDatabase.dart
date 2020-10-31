import 'dart:io';
import 'package:path_provider/path_provider.dart' as paths;
import 'package:path/path.dart' as p;
import 'package:moor_flutter/moor_flutter.dart';

import 'sharedDatabase.dart';

class MobileDb extends SharedDatabase {
  MobileDb() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  SharedDatabase create() {
    if (Platform.isIOS || Platform.isAndroid) {
      final executor = LazyDatabase(() async {
        final dataDir = await paths.getApplicationDocumentsDirectory();
        final dbFile = p.join(dataDir.path, 'db.sqlite');
        return FlutterQueryExecutor.inDatabaseFolder(path: dbFile);
      });
      return SharedDatabase(executor);
    }
    //if (Platform.isMacOS || Platform.isLinux || Platform.isWindows)
    else {
      // final file = File('db.sqlite');
      return SharedDatabase(
          FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
    }
  }
}
