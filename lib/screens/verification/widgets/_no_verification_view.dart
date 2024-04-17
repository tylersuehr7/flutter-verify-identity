part of '../verification_screen.dart';

class _NoVerificationView extends StatelessWidget {
  const _NoVerificationView();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Text(
            "It seems like you haven't setup your pin yet!",
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 10.0),
          FilledButton(
            onPressed: () => context.replaceNamed(SetPinScreen.screenName),
            child: const Text("Setup Your Pin"),
          ),
        ],
      )
    );
  }
}
