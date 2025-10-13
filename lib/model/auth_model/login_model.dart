import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int statusCode;
  LoginData data;
  String message;
  bool success;

  LoginModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    statusCode: json["statusCode"] ?? 0,
    data: LoginData.fromJson(json["data"] ?? {}),
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

class LoginData {
  String phoneNumber;

  LoginData({required this.phoneNumber});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      LoginData(phoneNumber: json["phoneNumber"] ?? '');

  Map<String, dynamic> toJson() => {"phoneNumber": phoneNumber};
}
