import 'dart:convert';

import 'package:fint/core/exceptions/app_exceptions.dart';
import 'package:fint/core/network/network_api_services.dart';
import 'package:fint/model/coupon_model/all_coupon_model.dart';
import 'package:fint/model/coupon_model/coupon_model.dart';
import 'package:flutter/material.dart';

class CouponRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<AllCouponsModel> fetchAllCoupons(
    BuildContext context,
    String url,
  ) async {
    try {
      final response = await _apiServices.getApiResponse(context, url);
      print("${response}");

      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }
      return AllCouponsModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Fetch  All Coupons failed: $e');
    }
  }

  Future<CouponModel> fetchCouponById(BuildContext context, String url) async {
    try {
      final response = await _apiServices.getApiResponse(context, url);

      print("${response}");

      Map<String, dynamic> jsonMap;

      if (response is Map<String, dynamic>) {
        jsonMap = response;
      } else if (response is String) {
        jsonMap = json.decode(response);
      } else {
        throw AppException('Unexpected response format', '');
      }
      return CouponModel.fromJson(jsonMap);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('', 'Fetch Coupon by ID failed: $e');
    }
  }
}
