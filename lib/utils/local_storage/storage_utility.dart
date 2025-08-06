import 'package:get_storage/get_storage.dart';

class GLocalStorage {
  static final GLocalStorage _instance = GLocalStorage._internal();

  factory GLocalStorage() {
    return _instance;
  }

  GLocalStorage._internal();

  final _storage = GetStorage();

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? getData<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearStorage() async {
    await _storage.erase();
  }

  bool containsKey(String key) {
    return _storage.hasData(key);
  }
}
