import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/exceptions/app_exceptions.dart';
import 'package:fint/core/storage/shared_preference.dart';
import 'package:fint/model/auth_model/logout_model.dart';
import 'package:http/http.dart' as http;

class LogoutViewmodel with ChangeNotifier {
  SharedPref prefs = SharedPref();

  LogoutModel _logoutdata = LogoutModel(
    statusCode: 0,
    data: '',
    message: '',
    success: false,
  );

  LogoutModel get logoutdata => _logoutdata;

  Future<bool> userLogout(context) async {
    try {
      final url = AppUrls.logoutUrl;
      final accessToken = await prefs.getAccessToken();
      final refreshToken = await prefs.getRefreshToken();
      final firebaseToken = await prefs.getFirebaseToken();

      print("AccessTokenq :$accessToken");
      print("RefreshTokenq :$refreshToken");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'x-refresh-token': refreshToken.toString(),
          'x-firebase-token': firebaseToken.toString(),
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        await prefs.clearAccessToken();
        await prefs.clearRefreshToken();
        print("AccessTokenq :$accessToken");
        print("RefreshTokenq :$refreshToken");
        final responseData = logoutModelFromJson(response.body);
        _logoutdata = responseData;
        notifyListeners();
        ToastHelper.show(
          context,
          responseData.message,
          type: ToastificationType.success,
          duration: Duration(seconds: 3),
        );
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        await prefs.clearAccessToken();
        await prefs.clearRefreshToken();
        final responseData = logoutModelFromJson(response.body);
        _logoutdata = responseData;
        notifyListeners();
        ToastHelper.show(
          context,
          responseData.message,
          type: ToastificationType.success,
          duration: Duration(seconds: 3),
        );
        return true;
      } else {
        ToastHelper.show(
          context,
          "Failed to logout",
          type: ToastificationType.error,
          duration: Duration(seconds: 3),
        );
        print("Failed to Logout:${response.statusCode}");
        return false;
      }
    } catch (e) {
      if (e is AppException) {
        throw e.userFriendlyMessage;
      } else {
        throw Exception(e);
      }
    }
  }
}
