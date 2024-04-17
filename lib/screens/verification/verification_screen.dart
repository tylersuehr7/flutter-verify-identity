import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerificationScreen extends StatelessWidget {
  static final String screenName = (VerificationScreen).toString();

  final VerificationScreenArgs args;

  const VerificationScreen(this.args, {super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 128.0,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Verify Identity",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 2.0),
                Text(
                  "Please verify your identity before proceeding",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: context.pop, child: const Text("Cancel")),
            FilledButton(onPressed: () {
              // TODO: perform verification here
              context.replace(args.location, extra: args.extra);
            }, child: const Text("Verify")),
          ],
        )
      ),
    );
  }
}

/// Arguments required for the verification screen.
final class VerificationScreenArgs {
  final String location;
  final Object? extra;

  const VerificationScreenArgs({
    required this.location,
    this.extra,
  });
}
