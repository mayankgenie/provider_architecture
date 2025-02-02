import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service that is responsible for storing/retrieving data in/from
/// local storage using the [SharedPreferences] package.
class KeyStorageServiceImpl implements KeyStorageService {
  static const loggedin_key = 'hasLoggedIn';
  static const night_mode_key = 'nightMode';

  static KeyStorageServiceImpl _instance;
  static SharedPreferences _preferences;

  static Future<KeyStorageServiceImpl> getInstance() async {
    if (_instance == null) {
      _instance = KeyStorageServiceImpl();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  @override
  bool get hasLoggedIn => _getFromDisk(loggedin_key) ?? false;
  set hasLoggedIn(bool value) => _saveToDisk(loggedin_key, value);

  @override
  bool get nightMode => _getFromDisk(night_mode_key) ?? false;
  set nightMode(bool value) => _saveToDisk(night_mode_key, value);

  dynamic _getFromDisk(String key) {
    final value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
