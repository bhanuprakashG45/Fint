import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPreferences? _prefs;

  Future<void> _initSharedPreferences() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> storeAccessToken(String? accessToken) async {
    await _initSharedPreferences();
    if (accessToken != null) {
      await _prefs!.setString('accessToken', accessToken);
    }
  }

  Future<void> storeRefreshToken(String? refreshToken) async {
    await _initSharedPreferences();
    if (refreshToken != null) {
      await _prefs!.setString('refreshToken', refreshToken);
    }
  }

  Future<String> getAccessToken() async {
    await _initSharedPreferences();
    return _prefs!.getString('accessToken') ?? '';
  }

  Future<String> getRefreshToken() async {
    await _initSharedPreferences();
    return _prefs!.getString('refreshToken') ?? '';
  }

  Future<void> clearAccessToken() async {
    await _initSharedPreferences();
    if (_prefs!.containsKey('accessToken')) {
      await _prefs!.remove('accessToken');
    }
  }

  Future<void> clearRefreshToken() async {
    await _initSharedPreferences();
    if (_prefs!.containsKey('refreshToken')) {
      await _prefs!.remove('refreshToken');
    }
  }

  Future<void> clear() async {
    await _initSharedPreferences();
    await _prefs!.clear();
  }

  // Future<void> storeUserData(User userData) async {
  //   await _initSharedPreferences();
  //   String username = userData.name;
  //   String userid = userData.id;
  //   await _prefs!.setString('userId', userid);
  //   await _prefs!.setString('userName', username);
  // }

  Future<String?> getUserId() async {
    await _initSharedPreferences();

    return _prefs!.getString('userId');
  }
}
