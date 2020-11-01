import 'dart:io';

import 'package:moor_flutter/moor_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as paths;

import 'datafiles/Database.dart';

Database createDb() {
  if (Platform.isIOS || Platform.isAndroid) {
    final executor = LazyDatabase(() async {
      final dataDir = await paths.getApplicationDocumentsDirectory();
      final dbFile = p.join(dataDir.path, 'db.sqlite');
      return FlutterQueryExecutor.inDatabaseFolder(path: dbFile);
    });
    return Database(executor);
  }
  //if (Platform.isMacOS || Platform.isLinux || Platform.isWindows)
  else {
    // final file = File('db.sqlite');
    return Database(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
  }
}
