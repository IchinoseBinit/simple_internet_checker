import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_internet_checker/src/constant/app_constant.dart';
import 'package:simple_internet_checker/src/screen/connectivity_screen.dart';

/// Function to retrieve the provider instance
ConnectivityProvider useProvider(BuildContext context) {
  return Provider.of<ConnectivityProvider>(context, listen: false);
}

/*
 * Provider that handles the internet connectivity of a device
 * The Provider is initialized in the connectivity screen
 */
class ConnectivityProvider extends ChangeNotifier {
  /// Instance of the connectivity plus class
  final Connectivity _connectivity = Connectivity();

  /// Flag to maintain the internet connectivity status
  bool isOnline = true;

  /*
  * Method to check whether the device is connected to internet or not
  * Pass the url in static variable url from AppConstant if you want to ping a certain server typically your backend
  */
  checkIsOnline() async {
    try {
      final response = await InternetAddress.lookup(
          AppConstant.url.isNotEmpty
              ? AppConstant.url
              : 'www.google.com');
      if (response.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException {
      // Handle the socket exception and set the internet status to false
      isOnline = false;
    }
  }

  // Constructor to initialize the provider and call the checkIsOnline method
  ConnectivityProvider() {
    checkIsOnline();
  }

  // Method to check the internet connection when the internet connectivity is change for the device
  monitorConnection(
      {VoidCallback? internetUnAvailableCallback,
      VoidCallback? internetAvailableCallback}) async {
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

  /// Call a method using the notify method by passing a callback
  notify(VoidCallback callback) {
    callback();
  }
}
