import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // TODO: Use SharedPreferences or secure storage
  
  UserModel? _cachedUser;
  String? _cachedToken;

  @override
  Future<void> cacheUser(UserModel user) async {
    _cachedUser = user;
    // TODO: Persist to SharedPreferences
  }

  @override
  Future<UserModel?> getCachedUser() async {
    return _cachedUser;
    // TODO: Load from SharedPreferences
  }

  @override
  Future<void> clearCache() async {
    _cachedUser = null;
    // TODO: Clear SharedPreferences
  }

  @override
  Future<void> saveToken(String token) async {
    _cachedToken = token;
    // TODO: Persist to secure storage
  }

  @override
  Future<String?> getToken() async {
    return _cachedToken;
    // TODO: Load from secure storage
  }

  @override
  Future<void> clearToken() async {
    _cachedToken = null;
    // TODO: Clear secure storage
  }
}
