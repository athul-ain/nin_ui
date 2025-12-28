import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

typedef _SystemPropertyGetNative = Int32 Function(
    Pointer<Utf8> name, Pointer<Utf8> value);
typedef _SystemPropertyGetDart = int Function(
    Pointer<Utf8> name, Pointer<Utf8> value);

class BrandDetector {
  late final String? brand;
  late final bool isOneUi;

  BrandDetector() {
    _detect();
  }

  void _detect() {
    if (kIsWeb) {
      brand = null;
      isOneUi = false;
      return;
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

    isOneUi = brand == 'samsung';
  }
}
