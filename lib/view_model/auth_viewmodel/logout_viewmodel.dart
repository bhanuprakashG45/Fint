import 'package:fint/core/constants/exports.dart';
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

  bool _isLogoutLoading = false;
  bool get isLogoutLoading => _isLogoutLoading;

  set isLogoutLoading(bool value) {
    _isLogoutLoading = value;
    notifyListeners();
  }

  Future<void> userLogout(context) async {
    isLogoutLoading = true;
    try {
      final url = AppUrls.logoutUrl;
      final accessToken = await prefs.getAccessToken();
      final refreshToken = await prefs.getRefreshToken();
      final firebaseToken = await prefs.fetchDeviceToken();

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

        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.loginscreen,
          (_) => false,
        );
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
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.loginscreen,
          (_) => false,
        );
      } else {
        // ToastHelper.show(
        //   context,
        //   "Failed to logout",
        //   type: ToastificationType.error,
        //   duration: Duration(seconds: 3),
        // );
        // print("Failed to Logout:${response.statusCode}");
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.loginscreen,
          (_) => false,
        );
      }
    } catch (e) {
      if (e is AppException) {
        ToastHelper.show(
          context,
          e.userFriendlyMessage,
          type: ToastificationType.error,
          duration: const Duration(seconds: 3),
        );
      }
    } finally {
      isLogoutLoading = false;
    }
  }
}
