import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../core/consts/app_conts.dart';

class LocalStorage {
  final hive = Hive;

  init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();

    hive.init(appDocumentDirectory.path);
    await hive.openBox(LocalStorageConstants.boxName);
  }

  add({@required String key, @required String value}) async {
    await hive.box(LocalStorageConstants.boxName).put(key, value);
  }

  delete({@required String key}) async {
    await hive.box(LocalStorageConstants.boxName).delete(key);
  }

  String read({@required String key}) {
    return hive.box(LocalStorageConstants.boxName).get(key);
  }
}
