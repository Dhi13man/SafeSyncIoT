import 'package:moor_flutter/moor_flutter.dart';

import 'sharedDatabase.dart';

SharedDatabase constructMobileDb() {
  return SharedDatabase(
      FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
}
