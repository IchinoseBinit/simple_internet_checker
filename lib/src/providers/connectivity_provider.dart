import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

ConnectivityProvider useProvider(BuildContext context) {
  return Provider.of<ConnectivityProvider>(context, listen: false);
}

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  bool isOnline = true;

  checkIsOnline() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException {
      isOnline = false;
    }
  }

  ConnectivityProvider() {
    checkIsOnline();
  }

  monitorConnection({VoidCallback? internetUnAvailableCallback, VoidCallback? internetAvailableCallback}) async {
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi ||
          event == ConnectivityResult.bluetooth) {
        await checkIsOnline();
      } else {
        isOnline = false;
        if (internetUnAvailableCallback != null) {
          notify(internetUnAvailableCallback);
        }
      }
      if (isOnline) {
        if (internetAvailableCallback != null) {
          notify(internetAvailableCallback);
        }
      }
    });
  }

  notify(VoidCallback callback) {
    callback();
  }
}
