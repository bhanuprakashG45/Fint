import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  final int statusCode;
  final bool success;
  final String message;
  final int count;
  final List<NotificationData> data;

  NotificationsModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.count,
    required this.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return NotificationsModel(
        statusCode: 0,
        success: false,
        message: '',
        count: 0,
        data: const [],
      );
    }

    return NotificationsModel(
      statusCode: json['statusCode'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      count: json['count'] ?? 0,
      data:
          (json['data'] as List?)
              ?.map((e) => NotificationData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'success': success,
    'message': message,
    'count': count,
    'data': data.map((x) => x.toJson()).toList(),
  };
}

class NotificationData {
  final String id;
  final String title;
  final String body;
  final String link;
  final String img;
  final String model;
  final String? notificationType;
  final String receiverId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.link,
    required this.img,
    required this.model,
    this.notificationType,
    required this.receiverId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory NotificationData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return NotificationData(
        id: '',
        title: '',
        body: '',
        link: '',
        img: '',
        model: '',
        notificationType: null,
        receiverId: '',
        createdAt: DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
        v: 0,
      );
    }

    return NotificationData(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      link: json['link'] ?? '',
      img: json['img'] ?? '',
      model: json['model'] ?? '',
      notificationType: json['notificationType'],
      receiverId: json['receiverId'] ?? '',
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'body': body,
    'link': link,
    'img': img,
    'model': model,
    'notificationType': notificationType,
    'receiverId': receiverId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    '__v': v,
  };

  static DateTime _parseDate(dynamic value) {
    if (value == null) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }
}
