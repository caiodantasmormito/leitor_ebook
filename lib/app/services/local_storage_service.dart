abstract class ILocalStorageService {
  Future recovery(String key);
  Future put(String key, dynamic value);
  Future delete(String key);
  Future<bool> clear();
}