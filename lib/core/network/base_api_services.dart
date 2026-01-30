abstract class BaseApiServices {
  Future<dynamic> getApiResponse(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  Future<dynamic> postApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  });
}
