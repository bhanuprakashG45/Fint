import 'package:fint/core/constants/exports.dart';
import 'package:fint/view/phone_pe_sdk/checkout_page.dart';

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
          MaterialPageRoute(
            builder: (context) => CheckoutPage(),
          ),
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 60, color: Colors.red.shade400),
              const SizedBox(height: 16),
              Text(
                "Invalid QR Code",
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message ??
                    "This QR code is not a valid UPI code. Please scan a valid UPI QR.",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  setState(() => isCameraPaused = false);
                  controller?.resumeCamera();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text("Scan Again"),
              ),
              const SizedBox(height: 10),
            ],
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
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.deepPurple,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 8,
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
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  "Scan Any QR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isTorchOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                  ),
                  onPressed: _toggleTorch,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 40,
            right: 40,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.image),
              label: const Text("Upload from Gallery"),
            ),
          ),
        ],
      ),
    );
  }
}
