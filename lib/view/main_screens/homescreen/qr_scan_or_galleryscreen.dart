import 'package:fint/core/constants/exports.dart';
import 'package:fint/view/payment/claim_echange_screen.dart';

class QRScanOrGalleryScreen extends StatefulWidget {
  const QRScanOrGalleryScreen({super.key});

  @override
  State<QRScanOrGalleryScreen> createState() => _QRScanOrGalleryScreenState();
}

class _QRScanOrGalleryScreenState extends State<QRScanOrGalleryScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isTorchOn = false;
  bool isCameraPaused = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) controller?.pauseCamera();
    controller?.resumeCamera();
  }

  // void _onQRViewCreated(QRViewController qrController) {
  //   debugPrint("Executing:1");
  //   controller = qrController;
  //   controller?.resumeCamera();
  //   qrController.scannedDataStream.listen((scanData) async {
  //     debugPrint("Executing:2");
  //     if (isCameraPaused || _isProcessingScan) return;
  //     debugPrint("Executing:3");
  //     final code = scanData.code;
  //     if (code == null || code.trim().isEmpty) {
  //       debugPrint("Executing:4");
  //       _handleInvalidQr();
  //       return;
  //     }
  //     debugPrint("Executing:6");
  //     _isProcessingScan = true;
  //     HapticFeedback.mediumImpact();
  //     setState(() => isCameraPaused = true);
  //     controller?.pauseCamera();
  //     debugPrint('Scanned QR Code: $code');
  //     Map<String, dynamic>? decoded;
  //     debugPrint("Executing:7");
  //     try {
  //       debugPrint("Executing:8");
  //       decoded = jsonDecode(code);
  //     } catch (_) {
  //       debugPrint("Executing:9");
  //       _handleInvalidQr();
  //       _isProcessingScan = false;
  //       return;
  //     }
  //     if (decoded == null) {
  //       debugPrint("Executing:10");
  //       _handleInvalidQr();
  //       _isProcessingScan = false;
  //       return;
  //     }
  //     if (decoded.containsKey('orderId') &&
  //         decoded['orderId'] is String &&
  //         decoded['orderId'].isNotEmpty) {
  //       debugPrint("Executing:11");
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => ClaimExchangeScreen(orderId: decoded?['orderId']),
  //         ),
  //       );
  //     } else if (decoded.containsKey('userId') &&
  //         decoded['userId'] is String &&
  //         decoded['userId'].isNotEmpty) {
  //       debugPrint("Executing:12");
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => CheckoutPage(
  //             userId: decoded?['userId'],
  //             userName: decoded?['userName'],
  //           ),
  //         ),
  //       );
  //     } else {
  //       debugPrint("Executing:13");
  //       _handleInvalidQr();
  //     }
  //     _isProcessingScan = false;
  //     debugPrint("Executing:14");
  //   });
  // }

  void _onQRViewCreated(QRViewController qrController) {
    controller = qrController;
    controller?.resumeCamera();

    qrController.scannedDataStream.listen((scanData) async {
      if (isCameraPaused) return;

      final code = scanData.code;
      if (code == null || code.isEmpty) {
        _handleInvalidQr();
        return;
      }

      HapticFeedback.mediumImpact();
      setState(() => isCameraPaused = true);
      controller?.pauseCamera();

      debugPrint('📷 Scanned QR Code: $code');
      bool _isJson(String value) {
        return value.trim().startsWith('{') && value.trim().endsWith('}');
      }

      if (!_isJson(code)) {
        _handleInvalidQr();
        return;
      }

      try {
        final decoded = jsonDecode(code) as Map<String, dynamic>;

        if (decoded.containsKey('orderId') &&
            decoded['orderId'] is String &&
            decoded['orderId'].isNotEmpty) {
          debugPrint("Executing:11");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ClaimExchangeScreen(
                orderId: decoded['orderId'].toString(),
                amount: decoded['amount'].toString(),
              ),
            ),
          );
        } else if (decoded.containsKey('userId') &&
            decoded['userId'] is String &&
            decoded['userId'].isNotEmpty) {
          debugPrint("Executing:12");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => CheckoutPage(
                userId: decoded['userId'],
                userName: decoded['userName'],
              ),
            ),
          );
        } else {
          debugPrint("Executing:13");
          _handleInvalidQr();
        }
      } catch (e) {
        debugPrint(' QR Parse Error: $e');
        _handleInvalidQr();
      }
    });
  }

  void _handleInvalidQr() {
    debugPrint("Executing:5");
    HapticFeedback.heavyImpact();
    setState(() => isCameraPaused = true);
    controller?.pauseCamera();
    _showInvalidQrBottomSheet();
  }

  void _toggleTorch() async {
    try {
      await controller?.toggleFlash();
      final current = await controller?.getFlashStatus();
      setState(() => isTorchOn = current ?? false);
    } catch (e) {
      debugPrint('Error toggling torch: $e');
    }
  }

  void _showInvalidQrBottomSheet({String? message}) {
    final colorscheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.all(20).r,
          decoration: BoxDecoration(
            color: colorscheme.onPrimary,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ).r,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 60.sp,
                color: Colors.red.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                "Invalid QR Code",
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                message ??
                    "This QR code is not valid. Please scan a valid QR code.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorscheme.tertiary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorscheme.tertiary,
                  foregroundColor: colorscheme.onPrimary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                    vertical: 12.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20).r,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isCameraPaused = false;
                  });
                  controller?.resumeCamera();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.qr_code_scanner),
                label: Text(
                  "Scan Again",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: colorscheme.tertiary,
                  borderRadius: 10.r,
                  borderLength: 30.h,
                  borderWidth: 8.w,
                  cutOutSize: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: colorscheme.onPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Scan Any QR",
                    style: TextStyle(
                      color: colorscheme.onPrimary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isTorchOn ? Icons.flash_on : Icons.flash_off,
                      color: colorscheme.onPrimary,
                    ),
                    onPressed: _toggleTorch,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
