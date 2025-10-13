import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  final bool success;
  final ReedemCoupon data;

  CouponModel({required this.success, required this.data});

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
    success: json["success"] ?? false,
    data: ReedemCoupon.fromJson(json["data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data.toJson()};
}

class ReedemCoupon {
  final String id;
  final String couponTitle;
  final dynamic logo;
  final String offerTitle;
  final String offerDescription;
  final String termsAndConditions;
  final DateTime expiryDate;
  final String offerDetails;
  final String aboutCompany;
  final int viewCount;
  final String status;
  final String createdByVenture;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ReedemCoupon({
    required this.id,
    required this.couponTitle,
    required this.logo,
    required this.offerTitle,
    required this.offerDescription,
    required this.termsAndConditions,
    required this.expiryDate,
    required this.offerDetails,
    required this.aboutCompany,
    required this.viewCount,
    required this.status,
    required this.createdByVenture,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ReedemCoupon.fromJson(Map<String, dynamic> json) => ReedemCoupon(
    id: json["_id"] ?? '',
    couponTitle: json["couponTitle"] ?? '',
    logo: json["logo"],
    offerTitle: json["offerTitle"] ?? '',
    offerDescription: json["offerDescription"] ?? '',
    termsAndConditions: json["termsAndConditions"] ?? '',
    expiryDate:
        DateTime.tryParse(json["expiryDate"] ?? '') ??
        DateTime.now().add(const Duration(days: 30)),
    offerDetails: json["offerDetails"] ?? '',
    aboutCompany: json["aboutCompany"] ?? '',
    viewCount: json["viewCount"] ?? 0,
    status: json["status"] ?? '',
    createdByVenture: json["createdByVenture"] ?? '',
    createdAt:
        DateTime.tryParse(json["createdAt"] ?? '') ??
        DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.tryParse(json["updatedAt"] ?? '') ?? DateTime.now(),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "couponTitle": couponTitle,
    "logo": logo,
    "offerTitle": offerTitle,
    "offerDescription": offerDescription,
    "termsAndConditions": termsAndConditions,
    "expiryDate": expiryDate.toIso8601String(),
    "offerDetails": offerDetails,
    "aboutCompany": aboutCompany,
    "viewCount": viewCount,
    "status": status,
    "createdByVenture": createdByVenture,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
