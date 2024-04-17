part of '../set_pin_screen.dart';

class _DescriptionText extends StatelessWidget {
  const _DescriptionText();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      "Please set a 4-digit pin",
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black54),
    );
  }
}
