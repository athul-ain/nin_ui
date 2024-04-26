import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityIconButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const ConnectivityIconButton({super.key, this.onPressed});

  @override
  State<ConnectivityIconButton> createState() => _ConnectivityIconButtonState();
}

class _ConnectivityIconButtonState extends State<ConnectivityIconButton> {
  late List<ConnectivityResult> currentConnectivityResult;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    currentConnectivityResult = [];
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((event) {
      if (mounted) {
        setState(() => currentConnectivityResult = event);
      } else {
        currentConnectivityResult = event;
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: widget.onPressed,
      icon: _getConnectivityIcon(),
    );
  }

  Icon _getConnectivityIcon() {
    if (currentConnectivityResult.isEmpty) {
      return const Icon(Icons.cloud_off_rounded);
    } else if (currentConnectivityResult.length > 1) {
      return const Icon(Icons.hub_rounded);
    } else {
      switch (currentConnectivityResult.first) {
        case ConnectivityResult.bluetooth:
          return const Icon(Icons.bluetooth_rounded);
        case ConnectivityResult.wifi:
          return const Icon(Icons.wifi_rounded);
        case ConnectivityResult.ethernet:
          return const Icon(Icons.lan_rounded);
        case ConnectivityResult.mobile:
          return const Icon(Icons.signal_cellular_alt_rounded);
        case ConnectivityResult.vpn:
          return const Icon(Icons.vpn_key_rounded);
        case ConnectivityResult.other:
          return const Icon(Icons.public_rounded);
        case ConnectivityResult.none:
        default:
          return const Icon(Icons.cloud_off_rounded);
      }
    }
  }
}
