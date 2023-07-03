import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityIconButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const ConnectivityIconButton({super.key, this.onPressed});

  @override
  State<ConnectivityIconButton> createState() => _ConnectivityIconButtonState();
}

class _ConnectivityIconButtonState extends State<ConnectivityIconButton> {
  ConnectivityResult? currentConnectivityResult;

  @override
  void initState() {
    super.initState();
    // TODO: Implement Dispose
    Connectivity().onConnectivityChanged.listen((event) {
      //if (event.isNull) return;
      log(event.toString());
      if (mounted) {
        setState(() => currentConnectivityResult = event);
      } else {
        currentConnectivityResult = event;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (currentConnectivityResult) {
      case ConnectivityResult.bluetooth:
        return IconButton.filledTonal(
          onPressed: widget.onPressed,
          icon: const Icon(Icons.bluetooth_rounded),
        );
      case ConnectivityResult.wifi:
        return IconButton.filledTonal(
          onPressed: widget.onPressed,
          icon: const Icon(Icons.wifi_rounded),
        );
      case ConnectivityResult.ethernet:
        return IconButton.filledTonal(
          onPressed: widget.onPressed,
          icon: const Icon(Icons.settings_ethernet_rounded),
        );

      case ConnectivityResult.mobile:
        return IconButton.filledTonal(
          onPressed: widget.onPressed,
          icon: const Icon(Icons.signal_cellular_alt_rounded),
        );

      case ConnectivityResult.vpn:
        return IconButton.filledTonal(
          onPressed: widget.onPressed,
          icon: const Icon(Icons.vpn_key_rounded),
        );

      case ConnectivityResult.other:
        return IconButton.filledTonal(
          onPressed: widget.onPressed,
          icon: const Icon(Icons.hub_rounded),
        );

      case ConnectivityResult.none:
        return IconButton.filledTonal(
          onPressed: widget.onPressed,
          icon: const Icon(Icons.cloud_off_rounded),
        );

      default:
        return const SizedBox();
    }
  }
}
