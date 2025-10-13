import 'package:fint/core/constants/exports.dart';

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
  final ImagePicker _picker = ImagePicker();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  void _onQRViewCreated(QRViewController qrController) {
    controller = qrController;
    controller?.resumeCamera();

    qrController.scannedDataStream.listen((scanData) async {
      if (isCameraPaused) return;

      final code = scanData.code;
      if (code != null && code.startsWith("upi://")) {
        HapticFeedback.mediumImpact();
        setState(() {
          isCameraPaused = true;
        });
        controller?.pauseCamera();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CheckoutPage()),
        );
      } else {
        HapticFeedback.heavyImpact();
        setState(() {
          isCameraPaused = true;
        });
        controller?.pauseCamera();
        _showInvalidQrBottomSheet();
      }
    });
  }

  void _toggleTorch() async {
    try {
      await controller?.toggleFlash();
      bool? current = await controller?.getFlashStatus();
      setState(() {
        isTorchOn = current ?? false;
      });
    } catch (e) {
      debugPrint('Error toggling torch: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (picked != null) {
        // NOTE: You can add logic here to scan QR from the image if needed
        _showInvalidQrBottomSheet(
          message: "Image selected but scanning from image is not implemented.",
        );
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      _showErrorDialog("Failed to pick image. Please try again.");
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
      builder: (_) {
        return SafeArea(
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
                      "This QR code is not a valid UPI code. Please scan a valid UPI QR.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorscheme.tertiary,fontWeight: FontWeight.bold),
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
                    setState(() => isCameraPaused = false);
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
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
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
            QRView(
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
            Positioned(
              bottom: 40.h,
              left: 40.w,
              right: 40.w,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorscheme.tertiary,
                  foregroundColor: colorscheme.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20).r,
                  ),
                ),
                onPressed: _pickImageFromGallery,
                icon: Icon(Icons.image, color: colorscheme.onPrimary),
                label: Text(
                  "Upload from Gallery",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
