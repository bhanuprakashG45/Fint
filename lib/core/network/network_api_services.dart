import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/network/globalkey.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  final SharedPref _sharedPref = SharedPref();

  Future<Map<String, String>> _getHeaders({
    Map<String, String>? extraHeaders,
  }) async {
    String token = await _sharedPref.getAccessToken();
    print(token);
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      if (extraHeaders != null) ...extraHeaders,
    };
  }

  /// ===== REFRESH TOKEN FUNCTION =====
  Future<bool> _refreshToken() async {
    print("Entered into REfresh Token");
    try {
      String token = await _sharedPref.getAccessToken();
      final refreshToken = await _sharedPref.getRefreshToken();
      final response = await http.get(
        Uri.parse(AppUrls.refreshTokenUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-refresh-token': refreshToken.toString(),
        },
      );

      print(refreshToken);
      print(response.body);
      print(response.statusCode);
      print(token);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['data']['accessToken'];
        print(newAccessToken);
        await _sharedPref.clearAccessToken();
        await _sharedPref.storeAccessToken(newAccessToken);

        print("Access token refreshed");
        return true;
      } else if (response.statusCode == 403 || response.statusCode == 401) {
        await _sharedPref.clear();
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          RoutesName.loginscreen,
          (route) => false,
        );
      }
    } catch (e) {
      print(" Refresh token failed: $e");
    }
    return false;
  }

  /// ======== GET =========
  @override
  Future<dynamic> getApiResponse(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    Uri uri = Uri.parse(url);
    if (queryParameters != null && queryParameters.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParameters);
    }

    try {
      Map<String, String> requestHeaders = await _getHeaders(
        extraHeaders: headers,
      );
      http.Response response = await http.get(uri, headers: requestHeaders);
      print(url);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 401) {
        if (await _refreshToken()) {
          requestHeaders = await _getHeaders(extraHeaders: headers);
          response = await http.get(uri, headers: requestHeaders);
        } else if (response.statusCode == 403) {
          await _sharedPref.clear();
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            RoutesName.loginscreen,
            (route) => false,
          );
        }
      }

      return _processResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
  }

  /// ======== POST =========
  @override
  Future<dynamic> postApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      Map<String, String> requestHeaders = await _getHeaders(
        extraHeaders: headers,
      );
      print(requestHeaders);
      http.Response response = await http.post(
        Uri.parse(url),
        headers: requestHeaders,
        body: jsonEncode(data),
      );

      print("${response.statusCode}");

      if (response.statusCode == 401) {
        if (await _refreshToken()) {
          requestHeaders = await _getHeaders(extraHeaders: headers);
          response = await http.post(
            Uri.parse(url),
            headers: requestHeaders,
            body: data != null ? jsonEncode(data) : null,
          );
        } else if (response.statusCode == 403) {
          await _sharedPref.clear();
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            RoutesName.loginscreen,
            (route) => false,
          );
        }
      }

      return _processResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
  }

  /// ======== PUT =========
  Future<dynamic> putApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      Map<String, String> requestHeaders = await _getHeaders(
        extraHeaders: headers,
      );
      http.Response response = await http.put(
        Uri.parse(url),
        headers: requestHeaders,
        body: jsonEncode(data),
      );

      if (response.statusCode == 401) {
        if (await _refreshToken()) {
          requestHeaders = await _getHeaders(extraHeaders: headers);
          response = await http.put(
            Uri.parse(url),
            headers: requestHeaders,
            body: jsonEncode(data),
          );
        } else if (response.statusCode == 403) {
          await _sharedPref.clear();
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            RoutesName.loginscreen,
            (route) => false,
          );
        }
      }

      return _processResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
  }

  /// ======== PATCH =========
  Future<dynamic> patchApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      Map<String, String> requestHeaders = await _getHeaders(
        extraHeaders: headers,
      );
      http.Response response = await http.patch(
        Uri.parse(url),
        headers: requestHeaders,
        body: jsonEncode(data),
      );

      if (response.statusCode == 401) {
        if (await _refreshToken()) {
          requestHeaders = await _getHeaders(extraHeaders: headers);
          response = await http.patch(
            Uri.parse(url),
            headers: requestHeaders,
            body: jsonEncode(data),
          );
        } else if (response.statusCode == 403) {
          await _sharedPref.clear();
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            RoutesName.loginscreen,
            (route) => false,
          );
        }
      }

      return _processResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
  }

  /// ======== DELETE =========
  Future<dynamic> deleteApiResponse(
    String url, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    try {
      Map<String, String> requestHeaders = await _getHeaders(
        extraHeaders: headers,
      );
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: requestHeaders,
        body: data != null ? jsonEncode(data) : null,
      );

      if (response.statusCode == 401) {
        if (await _refreshToken()) {
          requestHeaders = await _getHeaders(extraHeaders: headers);
          response = await http.delete(
            Uri.parse(url),
            headers: requestHeaders,
            body: data != null ? jsonEncode(data) : null,
          );
        } else if (response.statusCode == 403) {
          await _sharedPref.clear();
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            RoutesName.loginscreen,
            (route) => false,
          );
        }
      }

      return _processResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body.isNotEmpty ? jsonDecode(response.body) : null;
      case 400:
        final error = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : null;
        throw BadRequestException(error?['message'] ?? "Bad Request");
      case 401:
      case 403:
        final error = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : null;
        throw UnauthorizedException(error?['message'] ?? "Unauthorized");
      case 404:
      case 500:
        final error = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : null;
        return error;
      default:
        throw FetchDataException(
          'Error occurred with status code: ${response.statusCode}',
        );
    }
  }
}
