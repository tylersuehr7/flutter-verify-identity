import 'package:demo_verify/domain/exceptions/missing_verification_settings_exception.dart';
import 'package:demo_verify/domain/exceptions/unable_to_verify_identity_exception.dart';
import 'package:demo_verify/domain/models/verification_settings.dart';
import 'package:demo_verify/domain/services/verification_service.dart';
import 'package:demo_verify/injection.dart';
import 'package:demo_verify/screens/set_pin/set_pin_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'controllers/_verification_controller.dart';
part 'widgets/_no_verification_view.dart';
part 'widgets/_verification_fatal_error_view.dart';
part 'widgets/_verification_pending_view.dart';

class VerificationScreen extends StatelessWidget {
  static final String screenName = (VerificationScreen).toString();

  final VerificationScreenArgs args;

  const VerificationScreen(this.args, {super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocProvider<_VerificationController>(
      create: (_) => _VerificationController()..initialize(),
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: context.pop, child: const Text("Cancel")),
              BlocConsumer<_VerificationController, _VerificationState>(
                listener: (context, state) {
                  if (state is _VerificationSuccess) {
                    // Redirect to given route when verified
                    context.replace(args.location, extra: args.extra);
                  } else if (state is _VerificationLockout) {
                    // Redirect back if not verified
                    const SnackBar snack = SnackBar(content: Text("Could not verify your identity!"));
                    ScaffoldMessenger.of(context).showSnackBar(snack);
                    context.pop();
                  }
                },
                builder: (context, state) => FilledButton(
                  onPressed: state.isSubmitButtonDisabled ? null : () {
                    context.read<_VerificationController>().verify();
                  },
                  child: const Text("Verify"),
                ),
              ),
            ],
          ),
        ),
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
                  const SizedBox(height: 20.0),
                  BlocBuilder<_VerificationController, _VerificationState>(
                    builder: (context, state) => switch(state) {
                      _VerificationFatalError() => _VerificationFatalErrorView(state.reason),
                      _VerificationPending() => _VerificationPendingView(state),
                      _NoVerificationSettings() => const _NoVerificationView(),
                      _VerificationLockout() => const SizedBox.shrink(),
                      _ => const CircularProgressIndicator(),
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
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
