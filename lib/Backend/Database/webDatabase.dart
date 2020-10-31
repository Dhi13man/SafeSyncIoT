import 'package:moor/moor_web.dart';

import 'sharedDatabase.dart';

class WebDb extends SharedDatabase {
  WebDb() : super(WebDatabase('db'));

  SharedDatabase create() {
    return SharedDatabase(WebDatabase('db'));
  }
}
