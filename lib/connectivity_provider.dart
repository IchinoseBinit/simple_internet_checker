import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_checker/main.dart';

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
    if (!isOnline) {
      notify();
    } else {
      remove();
      // ScaffoldMessenger.of(context).show
    }
  }

  ConnectivityProvider() {
    checkIsOnline();
  }

  monitorConnection() async {
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi ||
          event == ConnectivityResult.bluetooth) {
        await checkIsOnline();
      } else {
        isOnline = false;
        notify();
      }
    });
  }

  notify() {
    messengerKey.currentState!.showSnackBar(
      const SnackBar(
        content: Text(
          "No internet",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        duration: Duration(
          hours: 10,
        ),
      ),
    );
  }

  remove() {
    messengerKey.currentState!.clearSnackBars();
  }
}
