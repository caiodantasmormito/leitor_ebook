import 'package:leitor_de_ebooks/app/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedSaveImpl implements ILocalStorageService {
  @override
  Future delete(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.remove(key);
  }

  @override
  Future recovery(String key) async {
    var shared = await SharedPreferences.getInstance();
    final result = shared.get(key);
    if (result != null) {
      return result;
    } else {
      return null;
    }
  }

  @override
  Future put(String key, dynamic value) async {
    var shared = await SharedPreferences.getInstance();

    if (value is String) {
      return shared.setString(key, value);
    }
  }

  @override
  Future<bool> clear() async {
    var shared = await SharedPreferences.getInstance();
    return await shared.clear();
  }
}
