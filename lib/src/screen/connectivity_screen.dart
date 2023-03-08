import 'package:flutter/material.dart';

import '/src/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';

/*
 * Class to use at the top of the widget
 * Use this widget to wrap your material app
 * The widget MaterialApp or the GetMaterialApp should be the child widget 
 */
class ConnectivityScreen extends StatelessWidget {
  const ConnectivityScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// Pass the root level widget to this parameter
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConnectivityProvider(),
      builder: (_, __) => child,
    );
  }
}
