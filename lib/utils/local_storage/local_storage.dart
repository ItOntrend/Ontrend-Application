library local_storage;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

part 'hive_box.dart';
part 'hive_keys.dart';

class LocalStorage {
  LocalStorage._();
  static final _instance = LocalStorage._();
  static LocalStorage get instance => _instance;

  Future<void> initHive() async {
    String? directoryPath;

    if (Platform.isIOS) {
      final directory = await path.getApplicationSupportDirectory();
      directoryPath = directory.path;
    }

    await Hive.initFlutter(directoryPath);
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  Future<void> closeBox<T>(String boxName) async {
    final box = await _getBoxByName(boxName);
    await box!.close();
  }

  Future<void> writeData<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    final box = await _getBoxByName(boxName);
    String encodedValue = json.encode(value);
    await box!.put(key, encodedValue);
  }

  Future<void> writeDataToPrefs<T>({
    required String key,
    required T value,
  }) async {
    final box = await SharedPreferences.getInstance();
    String encodedValue = json.encode(value);
    await box.setString(key, encodedValue);
  }

  Future<T?> readData<T>({
    required String boxName,
    required String key,
  }) async {
    final box = await _getBoxByName(boxName);
    final encodedString = await box!.get(key);
    if (encodedString != null) {
      T? decodedData = json.decode(encodedString);
      return decodedData;
    } else {
      return null;
    }
  }

  Future<T?> dataFromPrefs<T>({
    required String key,
  }) async {
    final box = await SharedPreferences.getInstance();
    final encodedString = box.getString(key);
    if (encodedString != null) {
      T? decodedData = json.decode(encodedString);
      return decodedData;
    } else {
      return null;
    }
    
  }

  Future<void> deleteData<T>({
    required String boxName,
    String? key,
  }) async {
    final box = await _getBoxByName(boxName);
    if (key != null) {
      await box!.delete(key);
    } else {
      await box!.clear();
    }
  }

  Future<void> clearPrefs() async {
    final box = await SharedPreferences.getInstance();
    await box.clear();
  }

  Box? user;
  Box? commonBox;

  Future<Box?> _getBoxByName<T>(String boxName) async {
    switch (boxName) {
      case HiveBox.user:
        user ??= await openBox(boxName);
        return user;
      default:
        commonBox ??= await openBox(HiveBox.commonBox);
        return commonBox;
    }
  }
}
