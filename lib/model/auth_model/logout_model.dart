import 'dart:convert';

LogoutModel logoutModelFromJson(String str) =>
    LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
  final int statusCode;
  final dynamic data;
  final String message;
  final bool success;

  LogoutModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    statusCode: json["statusCode"] is int ? json["statusCode"] : 0,
    data: json.containsKey("data") ? json["data"] : null,
    message: json["message"]?.toString() ?? "Unknown error",
    success: json["success"] == true,
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data,
    "message": message,
    "success": success,
  };
}
