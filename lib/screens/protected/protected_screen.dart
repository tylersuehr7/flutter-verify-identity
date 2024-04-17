import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProtectedScreen extends StatelessWidget {
  static final String screenName = (ProtectedScreen).toString();

  final String someId;

  const ProtectedScreen({
    required this.someId,
    super.key,
  });

  ProtectedScreen.fromState(final GoRouterState state, {Key? key}): this(
    someId: state.pathParameters["someId"] as String,
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Protected Screen")),
      body: Center(
        child: Text("Protected Content: $someId"),
      ),
    );
  }
}
