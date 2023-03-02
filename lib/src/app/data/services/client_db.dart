import 'package:hive/hive.dart';
import 'package:weather_plus/src/app/data/entities/location.entity.dart';

class ClientDB {
  static Box<LocationEntity>? _sharedPreferences;

  static Future<Box> _getInstance() async {
    _sharedPreferences = await Hive.openBox<LocationEntity>('favorites');
    return _sharedPreferences!;
  }

  static Future<void> saveData({required String key, required dynamic value}) async {
    final box = await _getInstance();
    await box.put(key, value);
  }

  static Future<void> addData({required dynamic value}) async {
    final box = await _getInstance();
    await box.add(value);
  }

  static Future<dynamic> getData({required String key}) async {
    final box = await _getInstance();
    return box.get(key);
  }

  static Future<void> deleteData({required String key}) async {
    final box = await _getInstance();
    await box.delete(key);
  }

  static Future<void> deleteAtData({required int index}) async {
    final box = await _getInstance();
    await box.deleteAt(index);
  }

  static Future<void> clearData() async {
    final box = await _getInstance();
    await box.clear();
  }
}