import 'package:fint/core/constants/exports.dart';
import 'package:fint/core/repository/coupon_rep/coupon_repository.dart';

class CouponsViewmodel with ChangeNotifier {
  final CouponRepository _couponRepository = CouponRepository();

  List<Coupon> _coupons = [];
  List<Coupon> get coupons => _coupons;

  bool _isCouponsLoading = false;
  bool get isCouponsLoading => _isCouponsLoading;

  set isCouponsLoading(bool value) {
    _isCouponsLoading = value;
    notifyListeners();
  }

  ReedemCoupon _reedemCoupon = ReedemCoupon(
    id: '',
    couponTitle: '',
    logo: '',
    offerTitle: '',
    offerDescription: '',
    termsAndConditions: '',
    expiryDate: DateTime.now(),
    offerDetails: '',
    aboutCompany: '',
    viewCount: 0,
    status: '',
    createdByVenture: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: 0,
  );

  ReedemCoupon get reedemCoupon => _reedemCoupon;

  bool _isReedemCouponLoading = false;
  bool get isReedemCouponLoading => _isReedemCouponLoading;

  set isReedemCouponLoading(bool value) {
    _isReedemCouponLoading = value;
    notifyListeners();
  }

  AllCouponsModel _allCoupons = AllCouponsModel(
    statusCode: 0,
    data: CouponData(
      couponCount: 0,
      statusSummary: StatusSummary(
        claimed: 0,
        deleted: 0,
        active: 0,
        expired: 0,
      ),
      coupons: [],
    ),
    message: '',
    success: false,
  );
  AllCouponsModel get allCoupons => _allCoupons;

  Future<void> fetchCoupons(BuildContext context) async {
    _isCouponsLoading = true;
    try {
      final url = AppUrls.getAllCouponsUrl;

      final response = await _couponRepository.fetchAllCoupons(context, url);

      if (response.success == true) {
        _allCoupons = response;
        final couponsData = response.data;
        _coupons = couponsData.coupons;
        notifyListeners();
        print("Coupons fetched successfully: ${response.data.coupons.length}");
      } else {
        print("Failed to fetch coupons: ${response.message}");
      }
    } catch (e) {
      print("Error fetching coupons: $e");
    } finally {
      isCouponsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCouponById(BuildContext context, String couponId) async {
    isReedemCouponLoading = true;
    try {
      final url = AppUrls.redeemCouponUrl + couponId;
      print(url);
      final response = await _couponRepository.fetchCouponById(context, url);

      if (response.success == true) {
        _reedemCoupon = response.data;
        notifyListeners();
        print("Coupon fetched successfully: ${response.data}");
      } else {}
    } catch (e) {
      print("Error fetching coupon by ID: $e");
      return null;
    } finally {
      isReedemCouponLoading = false;
      notifyListeners();
    }
  }
}
