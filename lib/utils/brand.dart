import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

typedef _SystemPropertyGetNative = Int32 Function(
    Pointer<Utf8> name, Pointer<Utf8> value);
typedef _SystemPropertyGetDart = int Function(
    Pointer<Utf8> name, Pointer<Utf8> value);

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
    final (brand, isOneUiSystem) = _detect();
    return BrandDetector._(brand, isOneUiSystem);
  }

  static Future<void> initialise(
      {bool disableOneUiCustomisation = false}) async {
    if (_instance != null) return;

    final (brand, isOneUiSystem) =
        _detect(disableOneUiCustomisation: disableOneUiCustomisation);
    _instance = BrandDetector._(brand, isOneUiSystem);
  }

  static (String? brand, bool isOneUiSystem) _detect(
      {bool disableOneUiCustomisation = false}) {
    log('Detecting brand...');
    String? brand;
    bool isOneUiSystem = disableOneUiCustomisation;

    if (kIsWeb) {
      return (null, false);
    }

    if (Platform.isAndroid) {
      try {
        final dylib = DynamicLibrary.open('libc.so');
        final systemPropertyGet = dylib
            .lookup<NativeFunction<_SystemPropertyGetNative>>(
                '__system_property_get')
            .asFunction<_SystemPropertyGetDart>();

        final namePtr = 'ro.product.brand'.toNativeUtf8();
        final valuePtr = calloc<Int8>(92); // PROP_VALUE_MAX

        final length = systemPropertyGet(namePtr, valuePtr.cast());
        if (length > 0) {
          brand = valuePtr.cast<Utf8>().toDartString();
        } else {
          brand = null;
        }

        calloc.free(namePtr);
        calloc.free(valuePtr);
      } catch (e) {
        if (kDebugMode) {
          print('Error detecting brand: $e');
        }
        brand = null;
      }
    } else if (Platform.isIOS || Platform.isMacOS) {
      brand = 'Apple';
    } else {
      brand = null;
    }
    log('Brand: $brand');

    isOneUiSystem = brand == 'samsung';
    return (brand, isOneUiSystem);
  }
}
