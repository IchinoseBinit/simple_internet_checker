import 'package:flutter/material.dart';

import '/src/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';

class ConnectivityScreen extends StatelessWidget {
  const ConnectivityScreen({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConnectivityProvider(),
      builder: (_, __) => child,
    );
  }
}
