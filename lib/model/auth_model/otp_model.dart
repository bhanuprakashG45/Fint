import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  int statusCode;
  OtpData data;
  String message;
  bool success;

  OtpModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    statusCode: json["statusCode"] ?? 0,
    data: OtpData.fromJson(json["data"] ?? {}),
    message: json["message"] ?? '',
    success: json["success"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data.toJson(),
    "message": message,
    "success": success,
  };
}

class OtpData {
  String firebaseToken;
  String accessToken;
  String refreshToken;

  OtpData({
    required this.firebaseToken,
    required this.accessToken,
    required this.refreshToken,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
    firebaseToken: json["firebaseToken"] ?? '',
    accessToken: json["accessToken"] ?? '',
    refreshToken: json["refreshToken"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "firebaseToken": firebaseToken,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
