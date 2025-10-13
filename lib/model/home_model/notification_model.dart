import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  int statusCode;
  bool success;
  String message;
  List<NotificationData> data;

  NotificationsModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] == null
            ? []
            : List<NotificationData>.from(
                json["data"].map((x) => NotificationData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NotificationData {
  String id;
  String title;
  String body;
  String userType;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["_id"] ?? "",
        title: json["title"] ?? "",
        body: json["body"] ?? "",
        userType: json["userType"] ?? "",
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"]) ?? DateTime(1970)
            : DateTime(1970),
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"]) ?? DateTime(1970)
            : DateTime(1970),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "body": body,
    "userType": userType,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
