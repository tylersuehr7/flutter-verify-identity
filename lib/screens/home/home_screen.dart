import 'package:demo_verify/screens/protected/protected_screen.dart';
import 'package:demo_verify/screens/unprotected/unprotected_screen.dart';
import 'package:demo_verify/utils/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'widgets/_home_list_item.dart';
part 'widgets/_home_list_item_header.dart';

class HomeScreen extends StatelessWidget {
  static final String screenName = (HomeScreen).toString();

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: SafeArea(
        child: ListView(
          children: [
            const _HomeListItemHeader("Routes"),
            _HomeListItem(
              "Open Normal Route",
              onTap: () => context.pushNamed(UnProtectedScreen.screenName, pathParameters: {"someId": "abc123"}),
            ),
            _HomeListItem(
              "Open Protected Route",
              onTap: () => context.verifyAndPushNamed(ProtectedScreen.screenName, pathParameters: {"someId": "abc123"}),
            ),
          ],
        ),
      ),
    );
  }
}
