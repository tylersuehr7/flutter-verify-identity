part of '../home_screen.dart';

class _HomeListItemHeader extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final bool showDivider;

  const _HomeListItemHeader(this.label, {
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 10.0,
    ),
    this.showDivider = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDivider)
          const Divider(),
        Padding(
          padding: padding,
          child: Text(
            label,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
