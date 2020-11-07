import 'dart:io';
import 'package:moor/moor.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:safe_sync/Backend/constants.dart';

class MoorSQLToCSV {
  final List<DataClass> _table;
  String csvFileName;
  String pathToFile;

  Future<File> _file;
  bool _permitted = true, _prExisting;
  Future<bool> _status;

  Future<bool> get wasCreated => _status;

  MoorSQLToCSV(this._table, {this.csvFileName = 'table'}) {
    /** Pass [_table] is a List<DataClass> that the utility iterates over, to generate CSV.
    *   [csvFileName] is the file name that generated CSV is to be stored as
    */
    String _csvBody = _generateCSVBody();

    getPermission().then((value) => _permitted = value);
    this._file = _localFile(csvFileName);
    this._prExisting = false;

    _status = _writeToCSV(_csvBody);
  }

  String _generateCSVBody() {
    String out = '';
    Map<String, dynamic> _template = _table[0].toJson();

    // Create headings
    _template.forEach((key, value) {
      out += '$key,';
    });
    out = out.replaceRange(out.length, out.length, '\n');

    _table.forEach((element) {
      _template = element.toJson();
      _template.forEach((key, value) {
        out += '$value,';
      });
      out = out.replaceRange(out.length, out.length, '\n');
    });
    return out;
  }

  Future<bool> getPermission() async {
    // Don't need permission for desktop devices
    if (!Platform.isIOS && !Platform.isAndroid) return true;
    PermissionStatus permissionResult = await Permission.storage.request();
    return (permissionResult == PermissionStatus.granted);
  }

  Future<String> get localPath async {
    return await importantConstants.fileSavePath();
  }

  Future<File> _localFile(String name, {String initial = ''}) async {
    final String path = await localPath;
    pathToFile = '$path/$name.csv';
    final File thisFile = File(pathToFile);

    if (!_permitted) _permitted = await getPermission();

    _prExisting = await thisFile.exists();
    if (!_prExisting) thisFile.writeAsString(initial);

    return thisFile;
  }

  Future<bool> _writeToCSV(String S) async {
    // Write the file
    final File thisFile = await _file;
    if (!_permitted) _permitted = await getPermission();
    if (!_permitted) return false; // Still not permitted. Error.
    thisFile.writeAsString(S);
    return true; // Success
  }
}
