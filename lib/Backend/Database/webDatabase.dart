import 'package:moor/moor_web.dart';

import 'sharedDatabase.dart';

SharedDatabase constructWebDb() {
  return SharedDatabase(WebDatabase('db'));
}
