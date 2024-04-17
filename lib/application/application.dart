import 'package:demo_verify/screens/change_pin/change_pin_screen.dart';
import 'package:demo_verify/screens/home/home_screen.dart';
import 'package:demo_verify/screens/protected/protected_screen.dart';
import 'package:demo_verify/screens/unprotected/unprotected_screen.dart';
import 'package:demo_verify/screens/verification/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '_routes.dart';

final class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Identity Verification",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      routerConfig: router,
      builder: (final BuildContext context, final Widget? child) => child!,
    );
  }

  /// Runs this Flutter application.
  static void run() => runApp(const Application());
}
