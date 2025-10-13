class AppUrls {
  static const String baseUrl = 'https://api.projectf0724.com/fint/';
  //Authentication
  static const String signUpUrl = '${baseUrl}auth/fint/sign-up';
  static const String loginUrl = '${baseUrl}auth/fint/login';
  static const String otpUrl = '${baseUrl}auth/fint/check-otp';
  static const String logoutUrl = '${baseUrl}auth/fint/logout';
  static const String deviceTokenUrl = '$baseUrl/notefication/user/deviceToken';

  //Refresh TOken
  static const String refreshTokenUrl =
      '${baseUrl}auth/fint/renew-access-token';

  //Profile
  static const String profileUrl = '${baseUrl}auth/fint/profile';
  static const String updateProfileUrl = '${baseUrl}auth/fint/update-profile';
  //Insurance
  static const String applyPetInsuranceUrl = '${baseUrl}petInsurance/apply';

  //Coupons
  static const String getAllCouponsUrl =
      '${baseUrl}coupons/user-display-all-coupons';
  static const String redeemCouponUrl =
      '${baseUrl}coupons/display-coupons-details/';
  //Home
  static const String notificationsUrl = '$baseUrl/notefication/fint-user';
}
