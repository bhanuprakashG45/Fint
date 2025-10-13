import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  int statusCode;
  SignUpData data;
  String message;
  bool success;

  SignUpModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    statusCode: json["statusCode"] ?? 0,
    data: SignUpData.fromJson(json["data"] ?? {}),
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

class SignUpData {
  CreateUser createUser;

  SignUpData({required this.createUser});

  factory SignUpData.fromJson(Map<String, dynamic> json) =>
      SignUpData(createUser: CreateUser.fromJson(json["createUser"] ?? {}));

  Map<String, dynamic> toJson() => {"createUser": createUser.toJson()};
}

class CreateUser {
  String name;
  String phoneNumber;
  String bloodGroup;
  bool beADonor;
  String email;
  String pinCode;
  dynamic refreshToken;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CreateUser({
    required this.name,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.beADonor,
    required this.email,
    required this.pinCode,
    required this.refreshToken,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
    name: json["name"] ?? '',
    phoneNumber: json["phoneNumber"] ?? '',
    bloodGroup: json["bloodGroup"] ?? '',
    beADonor: json["beADonor"] ?? false,
    email: json["email"] ?? '',
    pinCode: json["pinCode"] ?? '',
    refreshToken: json["refreshToken"],
    id: json["_id"] ?? '',
    createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime(1970),
    updatedAt: DateTime.tryParse(json["updatedAt"] ?? '') ?? DateTime(1970),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phoneNumber": phoneNumber,
    "bloodGroup": bloodGroup,
    "beADonor": beADonor,
    "email": email,
    "pinCode": pinCode,
    "refreshToken": refreshToken,
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
