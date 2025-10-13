import 'dart:convert';

DeviceTokenModel deviceTokenModelFromJson(String str) =>
    DeviceTokenModel.fromJson(json.decode(str));

String deviceTokenModelToJson(DeviceTokenModel data) =>
    json.encode(data.toJson());

class DeviceTokenModel {
  final String? message;
  final FirebaseResponse? firebaseResponse;

  DeviceTokenModel({this.message, this.firebaseResponse});

  factory DeviceTokenModel.fromJson(Map<String, dynamic> json) =>
      DeviceTokenModel(
        message: json["message"] as String?,
        firebaseResponse: json["firebaseResponse"] != null
            ? FirebaseResponse.fromJson(json["firebaseResponse"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "firebaseResponse": firebaseResponse?.toJson(),
  };
}

class FirebaseResponse {
  final int? successCount;
  final int? failureCount;
  final List<dynamic>? errors;

  FirebaseResponse({this.successCount, this.failureCount, this.errors});

  factory FirebaseResponse.fromJson(Map<String, dynamic> json) =>
      FirebaseResponse(
        successCount: json["successCount"] as int?,
        failureCount: json["failureCount"] as int?,
        errors: json["errors"] != null
            ? List<dynamic>.from(json["errors"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "successCount": successCount,
    "failureCount": failureCount,
    "errors": errors != null ? List<dynamic>.from(errors!) : [],
  };
}
