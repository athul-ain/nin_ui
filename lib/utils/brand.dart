import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class BrandDetector {
  final _controller = StreamController<bool>.broadcast();
  Stream<bool> get isOneUi => _controller.stream;

  String? _brand;
  String? get brand => _brand;

  BrandDetector() {
    _controller.add(false); // Default value
    _checkOneUi();
  }

  Future<void> _checkOneUi() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      _brand = androidInfo.brand;
    } else if (Platform.isIOS || Platform.isMacOS) {
      _brand = "Apple";
    }
    _controller.add(_brand == 'samsung');
  }

  void dispose() {
    _controller.close();
  }
}
