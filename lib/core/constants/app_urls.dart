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
  static const String notificationsUrl = '${baseUrl}notefication/fint-user';
  static const String transactionHistoryUrl = "${baseUrl}history/userTransation";

  //Bank Accounts
  static const String addBankAccountUrl =
      "${baseUrl}auth/fint/add-bank-account";
  static const String getAllBankAccountsUrl =
      "${baseUrl}auth/fint/get-bank-accounts";
  static const String updateBankAccountUrl =
      "${baseUrl}auth/fint/update-bank-account";
  static const String deleteBankAccountUrl =
      "${baseUrl}auth/fint/delete-bank-account";

  //Payment
  static const String paytoNumberUrl = '${baseUrl}payment/send/phone';
  static const String paytoBankAccountUrl = '${baseUrl}payment/send/bank';
  static const String verifyPaymentUrl = '${baseUrl}payment/verify';
  static const String qrscanpaymentUrl = "${baseUrl}payment/initiate";
  static const String claimEChangeUrl = "${baseUrl}payment/qr/verify";
  static const String expenseTrackerUrl = "${baseUrl}expense";

  //Adv
  static const String getAdvUrl = "${baseUrl}adv/display";
}
