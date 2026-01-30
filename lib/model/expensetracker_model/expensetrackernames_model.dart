import 'dart:convert';

ExpenseTrackerNamesModel expenseTrackerNamesModelFromJson(String str) =>
    ExpenseTrackerNamesModel.fromJson(json.decode(str));

String expenseTrackerNamesModelToJson(ExpenseTrackerNamesModel data) =>
    json.encode(data.toJson());

class ExpenseTrackerNamesModel {
  final int statusCode;
  final List<ExpenseTrackerData> data;
  final String message;
  final bool success;

  ExpenseTrackerNamesModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ExpenseTrackerNamesModel.fromJson(Map<String, dynamic> json) =>
      ExpenseTrackerNamesModel(
        statusCode: json["statusCode"] ?? 0,
        data:
            (json["data"] as List?)
                ?.map((x) => ExpenseTrackerData.fromJson(x))
                .toList() ??
            [],
        message: json["message"] ?? '',
        success: json["success"] ?? false,
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data.map((x) => x.toJson()).toList(),
    "message": message,
    "success": success,
  };
}

class ExpenseTrackerData {
  final String id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  ExpenseTrackerData({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
    required this.v,
  });

  factory ExpenseTrackerData.fromJson(Map<String, dynamic> json) =>
      ExpenseTrackerData(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"])
            : null,
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
