part of '../verification_screen.dart';

class _VerificationPendingView extends StatelessWidget {
  final _VerificationPending state;

  const _VerificationPendingView(this.state);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextEditingController pinController = TextEditingController.fromValue(state.pin);
    return Column(
      children: [

        TextField(
          enabled: !state.isLoading,
          controller: pinController,
          keyboardType: const TextInputType.numberWithOptions(),
          textInputAction: TextInputAction.go,
          maxLength: 4,
          onChanged: (_) => context.read<_VerificationController>().setPin(pinController.value),
          onEditingComplete: () => context.read<_VerificationController>().setPin(pinController.value),
          decoration: const InputDecoration(
            hintText: "0000",
          ),
        ),

        if (state.failedAttempts > 0)
          Text(
            "${state.failedAttempts} failed attempt${state.failedAttempts == 1 ? '' : 's'}",
            style: theme.textTheme.labelSmall!.copyWith(color: Colors.red),
          ),

      ],
    );
  }
}
