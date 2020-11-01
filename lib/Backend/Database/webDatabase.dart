import 'package:moor/moor_web.dart';

import 'datafiles/Database.dart';

Database createDb() {
  return Database(WebDatabase('db'));
}
