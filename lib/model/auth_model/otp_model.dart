import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  int statusCode;
  OtpData? data;
  String message;
  bool success;

  OtpModel({
    required this.statusCode,
    this.data,
    required this.message,
    required this.success,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    statusCode: json["statusCode"] ?? 0,
    data: json["data"] != null ? OtpData.fromJson(json["data"]) : null,
    message: json["message"] ?? '',
    success: json["success"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data?.toJson(),
    "message": message,
    "success": success,
  };
}

class OtpData {
  UserDetails? user;
  String firebaseToken;
  String accessToken;
  String refreshToken;

  OtpData({
    this.user,
    required this.firebaseToken,
    required this.accessToken,
    required this.refreshToken,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
    user: json["user"] != null ? UserDetails.fromJson(json["user"]) : null,
    firebaseToken: json["firebaseToken"] ?? '',
    accessToken: json["accessToken"] ?? '',
    refreshToken: json["refreshToken"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "firebaseToken": firebaseToken,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}

class UserDetails {
  String id;
  String name;
  String email;
  String phoneNumber;

  UserDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"] ?? '',
    name: json["name"] ?? '',
    email: json["email"] ?? '',
    phoneNumber: json["phoneNumber"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}
