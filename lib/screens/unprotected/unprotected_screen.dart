import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UnProtectedScreen extends StatelessWidget {
  static final String screenName = (UnProtectedScreen).toString();

  final String someId;

  const UnProtectedScreen({
    required this.someId,
    super.key,
  });

  UnProtectedScreen.fromState(final GoRouterState state, {Key? key}): this(
    someId: state.pathParameters["someId"] as String,
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("UnProtected Screen")),
      body: Center(
        child: Text("UnProtected Content: $someId"),
      ),
    );
  }
}
