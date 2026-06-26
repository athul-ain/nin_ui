import 'brand_stub.dart' if (dart.library.ffi) 'brand_native.dart';

/// Initialise the brand detector before using it
///
/// ```dart
/// await BrandDetector.initialise();
/// ```
class BrandDetector {
  static BrandDetector? _instance;

  final String? brand;
  final bool isOneUiSystem;

  static bool get isOneUi => _instance?.isOneUiSystem ?? false;

  const BrandDetector._(this.brand, this.isOneUiSystem);

  factory BrandDetector() {
    if (_instance != null) {
      return _instance!;
    }
    final (brand, isOneUiSystem) = detectBrand();
    return BrandDetector._(brand, isOneUiSystem);
  }

  static Future<void> initialise(
      {bool disableOneUiCustomisation = false}) async {
    if (_instance != null) return;

    final (brand, isOneUiSystem) =
        detectBrand(disableOneUiCustomisation: disableOneUiCustomisation);
    _instance = BrandDetector._(brand, isOneUiSystem);
  }
}
