import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int statusCode;
  ProfileData data;
  String message;
  bool success;

  ProfileModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    statusCode: json["statusCode"] ?? 0,
    data: ProfileData.fromJson(json["data"] ?? {}),
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

class ProfileData {
  UserProfile user;

  ProfileData({required this.user});

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      ProfileData(user: UserProfile.fromJson(json["user"] ?? {}));

  Map<String, dynamic> toJson() => {"user": user.toJson()};
}

class UserProfile {
  String id;
  String name;
  String phoneNumber;
  String bloodGroup;
  String email;
  String pinCode;
  DateTime createdAt;
  DateTime updatedAt;
  bool beADonor;
  String avatar;

  UserProfile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.email,
    required this.pinCode,
    required this.createdAt,
    required this.updatedAt,
    required this.beADonor,
    required this.avatar,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    phoneNumber: json["phoneNumber"] ?? '',
    bloodGroup: json["bloodGroup"] ?? '',
    email: json["email"] ?? '',
    pinCode: json["pinCode"] ?? '',
    createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updatedAt"] ?? '') ?? DateTime.now(),
    beADonor: json["beADonor"] ?? false,
    avatar: json["avatar"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phoneNumber": phoneNumber,
    "bloodGroup": bloodGroup,
    "email": email,
    "pinCode": pinCode,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "beADonor": beADonor,
    "avatar": avatar,
  };
}
