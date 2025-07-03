import 'package:fint/core/constants/exports.dart';

abstract class BaseApiServices {
  
  Future<dynamic> getApiResponse(
     BuildContext context,
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    
  });

  Future<dynamic> postApiResponse(
     BuildContext context,
    String url,
    dynamic data, {
    Map<String, String>? headers,
   
  });
}
