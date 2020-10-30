import 'package:moor_flutter/moor_flutter.dart';

import 'sharedDatabase.dart';

class MobileDb extends SharedDatabase {
  MobileDb() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
}
