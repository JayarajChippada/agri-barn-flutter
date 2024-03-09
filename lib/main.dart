import 'package:appathon/constants/utils.dart';
import 'package:appathon/providers/user_provider.dart';
import 'package:appathon/providers/vendor_provider.dart';
import 'package:appathon/routes.dart';
import 'package:appathon/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => VendorProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Agro App',
      onGenerateRoute: ((settings) => generateRoute(settings)),

      // Initial screen when app starts
      home: const SplashScreen()
    );
  }
}
