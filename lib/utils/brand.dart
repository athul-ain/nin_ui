import 'dart:async';
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
    final androidInfo = await deviceInfo.androidInfo;
    _brand = androidInfo.brand;
    _controller.add(_brand == 'samsung');
  }

  void dispose() {
    _controller.close();
  }
}
