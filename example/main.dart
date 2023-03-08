import 'package:flutter/material.dart';
import 'package:simple_internet_checker/simple_internet_checker.dart';
import 'package:simple_internet_checker/src/screen/connectivity_screen.dart';

import './settings_screen.dart';

void main() {
  runApp(const MyApp());
}

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConnectivityScreen(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        scaffoldMessengerKey: messengerKey,
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        // : const NoInternet();
      ),
    );
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("No Internet"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  internetUnAvailable() {
    messengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text("No Internet Connection"),
        backgroundColor: Colors.red,
        duration: Duration(
          hours: 10,
        ),
      ),
    );

    // Can change this to navigate to proper screen when the internet is not available using nav key as well
  }

  internetAvailable() {
    messengerKey.currentState?.clearSnackBars();
    // Can change this to navigate to proper screen when the internet is restored using nav key as well
  }

  @override
  initState() {
    super.initState();
    useProvider(context).monitorConnection(
        internetAvailableCallback: internetAvailable,
        internetUnAvailableCallback: internetUnAvailable);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'Internet checker',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        onPressed: () async {
          final hasInternet = useProvider(context).isOnline;

          if (hasInternet) {
            useProvider(context).notify(() {
              // Can call remove method to clear snackbars
              messengerKey.currentState?.clearSnackBars();
              // Can call navigator key to go to a certain screen
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SettingsScreen(),
              ),
            );
          }
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.adaptive.arrow_forward_outlined,
        ),
      ),
    );
  }
}
