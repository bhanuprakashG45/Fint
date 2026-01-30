import 'dart:convert';

AllCouponsModel allCouponsModelFromJson(String str) =>
    AllCouponsModel.fromJson(json.decode(str));

String allCouponsModelToJson(AllCouponsModel data) =>
    json.encode(data.toJson());

class AllCouponsModel {
  int statusCode;
  CouponData data;
  String message;
  bool success;

  AllCouponsModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory AllCouponsModel.fromJson(Map<String, dynamic> json) =>
      AllCouponsModel(
        statusCode: json["statusCode"] ?? 0,
        data: CouponData.fromJson(json["data"] ?? {}),
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

class CouponData {
  int couponCount;
  StatusSummary statusSummary;
  List<Coupon> coupons;

  CouponData({
    required this.couponCount,
    required this.statusSummary,
    required this.coupons,
  });

  factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
    couponCount: json["couponCount"] ?? 0,
    statusSummary: StatusSummary.fromJson(json["statusSummary"] ?? {}),
    coupons: List<Coupon>.from(
      (json["coupons"] ?? []).map((x) => Coupon.fromJson(x ?? {})),
    ),
  );

  Map<String, dynamic> toJson() => {
    "couponCount": couponCount,
    "statusSummary": statusSummary.toJson(),
    "coupons": List<dynamic>.from(coupons.map((x) => x.toJson())),
  };
}

class Coupon {
  String id;
  String title;
  String? logo;
  String offerTitle;
  String offerDescription;
  DateTime expiryDate;
  String status;
  int viewCount;
  DateTime createdAt;

  Coupon({
    required this.id,
    required this.title,
    required this.logo,
    required this.offerTitle,
    required this.offerDescription,
    required this.expiryDate,
    required this.status,
    required this.viewCount,
    required this.createdAt,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["id"] ?? '',
    title: json["title"] ?? '',
    logo: json["img"],
    offerTitle: json["offerTitle"] ?? '',
    offerDescription: json["offerDescription"] ?? '',
    expiryDate:
        DateTime.tryParse(json["expiryDate"] ?? '') ??
        DateTime.now().add(const Duration(days: 30)),
    status: json["status"] ?? '',
    viewCount: json["viewCount"] ?? 0,
    createdAt:
        DateTime.tryParse(json["createdAt"] ?? '') ??
        DateTime.now().subtract(const Duration(days: 1)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "logo": logo,
    "offerTitle": offerTitle,
    "offerDescription": offerDescription,
    "expiryDate": expiryDate.toIso8601String(),
    "status": status,
    "viewCount": viewCount,
    "createdAt": createdAt.toIso8601String(),
  };
}

class StatusSummary {
  int claimed;
  int deleted;
  int active;
  int expired;

  StatusSummary({
    required this.claimed,
    required this.deleted,
    required this.active,
    required this.expired,
  });

  factory StatusSummary.fromJson(Map<String, dynamic> json) => StatusSummary(
    claimed: json["claimed"] ?? 0,
    deleted: json["deleted"] ?? 0,
    active: json["active"] ?? 0,
    expired: json["expired"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "claimed": claimed,
    "deleted": deleted,
    "active": active,
    "expired": expired,
  };
}
