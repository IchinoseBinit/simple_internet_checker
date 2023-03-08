# Internet Checker

Use this package to check internet with connectivity changes as well as pinging to google.
The package allows the functionality to check the internet connection of a app.

Use this package at the root widget to get full functionality. Example:

```dart
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
        home: const MyHomePage(title: 'Your App'),
      ),
    );
  }
}
  
  ```

  ## Utility Functions

useProvider(BuildContext context)
- Use the function to access the connectivity provider inside the internet checker package.

```dart
  @override
  initState() {
    super.initState();
    useProvider(context)
        .monitorConnection(internetAvailableCallback: internetAvailable, internetUnAvailableCallback: internetUnAvailable);
  }

```

### Monitor Connection
The function monitorConnection allows the user to monitor the internet connectivity. After the device connectivity is changed, the function calls another method that pings google for checking whether the internet connectivity is restored or not.
- You can also pass a callback function in internetUnAvailable parameter as shown above to perform a certain task when the internet connectivity is changed and the internet is not available.
- You can pass another callback function in internetAvailable parameter to perform when internet is available

### Notify
The function notify can be used to notify changes when internet connectivity of a device is changed.

```dart
    useProvider(context).notify(() {
        messengerKey.currentState?.clearSnackBars();
    });
```

### Is Online flag
The flag is maintained so that the user can know the status of internet in the device. You can access the flag as shown below.

```dart
    final hasInternet = userProvider(context).isOnline;
    // Do something when the device has internet
    if (hasInternet) {
        print("The internet is restored");
    }
```


