import 'dart:convert';

import 'package:test_ide/helper/local_storage.dart';

class AppData {
  static set authInformasi(String value) =>
      LocalStorage.saveToDisk('authInformasi', value);

  static String get authInformasi {
    if (LocalStorage.getFromDisk('authInformasi') != null) {
      return LocalStorage.getFromDisk('authInformasi');
    }
    return "";
  }

  static set passwordUser(String value) =>
      LocalStorage.saveToDisk('passwordUser', value);

  static String get passwordUser {
    if (LocalStorage.getFromDisk('passwordUser') != null) {
      return LocalStorage.getFromDisk('passwordUser');
    }
    return "";
  }

  static set tokenUser(String value) =>
      LocalStorage.saveToDisk('tokenUser', value);

  static String get tokenUser {
    if (LocalStorage.getFromDisk('tokenUser') != null) {
      return LocalStorage.getFromDisk('tokenUser');
    }
    return "";
  }

  // CLEAR ALL DATA

  static void clearAllData() =>
      LocalStorage.removeFromDisk(null, clearAll: true);
}
