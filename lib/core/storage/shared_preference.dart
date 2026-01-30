import 'package:fint/core/constants/exports.dart';
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

  Future<void> clearFirebaseToken() async {
    await _initSharedPreferences();
    if (_prefs!.containsKey('firebaseToken')) {
      await _prefs!.remove('firebaseToken');
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

  Future<void> storeDeviceToken(String devicetoken) async {
    debugPrint("Device Token : $devicetoken");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (devicetoken.isNotEmpty) {
      await prefs.setString('device_token', devicetoken);
    } else {}
  }

  Future<String?> fetchDeviceToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    print("Fetching Device Token ");
    String? devicetoken = preferences.getString("device_token");
    if (devicetoken != null && devicetoken.isNotEmpty) {
      print("Device Token : $devicetoken");
      return devicetoken;
    } else {
      return null;
    }
  }

  Future<void> storeUserId(String userId) async {
    await _initSharedPreferences();
    await _prefs!.setString('userId', userId);
  }

  Future<String?> getUserId() async {
    await _initSharedPreferences();

    return _prefs!.getString('userId');
  }

  Future<void> clearUserId() async {
    await _initSharedPreferences();
    if (_prefs!.containsKey('userId')) {
      await _prefs!.remove('userId');
    }
  }

  Future<void> storeUserName(String userName) async {
    await _initSharedPreferences();
    await _prefs!.setString('userName', userName);
  }

  Future<String?> getUserName() async {
    await _initSharedPreferences();

    return _prefs!.getString('userName');
  }

  Future<void> clearUserName() async {
    await _initSharedPreferences();
    if (_prefs!.containsKey('userName')) {
      await _prefs!.remove('userName');
    }
  }

  Future<void> storeUserMobile(String userMobile) async {
    await _initSharedPreferences();
    await _prefs!.setString('userMobile', userMobile);
  }

  Future<String?> getUserMobile() async {
    await _initSharedPreferences();

    return _prefs!.getString('userMobile');
  }

  Future<void> clearUserMobile() async {
    await _initSharedPreferences();
    if (_prefs!.containsKey('userMobile')) {
      await _prefs!.remove('userMobile');
    }
  }
}
